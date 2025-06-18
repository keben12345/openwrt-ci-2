sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.5.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/luci2/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/base-files/luci2/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
sed -i '/openwrt_release/d' package/lean/default-settings/files/zzz-default-settings
sed -i '/tencent.com/d' package/lean/default-settings/files/zzz-default-settings
sed -i '/shadow/d' package/lean/default-settings/files/zzz-default-settings

mv $GITHUB_WORKSPACE/patch/lean/199-diy-wifi.sh package/base-files/files/etc/uci-defaults/zz-diy.sh
# sed -i 's/0x0580000 0x7280000/0x580000 0x1cc00000/g' target/linux/mediatek/dts/mt7986a-netcore-n60-pro.dts

rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git  package/luci-app-argon-config
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

if grep -q "openclash=y" "$GITHUB_WORKSPACE/$CONFIG_FILE"; then
    git clone --depth 1 -b core https://github.com/vernesong/OpenClash.git  package/openclash-core
    tar -zxf package/openclash-core/master/meta/clash-linux-arm64.tar.gz -C package/base-files/files/etc/
    mv package/base-files/files/etc/clash package/base-files/files/etc/my-clash
    rm -rf package/openclash-core
fi

# mv $GITHUB_WORKSPACE/patch/QINGYIN/QINGYINSSIDMAC1.sh package/base-files/files/etc/init.d/QINGYINSSIDMAC1.sh
# mv $GITHUB_WORKSPACE/patch/QINGYIN/lede-10_system.js feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js

find ./ | grep Makefile | grep oaf | xargs rm -f
rm -rf feeds/packages/net/open-app-filter
git clone --depth 1 https://github.com/destan19/OpenAppFilter.git  package/oaf
git clone --depth 1 https://github.com/sirpdboy/luci-app-parentcontrol package/luci-app-parentcontrol
git clone --depth 1 https://github.com/lwb1978/openwrt-gecoosac.git package/openwrt-gecoosac

rm -rf feeds/packages/lang/golang
git clone --depth 1 https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang
git clone --depth 1 https://github.com/fw876/helloworld.git package/helloworld
git clone --depth 1 https://github.com/vernesong/OpenClash.git  package/openclash
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/passwall-packages
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall.git package/luci-app-passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2.git package/luci-app-passwall2

# iStore
git clone --depth 1 -b main https://github.com/linkease/istore.git package/istore
git clone --depth 1 -b master https://github.com/linkease/nas-packages.git package/nas-packages
git clone --depth 1 -b main https://github.com/linkease/nas-packages-luci.git package/nas-luci
mv package/nas-packages/network/services/* package/nas-packages/
rm -rf package/nas-packages/network

#find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
#find ./ | grep Makefile | grep mosdns | xargs rm -f
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns

rm -rf feeds/packages/net/{chinadns-ng,dns2socks,geoview,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev}
rm -rf feeds/packages/net/{simple-obfs,sing-box,tcping,trojan-plus,tuic-client,v2ray-geodata,v2ray-plugin,xray-core,xray-plugin}
rm -rf feeds/packages/net/{dns2socks-rust,dns2tcp,dnsproxy,gn,redsocks2,shadow-tls,trojan,v2ray-core}
rm -rf feeds/packages/net/{adguardhome,mosdns,lucky,tailscale}
rm -rf feeds/luci/applications/{luci-app-alist,luci-app-lucky,luci-app-tailscale}
git clone --depth 1 https://github.com/kenzok8/small-package.git package/kz8-small
mv package/kz8-small/adguardhome package/adguardhome
mv package/kz8-small/luci-app-adguardhome package/luci-app-adguardhome
mv package/kz8-small/lucky package/lucky
mv package/kz8-small/luci-app-lucky package/luci-app-lucky
mv package/kz8-small/luci-app-wrtbwmon package/luci-app-wrtbwmon
mv package/kz8-small/wrtbwmon package/wrtbwmon
mv package/kz8-small/luci-app-tailscale package/luci-app-tailscale
mv package/kz8-small/tailscale package/tailscale
rm -rf package/kz8-small
