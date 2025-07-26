#!/bin/sh

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

uci commit

uci del network.wan6
uci del network.lan.ip6assign
uci del network.globals.ula_prefix
uci del dhcp.lan.dhcpv6
uci del dhcp.lan.ndp
uci del dhcp.lan.ra

uci commit dhcp
uci commit network

#uci set wireless.default_MT7981_1_1.ssid=xiaoguo
uci set wireless.default_MT7981_1_1.encryption=psk2+ccmp
uci set wireless.default_MT7981_1_1.key=12345678

#uci set wireless.default_MT7981_1_2.ssid=TK888
uci set wireless.default_MT7981_1_2.encryption=psk2+ccmp
uci set wireless.default_MT7981_1_2.key=12345678
uci commit wireless
#uci commit

mymac=$(cat /sys/class/net/br-lan/address 2>/dev/null | awk -F: '{print $5 $6}' | tr 'a-z' 'A-Z')
num=20
wifipassword=12345678
ipc=101

# 生成配置
for i in $(seq 1 $num); do
    wifinet_num=$((i + 1))
    new_c=$((ipc + i -1))
    ipaddr="192.168.${new_c}.1"

    # 根据序号选择wireless设备
    if [ $i -le 15 ]; then
        wireless_dev="MT7981_1_2"
		network_dev="rax${i}"
    else
        wireless_dev="MT7981_1_1"
		network_dev="ra$((i - 15))"
    fi

    # 配置无线接口
    uci set wireless.wifinet${wifinet_num}=wifi-iface
    uci set wireless.wifinet${wifinet_num}.device="$wireless_dev"
    uci set wireless.wifinet${wifinet_num}.mode='ap'
    uci set wireless.wifinet${wifinet_num}.ssid="wifi-${i}"
    uci set wireless.wifinet${wifinet_num}.encryption='psk2+ccmp'
    uci set wireless.wifinet${wifinet_num}.key="$wifipassword"
    # uci set wireless.wifinet${wifinet_num}.ifname="ap${i}"
    uci set wireless.wifinet${wifinet_num}.network="wifi${i}"

    # 配置网络接口
    uci set network.wifi${i}=interface
    uci set network.wifi${i}.proto='static'
    uci set network.wifi${i}.device="${network_dev}"
    uci set network.wifi${i}.ipaddr="$ipaddr"
    uci set network.wifi${i}.netmask='255.255.255.0'

    # 配置DHCP
    uci set dhcp.wifi${i}=dhcp
    uci set dhcp.wifi${i}.interface="wifi${i}"

    # 配置防火墙
    uci add firewall zone
    uci set firewall.@zone[-1].name="wifi${i}"
    uci set firewall.@zone[-1].input='ACCEPT'
    uci set firewall.@zone[-1].output='ACCEPT'
    uci set firewall.@zone[-1].forward='ACCEPT'
    uci add_list firewall.@zone[-1].network="wifi${i}"
    uci add firewall forwarding
    uci set firewall.@forwarding[-1].src="wifi${i}"
    uci set firewall.@forwarding[-1].dest='wan'
    
    uci add firewall rule
    uci set firewall.@rule[-1].src="wifi${i}"
    uci set firewall.@rule[-1].dest='wan'
    uci set firewall.@rule[-1].name="wifi${i}"
    uci add_list firewall.@rule[-1].proto='all'
    uci set firewall.@rule[-1].target='REJECT'
done

# 提交配置
uci commit wireless
uci commit network
uci commit dhcp
uci commit firewall


sed -i 's/root::0:0:99999:7:::/root:$1$iOzd6YV5$fFw/2Cd.2prhGTiuCPCj0.:0:0:99999:7:::/g' /etc/shadow
sed -i 's/root:::0:99999:7:::/root:$1$iOzd6YV5$fFw/2Cd.2prhGTiuCPCj0.:0:0:99999:7:::/g' /etc/shadow

cp /etc/my-clash /etc/openclash/core/clash_meta

/etc/init.d/network restart >/dev/null 2>&1
/etc/init.d/firewall restart >/dev/null 2>&1
/etc/init.d/dnsmasq restart >/dev/null 2>&1
/etc/init.d/dropbear restart >/dev/null 2>&1

exit 0
