#!/bin/sh

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

uci commit

sed -i '/modem/d' /etc/opkg/distfeeds.conf
sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
# sed -i 's#downloads.immortalwrt.org#mirrors.pku.edu.cn/immortalwrt#g' /etc/opkg/distfeeds.conf

> /etc/opkg/distfeeds.conf

sed -i '$a src/gz kmods https://mirrors.pku.edu.cn/immortalwrt/releases/24.10.2/targets/mediatek/filogic/kmods/6.6.93-1-2ccac7a75355327cb6dfb4df1ecb575e' /etc/opkg/distfeeds.conf
sed -i '$a src/gz immortalwrt_core https://mirrors.pku.edu.cn/immortalwrt/releases/24.10.2/targets/mediatek/filogic/packages' /etc/opkg/distfeeds.conf
sed -i '$a src/gz openwrt_base https://mirrors.pku.edu.cn/openwrt/releases/24.10.2/packages/aarch64_cortex-a53/base' /etc/opkg/distfeeds.conf
sed -i '$a src/gz openwrt_luci https://mirrors.pku.edu.cn/openwrt/releases/24.10.2/packages/aarch64_cortex-a53/luci' /etc/opkg/distfeeds.conf
sed -i '$a src/gz openwrt_packages https://mirrors.pku.edu.cn/openwrt/releases/24.10.2/packages/aarch64_cortex-a53/packages' /etc/opkg/distfeeds.conf
sed -i '$a src/gz openwrt_routing https://mirrors.pku.edu.cn/openwrt/releases/24.10.2/packages/aarch64_cortex-a53/routing' /etc/opkg/distfeeds.conf
sed -i '$a src/gz openwrt_telephony https://mirrors.pku.edu.cn/openwrt/releases/24.10.2/packages/aarch64_cortex-a53/telephony' /etc/opkg/distfeeds.conf

sed -i '$a src/gz kiddin9 https://dl.openwrt.ai/packages-24.10/aarch64_cortex-a53/kiddin9' /etc/opkg/customfeeds.conf


cp /etc/my-clash /etc/openclash/core/clash_meta


exit 0
