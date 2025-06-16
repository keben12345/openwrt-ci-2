sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/Router/g' package/base-files/files/bin/config_generate
sed -i "s/ImmortalWrt/WiFi/g" package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
mv $GITHUB_WORKSPACE/patch/hanwckf/199-diy.sh package/base-files/files/etc/uci-defaults/zz-diy.sh

#完全删除luci版本
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#mv $GITHUB_WORKSPACE/patch/hanwckf/10_system.js feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release

rm -rf feeds/packages/net/ddns-go
rm -rf feeds/luci/applications/luci-app-ddns-go
git clone --depth 1 https://github.com/5und4y2023/luci-app-ddns-go.git package/luci-app-ddns-go
