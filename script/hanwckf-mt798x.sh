sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.6.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/RAX3000M/g' package/base-files/files/bin/config_generate
#sed -i "s/ImmortalWrt/WiFi6/g" package/mtk/applications/mtwifi-cfg/files/mtwifi.sh

mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
mv $GITHUB_WORKSPACE/patch/hanwckf/mtwifi.sh package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
mv $GITHUB_WORKSPACE/patch/hanwckf/23_def package/base-files/files/etc/uci-defaults/23_def

#红米ax6000改512MB闪存
#sed -i 's/reg = <0x600000 0x6e00000>/reg = <0x600000 0x1ea00000>/g' target/linux/mediatek/files-5.4/arch/arm64/boot/dts/mediatek/mt7986a-xiaomi-redmi-router-ax6000.dts

#安装最新openclash
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth=1 https://github.com/vernesong/OpenClash.git  package/openclash
mv package/openclash/luci-app-openclash feeds/luci/applications/
rm -rf package/openclash

#下载5g模块
git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh-cn/modem.po
sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh_Hans/modem.po
#sed -i 's/\"network\"/\"modem\"/g' package/5g-modem/luci-app-modem/luasrc/controller/modem.lua

# iStore
git clone --depth=1 https://github.com/xiangfeidexiaohuo/extra-ipk.git package/extra-ipk
mv package/extra-ipk/linkease package/linkease
rm -rf package/extra-ipk

git clone --depth=1 https://github.com/gdy666/luci-app-lucky.git package/luci-app-lucky
git clone --depth=1 https://github.com/kenzok8/small-package.git package/small-package
mv package/small-package/luci-app-adguardhome package/luci-app-adguardhome
mv package/small-package/luci-app-ikoolproxy package/luci-app-ikoolproxy
mv package/small-package/homebox package/homebox
mv package/small-package/luci-app-netspeedtest package/luci-app-netspeedtest
#mv package/small-package/luci-app-alist package/luci-app-alist
#mv package/small-package/alist package/alist
#rm -rf feeds/packages/net/alist
#rm -rf feeds/luci/applications/luci-app-alist
rm -rf package/small-package

git clone --depth=1 https://github.com/coolsnowwolf/lede.git package/lede
mv package/lede/package/lean/luci-app-leigod-acc package/luci-app-leigod-acc
mv package/lede/package/lean/leigod-acc package/leigod-acc
rm -rf package/lede
