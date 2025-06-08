#!/bin/sh


# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

#其他网络设置
#uci set network.lan.ipaddr=192.168.23.1
#uci del network.lan.ip6assign
#uci commit network

#uci del dhcp.lan.ra
#uci del dhcp.lan.dhcpv6
#uci del dhcp.lan.ndp
#uci commit dhcp

uci del dhcp.lan.ra
uci del dhcp.lan.ra_slaac
uci del dhcp.lan.ra_flags
uci del dhcp.lan.dhcpv6
uci del dhcp.lan.dns_service
uci commit dhcp
uci del network.wan6
uci del network.lan.ip6assign
uci del network.globals.ula_prefix
uci commit network
uci commit

#uci set wireless.default_MT7981_1_1.ssid=xiaoguo
#uci set wireless.default_MT7981_1_1.encryption=psk2+ccmp
#uci set wireless.default_MT7981_1_1.key=a11223344.

#uci set wireless.default_MT7981_1_2.ssid=TK888
#uci set wireless.default_MT7981_1_2.encryption=psk2+ccmp
#uci set wireless.default_MT7981_1_2.key=a11223344.
#uci commit wireless

uci commit

sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
sed -i 's#downloads.immortalwrt.org#mirrors.pku.edu.cn/immortalwrt#g' /etc/opkg/distfeeds.conf
#sed -i '$a src/gz kiddin9 https://dl.openwrt.ai/packages-24.10/aarch64_generic/kiddin9' /etc/opkg/customfeeds.conf

#sed -i 's/root::0:0:99999:7:::/root:$1$0kv2aZ4P$WkI.7M.V1N6WSEDahJwot.:0:0:99999:7:::/g' /etc/shadow
#sed -i 's/root:::0:99999:7:::/root:$1$0kv2aZ4P$WkI.7M.V1N6WSEDahJwot.:0:0:99999:7:::/g' /etc/shadow

#mv /etc/QINGYINSSIDMAC1.sh /etc/init.d/QINGYINSSIDMAC1.sh
#chmod a+rwx /etc/init.d/QINGYINSSIDMAC1.sh
/etc/init.d/network restart

exit 0
