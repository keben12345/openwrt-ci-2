#!/bin/sh

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

uci commit

# uci del network.wan6
uci set network.lan.ip6assign=64
uci del network.globals.ula_prefix
uci set dhcp.lan.dns_service='0'
uci del dhcp.lan.dhcpv6
uci del dhcp.lan.ndp
uci set dhcp.lan.ra='server'
uci del dhcp.lan.ra_flags
uci add_list dhcp.lan.ra_flags='none'
uci set network.lan.delegate='0'
uci set network.lan.ip6ifaceid='random'

uci commit dhcp
uci commit network
uci commit

#uci set wireless.default_MT7981_1_1.ssid=xiaoguo
#uci set wireless.default_MT7981_1_1.encryption=psk2+ccmp
#uci set wireless.default_MT7981_1_1.key=123456qwerty

#uci set wireless.default_MT7981_1_2.ssid=TK888
#uci set wireless.default_MT7981_1_2.encryption=psk2+ccmp
#uci set wireless.default_MT7981_1_2.key=123456qwerty
#uci commit wireless
uci commit

#sed -i 's/root::0:0:99999:7:::/root:$1$0kv2aZ4P$WkI.7M.V1N6WSEDahJwot.:0:0:99999:7:::/g' /etc/shadow
#sed -i 's/root:::0:99999:7:::/root:$1$0kv2aZ4P$WkI.7M.V1N6WSEDahJwot.:0:0:99999:7:::/g' /etc/shadow

OPENCLASH_FILE="/etc/config/openclash"
if [ -f "$OPENCLASH_FILE" ]; then
    mv /etc/my-clash /etc/openclash/core/clash_meta
fi

/etc/init.d/network restart

exit 0
