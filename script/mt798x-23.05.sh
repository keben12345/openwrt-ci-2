sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/AX6000/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/AX6000/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
mv $GITHUB_WORKSPACE/patch/banner $OPENWRT_PATH/package/base-files/files/etc/banner
mv $GITHUB_WORKSPACE/patch/m798x-23.05-padavanonly/defset $OPENWRT_PATH/package/emortal/default-settings/files/99-default-settings
chmod a+rwx package/emortal/default-settings/files/99-default-settings
sed -i 's#downloads.immortalwrt.org#mirror.nju.edu.cn/immortalwrt#g' package/emortal/default-settings/files/99-default-settings-chinese


#下载5g模块
#git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
#rm -rf feeds/packages/net/quectel-cm
