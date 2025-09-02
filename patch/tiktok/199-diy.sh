#!/bin/sh

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

uci commit

sed -i '/helloworld/d' /etc/opkg/distfeeds.conf
sed -i '/passwall/d' /etc/opkg/distfeeds.conf
sed -i '/modem/d' /etc/opkg/distfeeds.conf
sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
sed -i 's#downloads.immortalwrt.org#mirrors.pku.edu.cn/immortalwrt#g' /etc/opkg/distfeeds.conf
sed -i '/filogic/d' /etc/opkg/distfeeds.conf
sed -i '$a src/gz kmods https://mirrors.pku.edu.cn/immortalwrt/releases/24.10.2/targets/mediatek/filogic/kmods/6.6.93-1-2ccac7a75355327cb6dfb4df1ecb575e' /etc/opkg/distfeeds.conf
sed -i '$a src/gz immortalwrt_core https://mirrors.pku.edu.cn/immortalwrt/releases/24.10.2/targets/mediatek/filogic/packages' /etc/opkg/distfeeds.conf


cp /etc/my-clash /etc/openclash/core/clash_meta
chmod +x /root/open-wifi.sh

#uci set wireless.default_radio1.ssid=WiFi-$(cat /sys/class/ieee80211/phy0/macaddress|awk -F ":" '{print $5""$6 }' | tr 'a-z' 'A-Z')-5G
#uci set wireless.default_radio0.ssid=WiFi-$(cat /sys/class/ieee80211/phy0/macaddress|awk -F ":" '{print $5""$6 }' | tr 'a-z' 'A-Z')-2.4G
#uci commit wireless
#uci commit

#/etc/init.d/network restart >/dev/null 2>&1
exit 0
