sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate

# 添加kenzok8_small插件库, 编译新版Sing-box和hysteria，需golang版本1.20或者以上版本 ，可以用以下命令
rm -rf feeds/packages/lang/golang
git clone --depth=1 https://github.com/kenzok8/golang feeds/packages/lang/golang
#删除自带的ssr-plus，passwall
rm -rf feeds/luci/applications/{luci-app-passwall,luci-app-ssr-plus,luci-app-mosdns}
#下载安装kenzok8的small库
sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
./scripts/feeds update -a
./scripts/feeds install -a
#新版ssr-libev和ss-rust缺少依赖，所以延用旧版，删除新版
rm -rf feeds/small/shadowsocks-rust
rm -rf feeds/small/shadowsocksr-libev

#安装最新openclash
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth=1 https://github.com/vernesong/OpenClash.git  package/openclash
mv package/openclash/luci-app-openclash feeds/luci/applications/
rm -rf package/openclash
