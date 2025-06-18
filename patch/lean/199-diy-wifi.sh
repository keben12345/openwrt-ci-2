#!/bin/sh


# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

#uci set luci.main.mediaurlbase=/luci-static/design
#uci commit luci

uci commit

date_version=$(date +"%Y.%m.%d")
#sed -i '/DISTRIB_REVISION/d' /etc/openwrt_release
#echo "DISTRIB_REVISION='V${date_version}'" >> /etc/openwrt_release
#sed -i '/DISTRIB_DESCRIPTION/d' /etc/openwrt_release
#echo "DISTRIB_DESCRIPTION='OpenWrt '" >> /etc/openwrt_release

sed -i '/core/d' /etc/opkg/distfeeds.conf
sed -i '/smpackage/d' /etc/opkg/distfeeds.conf
sed -i 's#downloads.openwrt.org#mirror.nju.edu.cn/immortalwrt#g' /etc/opkg/distfeeds.conf
#sed -i 's#24.10.0/packages/aarch64_cortex-a53/luci#18.06-k5.4-SNAPSHOT/packages/aarch64_cortex-a53/luci#g' /etc/opkg/distfeeds.conf

OPENCLASH_FILE="/etc/config/openclash"
if [ -f "$OPENCLASH_FILE" ]; then
    mv /etc/my-clash /etc/openclash/core/clash_meta
fi

#/etc/init.d/network restart

uci del network.wan6
uci del network.lan.ip6assign
uci del network.globals.ula_prefix
uci del dhcp.lan.dhcpv6
uci del dhcp.lan.ndp
uci del dhcp.lan.ra

uci commit dhcp
uci commit network

#uci set wireless.default_radio0.ssid=xiaoguo
uci set wireless.default_radio0.encryption=psk2+ccmp
uci set wireless.default_radio0.key=12345678

#uci set wireless.default_radio1.ssid=TK888
uci set wireless.default_radio1.encryption=psk2+ccmp
uci set wireless.default_radio1.key=12345678
uci commit wireless
#uci commit

mymac=$(cat /sys/class/net/br-lan/address 2>/dev/null | awk -F: '{print $5 $6}' | tr 'a-z' 'A-Z')
num=30
wifipassword=12345678
ipc=11
for i in $(seq 1 $num); do
    wifinet_num=$((i + 1))
    new_c=$((c + i -1))
    ipaddr="192.168.${new_c}.1"

    # 根据序号选择wireless设备
    if [ $i -le 15 ]; then
        wireless_dev="radio1"
		network_dev="5Gap"
    else
        wireless_dev="radio0"
		network_dev="2.4Gap"
    fi

    # 配置无线接口
    uci set wireless.wifinet${wifinet_num}=wifi-iface
    uci set wireless.wifinet${wifinet_num}.device="$wireless_dev"
    uci set wireless.wifinet${wifinet_num}.mode='ap'
    uci set wireless.wifinet${wifinet_num}.ssid="${mymac}-WiFi-${i}"
    uci set wireless.wifinet${wifinet_num}.encryption='psk2+ccmp'
    uci set wireless.wifinet${wifinet_num}.key="$wifipassword"
    uci set wireless.wifinet${wifinet_num}.ifname="${network_dev}${i}"
    uci set wireless.wifinet${wifinet_num}.network="wifi${i}"

    # 配置网络接口
    uci set network.wifi${i}=interface
    uci set network.wifi${i}.proto='static'
    uci set network.wifi${i}.device="${network_dev}${i}"
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

uci commit wireless
uci commit network
uci commit dhcp
uci commit firewall

/etc/init.d/network restart >/dev/null 2>&1
/etc/init.d/firewall restart >/dev/null 2>&1
/etc/init.d/dnsmasq restart >/dev/null 2>&1
/etc/init.d/dropbear restart >/dev/null 2>&1

exit 0
