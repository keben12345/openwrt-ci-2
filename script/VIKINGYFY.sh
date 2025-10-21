# 修改默认IP，主机名
sed -i 's/192.168.1.1/192.168.13.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.13.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
#sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/HUAWEI/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/OpenWrt/g' include/version.mk


mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
mv $GITHUB_WORKSPACE/patch/ipq-vikingyfy/998-ipq60xx.sh package/base-files/files/etc/uci-defaults/998-ipq60xx.sh
#mv $GITHUB_WORKSPACE/patch/ipq-vikingyfy/998-ipq807x.sh package/base-files/files/etc/uci-defaults/998-ipq807x.sh

#完全删除luci版本
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release

sed -i 's/hybrid/server/g' target/linux/qualcommax/base-files/etc/uci-defaults/991_set-network.sh

#下载5g模块
#git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
#rm -rf feeds/packages/net/quectel-cm
#rm -rf feeds/packages/kernel/fibocom-qmi-wwan
#rm -rf feeds/packages/kernel/quectel-qmi-wwan
#rm -rf feeds/luci/protocols/luci-proto-quectel
#rm -rf feeds/nss_packages/wwan

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang
rm -rf feeds/luci/applications/{luci-app-passwall,luci-app-openclash}
rm -rf feeds/packages/net/{mosdns,v2ray-geodata}
git clone --depth 1 https://github.com/vernesong/OpenClash.git package/OpenClash
git clone --depth 1 https://github.com/nikkinikki-org/OpenWrt-nikki.git package/OpenWrt-nikki
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall.git package/passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2.git package/passwall2
git clone --depth 1 https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns


#git clone --depth 1 https://github.com/destan19/OpenAppFilter.git  package/oaf
#git clone --depth 1 https://github.com/kiddin9/kwrt-packages.git package/kwrt-packages
#mv package/kwrt-packages/uugamebooster package/uugamebooster
#mv package/kwrt-packages/luci-app-uugamebooster package/luci-app-uugamebooster
#mv package/kwrt-packages/luci-app-pushbot package/luci-app-pushbot
#rm -rf package/kwrt-packages

#sed -i "s/openwrt-\$(UU_ARCH)\/\$(PKG_VERSION)\/uu.tar.gz?/openwrt-\$(UU_ARCH)\/\$(PKG_VERSION)\//g" package/uugamebooster/Makefile
#sed -i "s/\$(PKG_NAME)-\$(UU_ARCH)-\$(PKG_VERSION).tar.gz/uu.tar.gz/g" package/uugamebooster/Makefile

#rm -rf feeds/packages/net/adguardhome
git clone --depth 1 https://github.com/kenzok8/small-package.git package/kz8-small
#mv package/kz8-small/adguardhome package/adguardhome
mv package/kz8-small/luci-app-adguardhome package/luci-app-adguardhome
mv package/kz8-small/luci-app-easymesh package/luci-app-easymesh
mv package/kz8-small/luci-app-onliner package/luci-app-onliner
mv package/kz8-small/luci-app-partexp package/luci-app-partexp
mv package/kz8-small/luci-app-pptp-server package/luci-app-pptp-server
mv package/kz8-small/luci-app-pushbot package/luci-app-pushbot
mv package/kz8-small/luci-app-wrtbwmon package/luci-app-wrtbwmon
mv package/kz8-small/wrtbwmon package/wrtbwmon
rm -rf package/kz8-small

#修改qca-nss-drv启动顺序
sed -i 's/START=.*/START=85/g' feeds/nss_packages/qca-nss-drv/files/qca-nss-drv.init
#修改qca-nss-pbuf启动顺序
sed -i 's/START=.*/START=86/g' package/kernel/mac80211/files/qca-nss-pbuf.init
#修复TailScale配置文件冲突
sed -i '/\/files/d'  feeds/packages/net/tailscale/Makefile
#rust报错
sed -i 's/ci-llvm=true/ci-llvm=false/g' feeds/packages/lang/rust/Makefile

#默认WiFi设置
#sed -i 's/OWRT/WiFi/g' target/linux/qualcommax/base-files/etc/uci-defaults/990_set-wireless.sh
#sed -i 's/12345678/123456qwerty/g' target/linux/qualcommax/base-files/etc/uci-defaults/990_set-wireless.sh
#sed -i '/BASE_WORD/d' target/linux/qualcommax/base-files/etc/uci-defaults/990_set-wireless.sh
#sed -i 's/psk2+ccmp/none/g' target/linux/qualcommax/base-files/etc/uci-defaults/990_set-wireless.sh
