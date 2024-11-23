sed -i 's/192.168.6.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/AX3000/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/AX3000/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's/ImmortalWrt/AX3000/g' package/mtk/applications/luci-app-mtwifi-cfg/root/usr/share/luci-app-mtwifi-cfg/wireless-mtk.js
mv $GITHUB_WORKSPACE/patch/banner $OPENWRT_PATH/package/base-files/files/etc/banner
mv $GITHUB_WORKSPACE/patch/m798x-23.05-padavanonly/defset $OPENWRT_PATH/package/emortal/default-settings/files/99-default-settings
chmod a+rwx package/emortal/default-settings/files/99-default-settings
sed -i 's#downloads.immortalwrt.org#mirror.nju.edu.cn/immortalwrt#g' package/emortal/default-settings/files/99-default-settings-chinese

git clone --depth=1 https://github.com/fw876/helloworld.git package/helloworld
git clone --depth=1 https://github.com/kenzok8/small-package.git package/small-package
mv package/small-package/luci-app-adguardhome package/luci-app-adguardhome
#rm -rf feeds/packages/net/adguardhome
#mv package/small-package/adguardhome feeds/packages/net/adguardhome
rm -rf package/small-package

#git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
#rm -rf feeds/packages/net/quectel-cm

#rm -rf feeds/packages/lang/golang
#git clone --depth=1 https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang
#git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2.git package/passwall2
# git clone --depth=1 https://github.com/sbwml/luci-app-mosdns.git package/mosdns
# git clone --depth=1 https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome
# git clone --depth=1 https://github.com/fw876/helloworld.git package/ssr

# iStore
git clone --depth=1 https://github.com/xiangfeidexiaohuo/extra-ipk.git package/extra-ipk
mv package/extra-ipk/linkease package/linkease
rm -rf package/extra-ipk

