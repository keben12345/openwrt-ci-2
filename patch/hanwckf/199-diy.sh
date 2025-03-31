#!/bin/sh

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

uci commit

#sed -i 's/root::0:0:99999:7:::/root:$1$R43zhcLV$dwxtXXFI7TdIRcVKl.w3N1:20158:0:99999:7:::/g' /etc/shadow

OPENCLASH_FILE="/etc/config/openclash"
if [ -f "$OPENCLASH_FILE" ]; then
    tar -zxf /etc/clash-linux-arm64.tar.gz -C /etc/openclash/core/
    mv /etc/openclash/core/clash /etc/openclash/core/clash_meta
    rm -rf /etc/clash-linux-arm64.tar.gz
fi

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

/etc/init.d/network restart

exit 0
