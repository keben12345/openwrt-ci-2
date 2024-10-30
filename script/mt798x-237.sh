sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/rax3000m/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/rax3000m/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
mv $GITHUB_WORKSPACE/patch/banner $OPENWRT_PATH/package/base-files/files/etc/banner
mv $GITHUB_WORKSPACE/patch/m798x-closed/defset $OPENWRT_PATH/package/emortal/default-settings/files/99-default-settings
mv $GITHUB_WORKSPACE/patch/m798x-closed/key-build.pub $OPENWRT_PATH/package/istore/luci-app-store/luci/luci-app-store/src/key-build.pub

#安装最新openclash
#rm -rf feeds/luci/applications/luci-app-openclash
#git clone --depth=1 https://github.com/vernesong/OpenClash.git  package/openclash
#mv package/openclash/luci-app-openclash feeds/luci/applications/
#rm -rf package/openclash

#下载
git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem


sed -i 's/mirrors.vsean.net/mirror.nju.edu.cn/g' package/emortal/default-settings/files/99-default-settings-chinese
sed -i 's/openwrt/immortalwrt/g' package/emortal/default-settings/files/99-default-settings-chinese
