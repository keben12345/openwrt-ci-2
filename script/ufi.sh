sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate

# rm -rf feeds/packages/net/{microsocks,xray*,v2ray*,sing*}
# rm -rf feeds/packages/utils/v2dat
# sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
# ./scripts/feeds update -a
# ./scripts/feeds install -a
# rm -rf feeds/small/luci-app-bypass
# rm -rf feeds/small/luci-app-ssr-plus

rm -rf feeds/luci/applications/luci-app-dockerman
git clone --depth=1 https://github.com/immortalwrt/luci.git package/imm-luci
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall.git package/paswall-app
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/paswall-pkg
mkdir package/mypkg
mv package/imm-luci/luci.mk  package/luci.mk
mv package/imm-luci/applications/luci-app-dockerman feeds/luci/applications/luci-app-dockerman
mv package/imm-luci/applications/luci-app-cpufreq package/mypkg/luci-app-cpufreq
mv package/imm-luci/applications/luci-app-diskman package/mypkg/luci-app-diskman
mv package/imm-luci/applications/luci-app-homeproxy package/mypkg/luci-app-homeproxy
mv package/imm-luci/applications/luci-app-ramfree package/mypkg/luci-app-ramfree
rm -rf package/imm-luci
