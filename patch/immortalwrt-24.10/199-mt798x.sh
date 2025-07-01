#!/bin/sh

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

#其他网络设置
uci set wireless.default_radio1.ssid=WiFi-$(cat /sys/class/ieee80211/phy0/macaddress|awk -F ":" '{print $5""$6 }' | tr 'a-z' 'A-Z')-5G
uci set wireless.default_radio0.ssid=WiFi-$(cat /sys/class/ieee80211/phy0/macaddress|awk -F ":" '{print $5""$6 }' | tr 'a-z' 'A-Z')-2.4G
uci set wireless.default_radio1.encryption='psk2+ccmp'
uci set wireless.default_radio0.encryption='psk2+ccmp'
uci set wireless.default_radio1.key='88888888'
uci set wireless.default_radio0.key='88888888'
uci commit wireless
uci commit

uci set wireless.wifinet2=wifi-iface
uci set wireless.wifinet2.device=radio1
uci set wireless.wifinet2.mode='ap'
uci set wireless.wifinet2.ssid='Tk001'
uci set wireless.wifinet2.encryption='psk2+ccmp'
uci set wireless.wifinet2.key='88888888'
uci set wireless.wifinet2.ifname='ap1'
uci set wireless.wifinet2.network='tk001'

# 配置网络接口
uci set network.tk001=interface
uci set network.tk001.proto='static'
uci set network.tk001.device='ap1'
uci set network.tk001.ipaddr='10.10.1.1'
uci set network.tk001.netmask='255.255.255.0'

# 配置DHCP
uci set dhcp.tk001=dhcp
uci set dhcp.tk001.interface='tk001'

# 配置防火墙
uci add firewall zone
uci set firewall.@zone[-1].name='tk001'
uci set firewall.@zone[-1].input='ACCEPT'
uci set firewall.@zone[-1].output='ACCEPT'
uci set firewall.@zone[-1].forward='ACCEPT'
uci add_list firewall.@zone[-1].network='tk001'
uci add firewall forwarding
uci set firewall.@forwarding[-1].src='tk001'
uci set firewall.@forwarding[-1].dest='wan'

uci add firewall rule
uci set firewall.@rule[-1].src='tk001'
uci set firewall.@rule[-1].dest='wan'
uci set firewall.@rule[-1].name='tk001'
uci add_list firewall.@rule[-1].proto='all'
uci set firewall.@rule[-1].target='REJECT'

# 提交配置
uci commit wireless
uci commit network
uci commit dhcp
uci commit firewall

sed -i '/modem/d' /etc/opkg/distfeeds.conf
sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
sed -i 's#downloads.immortalwrt.org#mirrors.pku.edu.cn/immortalwrt#g' /etc/opkg/distfeeds.conf
sed -i '$a src/gz kmods https://mirrors.pku.edu.cn/immortalwrt/releases/24.10.2/targets/mediatek/filogic/kmods/6.6.93-1-2ccac7a75355327cb6dfb4df1ecb575e' /etc/opkg/distfeeds.conf

OPENCLASH_FILE="/etc/openclash"
if [ -f "$OPENCLASH_FILE" ]; then
    mv /etc/my-clash /etc/openclash/core/clash_meta
fi

/etc/init.d/network restart >/dev/null 2>&1
/etc/init.d/firewall restart >/dev/null 2>&1
/etc/init.d/dnsmasq restart >/dev/null 2>&1
/etc/init.d/dropbear restart >/dev/null 2>&1

exit 0
