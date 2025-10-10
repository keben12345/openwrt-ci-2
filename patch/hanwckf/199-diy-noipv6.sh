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
uci del dhcp.lan.ra_default
uci del dhcp.lan.ra_flags

uci commit dhcp
uci commit network

uci set wireless.default_MT7981_1_1.ssid=TK888
uci set wireless.default_MT7981_1_1.encryption=psk2+ccmp
uci set wireless.default_MT7981_1_1.key=TK888.5G

uci set wireless.default_MT7981_1_2.ssid=TK888-5G
uci set wireless.default_MT7981_1_2.encryption=psk2+ccmp
uci set wireless.default_MT7981_1_2.key=TK888.5G
uci commit wireless
uci commit

sed -i '/ssrp/d' /etc/opkg/distfeeds.conf
sed -i '/helloworld/d' /etc/opkg/distfeeds.conf
sed -i '/passwall/d' /etc/opkg/distfeeds.conf
sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
sed -i 's/root::0:0:99999:7:::/root:$1$CNK4mprA$vE7yGCQUF5jv7dSr2zuP20:0:0:99999:7:::/g' /etc/shadow
sed -i 's/root:::0:99999:7:::/root:$1$CNK4mprA$vE7yGCQUF5jv7dSr2zuP20:0:0:99999:7:::/g' /etc/shadow

cp /etc/my-clash /etc/openclash/core/clash_meta


/etc/init.d/network restart

exit 0
