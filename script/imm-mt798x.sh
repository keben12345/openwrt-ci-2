sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/AX6000/g' package/base-files/files/bin/config_generate
# sed -i 's/ImmortalWrt/AX6S/g' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

sed -i 's/mirrors.vsean.net/mirror.nju.edu.cn/g' package/emortal/default-settings/files/99-default-settings-chinese
sed -i 's/openwrt/immortalwrt/g' package/emortal/default-settings/files/99-default-settings-chinese
