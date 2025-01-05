sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")

mv $GITHUB_WORKSPACE/patch/ufi/feeds.conf.default $OPENWRT_PATH/feeds.conf.default
rm -rf feeds/luci/applications/luci-app-dockerman
mkdir package/mypkg
git clone --depth=1 -b openwrt-24.10 https://github.com/immortalwrt/luci.git package/imm-luci
mv package/imm-luci/luci.mk  package/luci.mk
mv package/imm-luci/applications/luci-app-cpufreq package/mypkg/luci-app-cpufreq
mv package/imm-luci/applications/luci-app-dockerman feeds/luci/applications/luci-app-dockerman
mv package/imm-luci/applications/luci-app-diskman package/mypkg/luci-app-diskman
mv package/imm-luci/applications/luci-app-ramfree package/mypkg/luci-app-ramfree
mv package/imm-luci/applications/luci-app-ramfree package/mypkg/luci-app-nps
rm -rf package/imm-luci

git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone --depth 1 https://github.com/vernesong/OpenClash.git  package/openclash
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall.git package/paswall-app
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/paswall-pkg

git clone --depth 1 https://github.com/kenzok8/small-package.git package/kz8-small
mv package/kz8-small/luci-app-adguardhome package/luci-app-adguardhome
mv package/kz8-small/luci-app-fileassistant package/luci-app-fileassistant
mv package/kz8-small/luci-app-ikoolproxy package/luci-app-ikoolproxy
mv package/kz8-small/luci-app-macvlan package/luci-app-macvlan
mv package/kz8-small/nps package/nps
mv package/kz8-small/luci-app-partexp package/luci-app-partexp
mv package/kz8-small/luci-app-wrtbwmon package/luci-app-wrtbwmon
mv package/kz8-small/wrtbwmon package/wrtbwmon
mv package/kz8-small/luci-app-webrestriction package/luci-app-webrestriction
rm -rf package/kz8-small
