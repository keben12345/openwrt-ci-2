sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/AX6000/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/AX6000/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
mv $GITHUB_WORKSPACE/patch/banner $OPENWRT_PATH/package/base-files/files/etc/banner
sed -i 's/mirrors.vsean.net/mirror.nju.edu.cn/g' package/emortal/default-settings/files/99-default-settings-chinese
sed -i 's/openwrt/immortalwrt/g' package/emortal/default-settings/files/99-default-settings-chinese

#下载5g模块
#git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
#rm -rf feeds/packages/net/quectel-cm

rm -rf feeds/packages/lang/golang
git clone --depth=1 https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2.git package/passwall2
git clone --depth=1 https://github.com/sbwml/luci-app-mosdns.git package/mosdns
git clone --depth=1 https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome

