sed -i 's/192.168.6.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/AX6000/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/AX6000/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
mv $GITHUB_WORKSPACE/patch/banner $OPENWRT_PATH/package/base-files/files/etc/banner
mv $GITHUB_WORKSPACE/patch/m798x-23.05-padavanonly/defset $OPENWRT_PATH/package/emortal/default-settings/files/99-default-settings
chmod a+rwx package/emortal/default-settings/files/99-default-settings
sed -i 's#downloads.immortalwrt.org#mirror.nju.edu.cn/immortalwrt#g' package/emortal/default-settings/files/99-default-settings-chinese



#git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
#rm -rf feeds/packages/net/quectel-cm

rm -rf feeds/packages/lang/golang
git clone --depth=1 https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2.git package/passwall2
# git clone --depth=1 https://github.com/sbwml/luci-app-mosdns.git package/mosdns
# git clone --depth=1 https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome
# git clone --depth=1 https://github.com/fw876/helloworld.git package/ssr

# iStore
#git clone --depth=1 -b main https://github.com/linkease/istore.git package/istore
#git clone --depth=1 -b master https://github.com/linkease/nas-packages.git package/nas-packages
#git clone --depth=1 -b main https://github.com/linkease/nas-packages-luci.git package/nas-luci
#mv package/nas-packages/network/services/* package/nas-packages/
#rm -rf package/nas-packages/network
