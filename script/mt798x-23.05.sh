sed -i 's/192.168.6.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/AX6000/g' package/base-files/files/bin/config_generate
#sed -i 's/ImmortalWrt/AX3000/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#sed -i 's/ImmortalWrt/AX3000/g' package/mtk/applications/luci-app-mtwifi-cfg/root/usr/share/luci-app-mtwifi-cfg/wireless-mtk.js
sed -i "s/ImmortalWrt/AX6000/g" package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
mv $GITHUB_WORKSPACE/patch/banner $OPENWRT_PATH/package/base-files/files/etc/banner
mv $GITHUB_WORKSPACE/patch/m798x-23.05-padavanonly/defset $OPENWRT_PATH/package/emortal/default-settings/files/99-default-settings
chmod a+rwx package/emortal/default-settings/files/99-default-settings
sed -i 's#mirrors.vsean.net/openwrt#mirror.nju.edu.cn/immortalwrt#g' package/emortal/default-settings/files/99-default-settings-chinese

git clone --depth=1 https://github.com/fw876/helloworld.git package/helloworld
git clone --depth=1 https://github.com/kenzok8/small-package.git package/small-package
mv package/small-package/luci-app-adguardhome package/luci-app-adguardhome
#rm -rf feeds/packages/net/adguardhome
#mv package/small-package/adguardhome feeds/packages/net/adguardhome
mv package/small-package/luci-app-UUGameAcc package/luci-app-UUGameAcc
mv package/small-package/luci-app-ikoolproxy package/luci-app-ikoolproxy
rm -rf package/small-package

#下载5g模块
git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh-cn/modem.po
sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh_Hans/modem.po
sed -i 's/\"network\"/\"modem\"/g' package/5g-modem/luci-app-modem/luasrc/controller/modem.lua
rm -rf feeds/packages/net/quectel-cm
rm -rf feeds/packages/kernel/fibocom-qmi-wwan
rm -rf feeds/packages/kernel/quectel-qmi-wwan
rm -rf feeds/luci/protocols/luci-proto-quectel

rm -rf feeds/packages/lang/golang
git clone --depth=1 https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang
#git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2.git package/passwall2
#git clone --depth=1 https://github.com/sbwml/luci-app-mosdns.git package/mosdns
#git clone --depth=1 https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome
#git clone --depth=1 https://github.com/fw876/helloworld.git package/ssr

# iStore
git clone --depth=1 https://github.com/xiangfeidexiaohuo/extra-ipk.git package/extra-ipk
mv package/extra-ipk/linkease package/linkease
rm -rf package/extra-ipk

git clone --depth=1 https://github.com/coolsnowwolf/lede.git package/lede
mv package/lede/package/lean/luci-app-leigod-acc package/luci-app-leigod-acc
mv package/lede/package/lean/leigod-acc package/leigod-acc
rm -rf package/lede
