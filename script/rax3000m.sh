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

#原插件替换为immortalwrt的最新版
mkdir package/mypkg
git clone --depth=1 https://github.com/immortalwrt/luci.git package/imm-luci
git clone --depth=1 https://github.com/immortalwrt/packages.git package/imm-pkg
mv package/imm-luci/luci.mk  package/luci.mk
#ddns
rm -rf feeds/luci/applications/luci-app-ddns
rm -rf feeds/packages/net/{ddns-scripts,ddns-scripts_aliyun,ddns-scripts_dnspod}
mv package/imm-luci/luci-app-ddns feeds/luci/applications/luci-app-ddns
mv package/imm-pkg/ddns-scripts feeds/packages/net/ddns-scripts
mv package/imm-pkg/ddns-scripts_aliyun feeds/packages/net/ddns-scripts_aliyun
mv package/imm-pkg/ddns-scripts_dnspod feeds/packages/net/ddns-scripts_dnspod
#wireguard
rm -rf feeds/luci/protocols/luci-proto-wireguard
mv package/imm-luci/protocols/luci-proto-wireguard feeds/luci/protocols/luci-proto-wireguard
mv package/imm-luci/libs/luci-lib-uqr  feeds/luci/libs/luci-lib-uqr
mv package/imm-luci/contrib/package/ucode-mod-html feeds/luci/contrib/package/ucode-mod-html
mv package/imm-luci/contrib/package/ucode-mod-lua feeds/luci/contrib/package/ucode-mod-lua
#socat
rm -rf feeds/luci/applications/luci-app-socat
rm -rf feeds/packages/net/socat
mv package/imm-luci/luci-app-socat feeds/luci/applications/luci-app-socat
mv package/imm-pkg/net/socat feeds/packages/net/socat

rm -rf package/imm-luci
rm -rf package/imm-pkg

# git clone --depth=1 https://github.com/kiddin9/openwrt-packages.git  package/kiddin9
# rm -rf package/kiddin9
