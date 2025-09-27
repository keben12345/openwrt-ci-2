#!/bin/sh

# 路由器cpu芯片
router_cpu=MT7981

# 新增WiFi数量
increase_wifi_num=10

# 除去默认，原本有几个WiFi
existed_wifi_num=0

# WiFi名称
ssid=AX3000

# WiFi密码
password=123456qwerty

# WiFi地址
ipaddr=10.10.1.1

############################### 分 割 线 ###################################

routermac=$(cat /sys/class/net/br-lan/address 2>/dev/null | awk -F: '{print $5 $6}' | tr 'a-z' 'A-Z')
a=$(echo "$ipaddr" | awk -F. '{print $1}')
b=$(echo "$ipaddr" | awk -F. '{print $2}')
c=$(echo "$ipaddr" | awk -F. '{print $3}')
d=$(echo "$ipaddr" | awk -F. '{print $4}')

# 判断新增WiFi数量是否超过了无线芯片的限制
total_wifi=$((increase_wifi_num + existed_wifi_num))
if [ $total_wifi -gt 30 ]; then
    echo "WiFi数量超过了无线芯片限制，请重新设置"
    exit 1 
fi


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

# 显示配置摘要
increase_5G-wifi_num=$((15 - existed_wifi_num))
increase_2.4G-wifi_num=$((total_wifi - 15))
if [ ${increase_2.4G-wifi_num} -gt 0]; then
    increase_2.4G-wifi_num=${increase_2.4G-wifi_num}
else
    increase_2.4G-wifi_num=0
fi
echo -e "\n\n--------------------------------------------"
echo "配置摘要："
echo "  WiFi数量: $total_wifi 个"
echo "  新增5G-WiFi数量: ${increase_5G-wifi_num} 个"
echo "  新增2.4G-WiFi数量: ${increase_2.4G-wifi_num} 个"
echo "  WiFi密码: $password"
echo "  IP地址段: ${a}.${b}.x.${d}（x从 ${c} 到 $total_wifi）"
echo "--------------------------------------------"

# 重启服务
echo -e "\n配置已完成！"
echo "正在重启网络服务使配置生效，请等待几秒"
/etc/init.d/network restart >/dev/null 2>&1
/etc/init.d/firewall restart >/dev/null 2>&1
/etc/init.d/dnsmasq restart >/dev/null 2>&1
/etc/init.d/dropbear restart >/dev/null 2>&1
