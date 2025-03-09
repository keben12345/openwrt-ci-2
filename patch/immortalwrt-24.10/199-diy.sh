#!/bin/sh

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

#其他网络设置

uci commit

sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
sed -i 's#downloads.immortalwrt.org#mirrors.nju.pku.cn/immortalwrt#g' /etc/opkg/distfeeds.conf

tar -zxf /etc/clash-linux-amd64.tar.gz -C /etc/openclash/core/
mv /etc/openclash/core/clash /etc/openclash/core/clash_meta
rm -rf /etc/clash-linux-amd64.tar.gz

#/etc/init.d/network restart

exit 0
