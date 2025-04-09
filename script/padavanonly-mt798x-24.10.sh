sed -i 's/192.168.6.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/Router/g' package/base-files/files/bin/config_generate
sed -i "s/ImmortalWrt/WiFi/g" package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
sed -i 's#mirrors.vsean.net/openwrt#mirror.nju.edu.cn/immortalwrt#g' package/emortal/default-settings/files/99-default-settings-chinese
if grep -q "openclash=y" "$GITHUB_WORKSPACE/$CONFIG_FILE"; then
    git clone --depth 1 -b core https://github.com/vernesong/OpenClash.git  package/openclash-core
    mv package/openclash-core/master/meta/clash-linux-arm64.tar.gz package/base-files/files/etc/clash-linux-arm64.tar.gz
    rm -rf package/openclash-core
fi

mv $GITHUB_WORKSPACE/patch/padavanonly/199-diy.sh package/base-files/files/etc/uci-defaults/199-diy.sh
mv $GITHUB_WORKSPACE/patch/padavanonly/10_system.js feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
mv $GITHUB_WORKSPACE/patch/padavanonly/QINGYINSSIDMAC1.sh package/base-files/files/etc/QINGYINSSIDMAC1.sh
#完全删除luci版本
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release

# 添加kenzok8_small插件库, 编译新版Sing-box和hysteria，需golang版本1.20或者以上版本 ，可以用以下命令
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang
#删除自带的老旧依赖，ssr-plus，passwall
rm rm -rf feeds/packages/net/{chinadns-ng,dns2socks,dns2tcp,geoview,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-rust,shadowsocksr-libev,simple-obfs,sing-box,ssocks,tcping,trojan*,tuic-client,v2ray*,xray*,mosdns}
#rm -rf feeds/packages/devel/gn
rm -rf feeds/packages/utils/v2dat
rm -rf feeds/luci/applications/{luci-app-passwall,luci-app-mosdns}
find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/passwall-packages
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall.git package/luci-app-passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2.git package/luci-app-passwall2
git clone --depth 1 https://github.com/nikkinikki-org/OpenWrt-nikki.git package/nikki
#git clone --depth 1 https://github.com/fw876/helloworld.git package/helloworld

git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
#安装最新openclash
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth 1 https://github.com/vernesong/OpenClash.git  package/openclash
mv package/openclash/luci-app-openclash feeds/luci/applications/
rm -rf package/openclash
#git clone --depth 1 https://github.com/gdy666/luci-app-lucky.git package/luci-app-lucky
git clone --depth 1 https://github.com/AutoCONFIG/luci-app-rustdesk-server.git package/luci-app-rustdesk-server

rm -rf feeds/packages/net/{adguardhome,alist,tailscale}
git clone --depth 1 https://github.com/kenzok8/small-package.git package/small-package
mv package/small-package/adguardhome feeds/packages/net/adguardhome
mv package/small-package/luci-app-adguardhome package/luci-app-adguardhome
mv package/small-package/alist feeds/packages/net/alist
mv package/small-package/luci-app-alist package/luci-app-alist
mv package/small-package/luci-app-ikoolproxy package/luci-app-ikoolproxy
mv package/small-package/tailscale package/tailscale
mv package/small-package/luci-app-tailscale package/luci-app-tailscale
mv package/small-package/wrtbwmon package/wrtbwmon
mv package/small-package/luci-app-wrtbwmon package/luci-app-wrtbwmon
rm -rf package/small-package

#下载5g模块
git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
rm -rf feeds/packages/net/quectel-cm
rm -rf feeds/packages/kernel/fibocom-qmi-wwan
rm -rf feeds/packages/kernel/quectel-qmi-wwan
rm -rf feeds/luci/protocols/luci-proto-quectel

# iStore
git clone --depth 1 -b main https://github.com/linkease/istore.git package/istore
git clone --depth 1 -b master https://github.com/linkease/nas-packages.git package/nas-packages
git clone --depth 1 -b main https://github.com/linkease/nas-packages-luci.git package/nas-luci
mv package/nas-packages/network/services/* package/nas-packages/
rm -rf package/nas-packages/network

git clone --depth 1 -b openwrt-21.02 https://github.com/immortalwrt/luci.git package/imm21-luci
mv package/imm21-luci/applications/luci-app-accesscontrol package/luci-app-accesscontrol
#mv package/imm21-luci/applications/luci-app-filetransfer package/luci-app-filetransfer
mv package/imm21-luci/applications/luci-app-v2ray-server package/luci-app-v2ray-server
sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' package/luci-app-accesscontrol/Makefile
#sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' package/luci-app-filetransfer/Makefile
sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' package/luci-app-v2ray-server/Makefile
rm -rf package/imm21-luci
#git clone --depth 1 -b openwrt-23.05 https://github.com/immortalwrt/luci.git package/imm23-luci
#mv package/imm23-luci/applications/luci-app-accesscontrol package/luci-app-accesscontrol
#sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' package/luci-app-accesscontrol/Makefile
#rm -rf package/imm23-luci

git clone --depth 1 -b master https://github.com/coolsnowwolf/luci.git package/lean-luci
mv package/lean-luci/applications/luci-app-arpbind package/luci-app-arpbind
sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' package/luci-app-arpbind/Makefile
rm -rf package/lean-luci

## 修改DTS的ubi为490MB的0x1ea00000
#sed -i 's/reg = <0x600000 0x6e00000>/reg = <0x600000 0x1ea00000>/g' target/linux/mediatek/files-5.4/arch/arm64/boot/dts/mediatek/mt7986a-xiaomi-redmi-router-ax6000.dts
## 修改DTS的spi_nand的spi-max-frequency为52MHz，52000000
#sed -i 's/spi-max-frequency = <20000000>/spi-max-frequency = <52000000>/' target/linux/mediatek/files-5.4/arch/arm64/boot/dts/mediatek/mt7986a-xiaomi-redmi-router-ax6000.dts
#sed -i 's/reg = <0x600000 0x6e00000>/reg = <0x600000 0x1ea00000>/' target/linux/mediatek/files-5.4/arch/arm64/boot/dts/mediatek/mt7986a-xiaomi-redmi-router-ax6000.dts
