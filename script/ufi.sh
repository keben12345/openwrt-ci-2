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
mkdir package/mypkg
mv package/imm-luci/applications/luci-app-dockerman package/mypkg/
mv package/imm-luci/applications/luci-app-cpufreq package/mypkg/
mv package/imm-luci/applications/luci-app-diskman package/mypkg/
mv package/imm-luci/applications/luci-app-passwall package/mypkg/
mv package/imm-luci/applications/luci-app-homeproxy package/mypkg/
rm -rf package/imm-luci
