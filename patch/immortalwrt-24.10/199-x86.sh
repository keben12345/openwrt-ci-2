#!/bin/sh

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

#其他网络设置

uci commit

sed -i '/passwall/d' /etc/opkg/distfeeds.conf
sed -i '/modem/d' /etc/opkg/distfeeds.conf
sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
sed -i 's#downloads.immortalwrt.org#mirrors.pku.edu.cn/immortalwrt#g' /etc/opkg/distfeeds.conf
sed -i '/x86/d' /etc/opkg/distfeeds.conf
sed -i '$a src/gz targets_packages https://mirrors.pku.edu.cn/immortalwrt/releases/24.10.3/targets/x86/64/packages' /etc/opkg/distfeeds.conf
sed -i '$a src/gz kmods https://mirrors.pku.edu.cn/immortalwrt/releases/24.10.3/targets/x86/64/kmods/6.6.104-1-615f744fa1708941b4ef00bdfd1271a9' /etc/opkg/distfeeds.conf
sed -i '$a #src/gz kiddin9 https://dl.openwrt.ai/packages-24.10/x86_64/kiddin9' /etc/opkg/customfeeds.conf

cp /etc/my-clash /etc/openclash/core/clash_meta

#uci set dhcp.lan.ignore='1'
#uci set network.lan.ipaddr='192.168.31.3'
#uci commit dhcp
#uci commit network
#uci commit
#/etc/init.d/network restart
#/etc/init.d/odhcpd restart

exit 0
