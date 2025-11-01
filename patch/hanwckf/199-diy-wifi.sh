#!/bin/sh

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

uci commit

#cat /diy4me/rules-pw2 >> /etc/config/passwall2
#cat /diy4me/rules-pw2 >> /usr/share/passwall2/0_default_config
sed -i '/ssrp/d' /etc/opkg/distfeeds.conf
sed -i '/helloworld/d' /etc/opkg/distfeeds.conf
sed -i '/passwall/d' /etc/opkg/distfeeds.conf
sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
cp /etc/my-clash /etc/openclash/core/clash_meta

uci set wireless.MT7986_1_2.htmode='HE80'
uci set wireless.MT7986_1_2.channel='44'
uci set wireless.default_MT7986_1_1.encryption=psk2+ccmp
uci set wireless.default_MT7986_1_1.key=12345678
uci set wireless.default_MT7986_1_2.encryption=psk2+ccmp
uci set wireless.default_MT7986_1_2.key=12345678
# 路由器cpu芯片
router_cpu=MT7986

# 新增WiFi数量
increase_wifi_num=30

# 除去默认，原本有几个WiFi
existed_wifi_num=0

# WiFi名称
ssid=X60Pro

# WiFi密码
password=12345678

# WiFi地址
ipaddr=10.10.1.1

############################### 分 割 线 ###################################

routermac=$(cat /sys/class/net/br-lan/address 2>/dev/null | awk -F: '{print $5 $6}' | tr 'a-z' 'A-Z')
a=$(echo "$ipaddr" | awk -F. '{print $1}')
b=$(echo "$ipaddr" | awk -F. '{print $2}')
c=$(echo "$ipaddr" | awk -F. '{print $3}')
d=$(echo "$ipaddr" | awk -F. '{print $4}')

total_wifi=$((increase_wifi_num + existed_wifi_num))
# 生成配置
for i in $(seq $((existed_wifi_num + 1)) $total_wifi); do
    wifinet_num=$((i + 1))
    new_c=$((c + i - 1))
    new_ipaddr="${a}.${b}.${new_c}.${d}"

    # 格式化接口编号为两位数
    wifi_id=$(printf "%02d" $i)

    # 根据序号选择wireless设备
    if [ $i -le 15 ]; then
        wireless_dev="${router_cpu}_1_2"
        network_dev="rax${i}"
    else
        wireless_dev="${router_cpu}_1_1"
        network_dev="ra$((i - 15))"
    fi

    # 配置无线接口
    uci set wireless.wifinet${wifinet_num}=wifi-iface
    uci set wireless.wifinet${wifinet_num}.device="$wireless_dev"
    uci set wireless.wifinet${wifinet_num}.mode='ap'
    uci set wireless.wifinet${wifinet_num}.ssid="${ssid}-${wifi_id}"
    uci set wireless.wifinet${wifinet_num}.encryption='psk2+ccmp'
    uci set wireless.wifinet${wifinet_num}.key="$password"
    uci set wireless.wifinet${wifinet_num}.network="wifi${wifi_id}"

    # 配置网络接口
    uci set network.wifi${wifi_id}=interface
    uci set network.wifi${wifi_id}.proto='static'
    uci set network.wifi${wifi_id}.device="${network_dev}"
    uci set network.wifi${wifi_id}.ipaddr="$new_ipaddr"
    uci set network.wifi${wifi_id}.netmask='255.255.255.0'

    # 配置DHCP
    uci set dhcp.wifi${wifi_id}=dhcp
    uci set dhcp.wifi${wifi_id}.interface="wifi${wifi_id}"

    # 配置防火墙
    uci add firewall zone
    uci set firewall.@zone[-1].name="wifi${wifi_id}"
    uci set firewall.@zone[-1].input='ACCEPT'
    uci set firewall.@zone[-1].output='ACCEPT'
    uci set firewall.@zone[-1].forward='ACCEPT'
    uci add_list firewall.@zone[-1].network="wifi${wifi_id}"

    uci add firewall forwarding
    uci set firewall.@forwarding[-1].src="wifi${wifi_id}"
    uci set firewall.@forwarding[-1].dest='wan'

    uci add firewall rule
    uci set firewall.@rule[-1].src="wifi${wifi_id}"
    uci set firewall.@rule[-1].dest='wan'
    uci set firewall.@rule[-1].name="wifi${wifi_id}"
    uci add_list firewall.@rule[-1].proto='all'
    uci set firewall.@rule[-1].target='REJECT'
done

# 提交配置
uci commit wireless
uci commit network
uci commit dhcp
uci commit firewall

# 重启服务

/etc/init.d/network restart >/dev/null 2>&1
/etc/init.d/firewall restart >/dev/null 2>&1
/etc/init.d/dnsmasq restart >/dev/null 2>&1
/etc/init.d/dropbear restart >/dev/null 2>&1
