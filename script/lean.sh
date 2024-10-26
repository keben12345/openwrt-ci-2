sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate

mv $GITHUB_WORKSPACE/patch/lean/defset $OPENWRT_PATH/package/lean/default-settings/files/zzz-default-settings
mv $GITHUB_WORKSPACE/patch/banner $OPENWRT_PATH/package/base-files/files/etc/banner
sed -i "s/luci-theme-bootstrap/luci-theme-design/g" $(find ./feeds/luci/collections/ -type f -name "Makefile")

# 修改版本为编译日期
# date_version=$(date +"%y.%m.%d")
# orig_version=$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
# sed -i "s/${orig_version}/R${date_version} by5und4y/g" package/lean/default-settings/files/zzz-default-settings

# Clear the login password
# sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' openwrt/package/lean/default-settings/files/zzz-default-settings

# rm -rf feeds/packages/lang/golang
# git clone https://github.com/kenzok8/golang feeds/packages/lang/golang
# git clone --depth=1 https://github.com/kenzok8/small.git package/small
# rm -rf feeds/luci/applications/luci-app-mosdns
# rm -rf feeds/packages/net/{alist,adguardhome,mosdns,xray*,v2ray*,v2ray*,sing*}
# rm -rf feeds/packages/utils/v2dat
# rm -rf package/small/luci-app-bypass
# rm -rf feeds/luci/themes/luci-theme-argon
# rm -rf feeds/luci/applications/luci-app-argon-config

# git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon feeds/luci/themes/luci-theme-argon
# git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-app-argon-config feeds/luci/applications/luci-app-argon-config
