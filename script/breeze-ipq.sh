# 修改默认IP，主机名
sed -i 's/192.168.1.1/192.168.13.1/g' package/base-files/files/bin/config_generate
sed -i 's/LibWrt/OpenWrt/g' package/base-files/files/bin/config_generate
#默认WiFi设置
sed -i 's/LiBwrt/IPQ6000/g' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
# sed -i 's/encryption=none/encryption=psk2/g' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
# sed -i '214i\\t\t\tset wireless.default_${name}.key=123456qwerty' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# iStore
# git clone --depth=1 -b main https://github.com/linkease/istore.git package/istore
# git clone --depth=1 -b master https://github.com/linkease/nas-packages.git package/nas-packages
# git clone --depth=1 -b main https://github.com/linkease/nas-packages-luci.git package/nas-luci
# mv package/nas-packages/network/services/* package/nas-packages/
# rm -rf package/nas-packages/network

#下载5g模块
git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem

rm -rf feeds/packages/lang/ruby
git clone --depth=1 -b openwrt-23.05 --single-branch https://github.com/immortalwrt/packages.git package/immortal-pkg
mv package/immortal-pkg/lang/ruby feeds/packages/lang/ruby
rm -rf package/immortal-pkg

# git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/passwall-packages
# git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2.git package/passwall2
# git clone https://github.com/destan19/OpenAppFilter.git package/mypackage/OpenAppFilter
# mv package/small/chinadns-ng package/mypackage/
