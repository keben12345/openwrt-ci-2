#!/bin/sh


# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

#其他网络设置
#uci set network.lan.ipaddr=192.168.6.1
#uci del network.lan.ip6assign
#uci commit network
#uci del dhcp.lan.ra
#uci del dhcp.lan.dhcpv6
#uci del dhcp.lan.ndp
#uci commit dhcp

#uci set wireless.default_radio0.ssid=$(cat /sys/class/ieee80211/phy0/macaddress|awk -F ":" '{print $5""$6 }' | tr 'a-z' 'A-Z')-TikTok-2.4G
#uci set wireless.default_radio1.ssid=$(cat /sys/class/ieee80211/phy0/macaddress|awk -F ":" '{print $5""$6 }' | tr 'a-z' 'A-Z')-TikTok-5G
#uci set wireless.default_radio0.encryption=psk2+ccmp
#uci set wireless.default_radio1.encryption=psk2+ccmp
#uci set wireless.default_radio0.key=84131018
#uci set wireless.default_radio1.key=84131018
#uci commit wireless

uci commit

sed -i '/passwall/d' /etc/opkg/distfeeds.conf
sed -i '/filogic/d' /etc/opkg/distfeeds.conf
sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
sed -i 's#downloads.immortalwrt.org#mirrors.pku.edu.cn/immortalwrt#g' /etc/opkg/distfeeds.conf
sed -i '$a src/gz kmod https://mirror.nju.edu.cn/immortalwrt/releases/23.05.4/targets/mediatek/filogic/kmods/5.15.167-1-d024313b339f6a16c640db924eb57f35' /etc/opkg/distfeeds.conf
sed -i '$a src/gz others https://mirror.nju.edu.cn/immortalwrt/releases/23.05.4/targets/mediatek/filogic/packages' /etc/opkg/distfeeds.conf
#sed -i '$a src/gz kmod https://mirror.nju.edu.cn/immortalwrt/releases/23.05-SNAPSHOT/targets/mediatek/filogic/kmods/5.15.181-1-dab81cfed92fb4881f7b4fec9f787850' /etc/opkg/distfeeds.conf
#sed -i '$a src/gz kiddin9 https://dl.openwrt.ai/packages-24.10/aarch64_generic/kiddin9' /etc/opkg/customfeeds.conf

#sed -i 's/root::0:0:99999:7:::/root:$1$ODyHU5Rh$y1MlOS4gBVZD9K7Vvufv0.:0:0:99999:7:::/g' /etc/shadow
#sed -i 's/root:::0:99999:7:::/root:$1$ODyHU5Rh$y1MlOS4gBVZD9K7Vvufv0.:0:0:99999:7:::/g' /etc/shadow

cp /etc/my-clash /etc/openclash/core/clash_meta

# /etc/init.d/network restart

exit 0
