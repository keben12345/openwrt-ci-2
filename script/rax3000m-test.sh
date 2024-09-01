sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate

# 编译新版Sing-box和hysteria，需golang版本1.20或者以上版本 ，可以用以下命令
rm -rf feeds/packages/lang/golang
git clone --depth=1 https://github.com/kenzok8/golang feeds/packages/lang/golang
#删除自带的老旧依赖，ssr-plus，passwall
rm -rf feeds/packages/net/{brook,chinadns-ng,dns2socks,dns2tcp,gn,hysteria,ipt2socks,microsocks,naiveproxy}
rm -rf feeds/packages/net/{pdnsd-alt,simple-obfs,sing-box,ssocks,tcping,trojan*,tuic-client,v2ray*,xray*}
rm -rf feeds/packages/net/{shadowsocks-rust,shadowsocksr-libev}
rm -rf feeds/luci/applications/{luci-app-passwall,luci-app-ssr-plus,luci-app-vssr}
#下载passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall.git package/paswall-app
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/paswall-pkg

#安装最新openclash
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth=1 https://github.com/vernesong/OpenClash.git  package/openclash
mv package/openclash/luci-app-openclash feeds/luci/applications/
rm -rf package/openclash

sed -i '$a src-git imm-dev-luci https://github.com/immortalwrt/luci.git' feeds.conf.default
sed -i '$a src-git imm-dev-pkg https://github.com/immortalwrt/packages.git' feeds.conf.default
./scripts/feeds update -a
./scripts/feeds install -a
./scripts/feeds update -a
./scripts/feeds install -a
