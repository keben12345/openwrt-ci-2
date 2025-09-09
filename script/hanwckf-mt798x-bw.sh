sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.5.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/TikTok/g' package/base-files/files/bin/config_generate
sed -i "s/ImmortalWrt/TikTok/g" package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
sed -i 's#mirrors.vsean.net/openwrt#mirror.nju.edu.cn/immortalwrt#g' package/emortal/default-settings/files/99-default-settings-chinese
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner

mv $GITHUB_WORKSPACE/patch/bw/hanwckf/zz-diy package/base-files/files/etc/uci-defaults/zz-diy.sh
mv $GITHUB_WORKSPACE/patch/bw/hanwckf/mtwifi.sh package/mtk/applications/mtwifi-cfg/files/mtwifi.sh

if grep -q "openclash=y" "$GITHUB_WORKSPACE/$CONFIG_FILE"; then
    git clone --depth 1 -b core https://github.com/vernesong/OpenClash.git  package/openclash-core
    tar -zxf package/openclash-core/master/meta/clash-linux-arm64.tar.gz -C package/base-files/files/etc/
    mv package/base-files/files/etc/clash package/base-files/files/etc/my-clash
    rm -rf package/openclash-core
fi
#完全删除luci版本
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release
mv $GITHUB_WORKSPACE/patch/bw/hanwckf/10_system.js feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js


# 添加kenzok8_small插件库, 编译新版Sing-box和hysteria，需golang版本1.20或者以上版本 ，可以用以下命令
rm -rf feeds/packages/lang/golang
git clone --depth 1 https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang
#删除自带的老旧依赖，ssr-plus，passwall
rm -rf feeds/packages/net/{mosdns,v2ray-geodata}
rm -rf feeds/luci/applications/{luci-app-openclash,luci-app-passwall,luci-app-ssr-plus,luci-app-mosdns}
git clone --depth 1 https://github.com/vernesong/OpenClash.git  package/openclash
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall.git package/luci-app-passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2.git package/luci-app-passwall2
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

#git clone --depth=1 https://github.com/gdy666/luci-app-lucky.git package/luci-app-lucky
git clone --depth 1 https://github.com/destan19/OpenAppFilter.git package/oaf
git clone --depth 1 https://github.com/sirpdboy/netspeedtest.git package/luci-app-netspeedtest

rm -rf feeds/packages/net/adguardhome
rm -rf feeds/packages/net/alist
rm -rf feeds/luci/applications/luci-app-alist
rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/applications/luci-app-smartdns
rm -rf feeds/packages/net/tailscale
git clone --depth 1 https://github.com/kenzok8/small-package.git package/small-package
mv package/small-package/luci-app-adguardhome package/luci-app-adguardhome
mv package/small-package/adguardhome feeds/packages/net/adguardhome
mv package/small-package/luci-app-easymesh package/luci-app-easymesh
mv package/small-package/luci-app-gecoosac package/luci-app-gecoosac
mv package/small-package/luci-app-smartdns package/luci-app-tailscale
mv package/small-package/smartdns feeds/packages/net/tailscale
mv package/small-package/luci-app-smartdns package/luci-app-smartdns
mv package/small-package/smartdns feeds/packages/net/smartdns
mv package/small-package/luci-app-ikoolproxy package/luci-app-ikoolproxy
rm -rf package/small-package

# iStore
git clone --depth 1 -b main https://github.com/linkease/istore.git package/istore
git clone --depth 1 -b master https://github.com/linkease/nas-packages.git package/nas-packages
git clone --depth 1 -b main https://github.com/linkease/nas-packages-luci.git package/nas-luci
mv package/nas-packages/network/services/* package/nas-packages/
rm -rf package/nas-packages/network

rm -rf feeds/packages/net/frp
git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/packages package/imm24pkg
mv package/imm24pkg/net/frp feeds/packages/net/frp
rm -rf package/imm24pkg

rm -rf feeds/luci/applications/luci-app-frpc
git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/luci package/imm24luci
mv package/imm24luci/applications/luci-app-frpc feeds/luci/applications/luci-app-frpc
rm -rf package/imm24luci

#git clone --depth 1 https://github.com/coolsnowwolf/lede.git package/lede
#mv package/lede/package/lean/luci-app-leigod-acc package/luci-app-leigod-acc
#mv package/lede/package/lean/leigod-acc package/leigod-acc
#rm -rf package/lede
