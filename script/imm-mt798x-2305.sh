sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.5.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
#sed -i 's/ImmortalWrt/Router/g' package/base-files/files/bin/config_generate
#sed -i 's/ImmortalWrt/WiFi/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
mv $GITHUB_WORKSPACE/patch/immortalwrt-23.05/199-diy.sh package/base-files/files/etc/uci-defaults/199-diy.sh

#完全删除luci版本
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release

# mv $GITHUB_WORKSPACE/patch/immortalwrt-23.05/10_system.js feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js

#红米ax6000改512m闪存
#sed -i 's/reg = <0x600000 0x6e00000>/reg = <0x600000 0x1ea00000>/' target/linux/mediatek/dts/mt7986a-xiaomi-redmi-router-ax6000.dts

# iStore
git clone --depth 1 -b main https://github.com/linkease/istore.git package/istore
git clone --depth 1 -b master https://github.com/linkease/nas-packages.git package/nas-packages
git clone --depth 1 -b main https://github.com/linkease/nas-packages-luci.git package/nas-luci
mv package/nas-packages/network/services/* package/nas-packages/
rm -rf package/nas-packages/network

if grep -q "openclash=y" "$GITHUB_WORKSPACE/$CONFIG_FILE"; then
    git clone --depth 1 -b core https://github.com/vernesong/OpenClash.git  package/openclash-core
    tar -zxf package/openclash-core/master/meta/clash-linux-arm64.tar.gz -C package/base-files/files/etc/
    mv package/base-files/files/etc/clash package/base-files/files/etc/my-clash
    rm -rf package/openclash-core
fi
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang
rm -rf feeds/packages/net/{mosdns,v2ray-geodata}
rm -rf feeds/luci/applications/{luci-app-passwall,luci-app-openclash}
#find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
#find ./ | grep Makefile | grep mosdns | xargs rm -f
git clone --depth 1 https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone --depth 1 https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

git clone --depth 1 https://github.com/vernesong/OpenClash.git package/OpenClash
git clone --depth 1 https://github.com/nikkinikki-org/OpenWrt-nikki.git package/OpenWrt-nikki
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall.git package/passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2.git package/passwall2


#rm -rf feeds/packages/lang/rust
#git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/packages package/immpkg
#mv package/immpkg/lang/rust feeds/packages/lang/rust
#rm -rf package/immpkg
