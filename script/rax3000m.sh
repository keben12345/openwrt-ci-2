sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
#sed -i 's/192.168.6.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/RAX3000M/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/RAX3000M/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#安装最新openclash
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth=1 https://github.com/vernesong/OpenClash.git  package/openclash
mv package/openclash/luci-app-openclash feeds/luci/applications/
rm -rf package/openclash

#下载5g模块
git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
