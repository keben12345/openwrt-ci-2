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
# sed -i '$a src/gz kmods https://mirrors.pku.edu.cn/immortalwrt/releases/24.10.1/targets/mediatek/filogic/kmods/6.6.86-1-f2c63d42896f12da2b55f2c2b626e7be' /etc/opkg/distfeeds.conf

#OPENCLASH_FILE="/etc/config/openclash"
#if [ -f "$OPENCLASH_FILE" ]; then
#    mv /etc/my-clash /etc/openclash/core/clash_meta
#fi

chmod 775 /etc/init.d/QINGYINSSIDMAC1.sh

#uci commit dhcp
#uci commit network
#uci commit
#/etc/init.d/network restart
#/etc/init.d/odhcpd restart

exit 0
