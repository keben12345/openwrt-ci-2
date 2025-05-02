sed -i 's/192.168.1.1/192.168.13.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.13.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/Router/g' package/base-files/files/bin/config_generate
sed -i "s/ImmortalWrt/WiFi/g" package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner

if grep -q "openclash=y" "$GITHUB_WORKSPACE/$CONFIG_FILE"; then
    git clone --depth 1 -b core https://github.com/vernesong/OpenClash.git  package/openclash-core
    tar -zxf package/openclash-core/master/meta/clash-linux-arm64.tar.gz -C package/base-files/files/etc/
    mv package/base-files/files/etc/clash package/base-files/files/etc/my-clash
    rm -rf package/openclash-core
fi

mv $GITHUB_WORKSPACE/patch/hanwckf/199-mydiy.sh package/base-files/files/etc/uci-defaults/zz-diy.sh
mv $GITHUB_WORKSPACE/patch/hanwckf/mtwifi.sh package/mtk/applications/mtwifi-cfg/files/mtwifi.sh

#完全删除luci版本
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#mv $GITHUB_WORKSPACE/patch/hanwckf/10_system.js feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release

#安装最新openclash
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth=1 https://github.com/vernesong/OpenClash.git  package/openclash
mv package/openclash/luci-app-openclash feeds/luci/applications/
rm -rf package/openclash

#sed -i '$a src-git ddnsgo https://github.com/sirpdboy/luci-app-ddns-go.git^aebe633d73045665253e03de5bf7a160f9133e3b' feeds.conf.default
rm -rf feeds/packages/net/ddns-go
rm -rf feeds/luci/applications/luci-app-ddns-go
git clone --depth 1 https://github.com/sirpdboy/luci-app-ddns-go.git package/luci-app-ddns-go
sed -i 's/6.8.0/6.8.1/g' package/luci-app-ddns-go/ddns-go/Makefile
sed -i 's/48522ad055a843dcd0e594f3c333334f5bfd112b8cc648b0708ae57b76c8de93/0588c8a0b95c7b7a079d4655a8d5e2897ca3258fea71570adc84441934d11ffb/g' package/luci-app-ddns-go/ddns-go/Makefile
sed -i 's/c68080bc1faba658ca8ed41ed8b9be500413cfa2/a0b54749579565af6019c06fd9bfd4e7790d403e/g' package/luci-app-ddns-go/ddns-go/Makefile
