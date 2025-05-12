#!/bin/sh

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

#其他网络设置

uci commit

sed -i '/modem/d' /etc/opkg/distfeeds.conf
sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
sed -i 's#downloads.immortalwrt.org#mirrors.pku.edu.cn/immortalwrt#g' /etc/opkg/distfeeds.conf
sed -i '$a src/gz kmods https://mirrors.pku.edu.cn/immortalwrt/releases/24.10.1/targets/x86/64/kmods/6.6.86-1-a99af258b23725bab7a4c5448b90efca' /etc/opkg/distfeeds.conf

OPENCLASH_FILE="/etc/config/openclash"
if [ -f "$OPENCLASH_FILE" ]; then
    mv /etc/my-clash /etc/openclash/core/clash_meta
fi

# 根据网卡数量配置网络
eth_count=0
for iface in /sys/class/net/*; do
  iface_name=$(basename "$iface")
  # 检查是否为物理网卡（排除回环设备和无线设备）
  if [ -e "$iface/device" ] && echo "$iface_name" | grep -Eq '^eth|^en'; then
    eth_count=$((eth_count + 1))
  fi
done
# 统计eth接口数量，大于1个则将eth0设为wan其它网口设为lan，只有1个则设置成DHCP模式
#eth_count=$(ls /sys/class/net | grep -c '^eth')
if [ $eth_count -gt 1 ]; then
#    uci set network.lan.ipaddr='192.168.23.1'

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
