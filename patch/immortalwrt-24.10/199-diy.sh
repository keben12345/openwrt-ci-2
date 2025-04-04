#!/bin/sh

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

#其他网络设置

uci commit

sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
sed -i 's#downloads.immortalwrt.org#mirrors.nju.pku.cn/immortalwrt#g' /etc/opkg/distfeeds.conf

OPENCLASH_FILE="/etc/config/openclash"
if [ -f "$OPENCLASH_FILE" ]; then
    tar -zxf /etc/clash-linux-amd64.tar.gz -C /etc/openclash/core/
    mv /etc/openclash/core/clash /etc/openclash/core/clash_meta
    rm -rf /etc/clash-linux-armmd.tar.gz
fi

# 统计eth接口数量，大于1个则将eth0设为wan其它网口设为lan，只有1个则设置成DHCP模式
eth_count=$(ls /sys/class/net | grep -c '^eth')
if [ $eth_count -gt 1 ]; then
    uci set network.lan.ipaddr='192.168.23.1'

    uci del dhcp.lan.ra_slaac
    uci del dhcp.lan.dhcpv6
    uci del dhcp.lan.ra_flags
    uci add_list dhcp.lan.ra_flags='none'
    uci set dhcp.lan.dns_service='0'

    uci del network.wan6
    uci del network.globals.packet_steering
    uci del network.globals.ula_prefix
    uci set network.lan.ip6assign='64'
    uci set network.lan.ip6ifaceid='eui64'

    uci set network.wan.device='eth0'
    uci del network.cfg030f15.ports
    ls /sys/class/net | awk '/^eth[0-9]+$/ && $0 != "eth0" {print "uci add_list network.cfg030f15.ports="$0}' | sh   
else
    uci set network.lan.proto='dhcp'
    uci set dhcp.lan.ignore='1'
fi

#ls /sys/class/net | grep -E '^eth[0-9]+$' | grep -v '^eth0$' | sed 's/^/uci add_list network.cfg030f15.ports=/' | sh

uci commit dhcp
uci commit network
uci commit
/etc/init.d/network restart
/etc/init.d/odhcpd restart

exit 0
