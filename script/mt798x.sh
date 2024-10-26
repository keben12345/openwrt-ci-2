sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/OpenWrt/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#安装最新openclash
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth=1 https://github.com/vernesong/OpenClash.git  package/openclash
mv package/openclash/luci-app-openclash feeds/luci/applications/
rm -rf package/openclash

# 添加其它插件
# git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon package/mypackage/luci-theme-argon
# git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config package/mypackage/luci-app-argon-config

# iStore
# git clone --depth=1 -b main https://github.com/linkease/istore.git package/mypackage/istore
# git clone --depth=1 -b master https://github.com/linkease/nas-packages.git package/mypackage/nas-packages
# git clone --depth=1 -b main https://github.com/linkease/nas-packages-luci.git package/mypackage/nas-luci
# mv package/mypackage/nas-packages/network/services/* package/mypackage/nas-packages/
# rm -rf package/mypackage/nas-packages/network
