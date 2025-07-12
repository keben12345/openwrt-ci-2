sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.5.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/luci2/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/base-files/luci2/bin/config_generate
#sed -i 's/LEDE/OpenWrt/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's/LEDE/TIKTOK/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
mv $GITHUB_WORKSPACE/patch/lean/199-diy package/base-files/files/etc/uci-defaults/zz-diy
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
sed -i '/openwrt_release/d' package/lean/default-settings/files/zzz-default-settings
sed -i '/shadow/d' package/lean/default-settings/files/zzz-default-settings
sed -i 's#mirrors.tencent.com/lede#mirrors.pku.edu.cn/immortalwrt#g' package/lean/default-settings/files/zzz-default-settings

#小米4a千兆版
# mv $GITHUB_WORKSPACE/patch/lean/dts/mt7621_xiaomi_mi-router-4a-3g-v2.dtsi target/linux/ramips/dts/mt7621_xiaomi_mi-router-4a-3g-v2.dtsi
# sed -i 's/14848/16064/g' target/linux/ramips/image/mt7621.mk

if grep -q "openclash=y" "$GITHUB_WORKSPACE/$CONFIG_FILE"; then
    git clone --depth 1 -b core https://github.com/vernesong/OpenClash.git  package/openclash-core
    tar -zxf package/openclash-core/master/meta/clash-linux-mipsle-softfloat.tar.gz -C package/base-files/files/etc/
    mv package/base-files/files/etc/clash package/base-files/files/etc/my-clash
    rm -rf package/openclash-core
fi

# 添加kenzok8_small插件库, 编译新版Sing-box和hysteria，需golang版本1.20或者以上版本 ，可以用以下命令
rm -rf feeds/packages/lang/golang
git clone --depth 1 https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang
#删除自带的老旧依赖，ssr-plus，passwall
rm -rf feeds/packages/net/{chinadns-ng,dns2socks,geoview,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev}
rm -rf feeds/packages/net/{simple-obfs,sing-box,tcping,trojan-plus,tuic-client,v2ray-geodata,v2ray-plugin,xray-core,xray-plugin}
rm -rf feeds/packages/net/{dns2socks-rust,dns2tcp,dnsproxy,gn,redsocks2,shadow-tls,trojan,v2ray-core}
#rm -rf feeds/packages/devel/gn
#rm -rf feeds/packages/utils/v2dat
rm -rf feeds/luci/applications/{luci-app-bypass，luci-app-passwall,luci-app-passwall2,luci-app-ssr-plus,luci-app-openclash,luci-app-mosdns}
git clone --depth 1 https://github.com/fw876/helloworld.git package/helloworld
sed -i 's/ShadowSocksR Plus+/Hello World/g' package/helloworld/luci-app-ssr-plus/po/zh_Hans/ssr-plus.po
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/passwall-packages
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall.git package/luci-app-passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2.git package/luci-app-passwall2
git clone --depth 1 https://github.com/vernesong/OpenClash.git  package/openclash

rm -rf feeds/packages/net/v2ray-geodata
rm -rf feeds/packages/net/mosdns
#find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
#find ./ | grep Makefile | grep mosdns | xargs rm -f
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
git clone https://github.com/sbwml/luci-app-mosdns -b v5-lua package/mosdns

git clone --depth 1 https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go
git clone --depth 1 https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter

# iStore
git clone --depth=1 -b main https://github.com/linkease/istore.git package/istore
git clone --depth=1 -b master https://github.com/linkease/nas-packages.git package/nas-packages
git clone --depth=1 -b main https://github.com/linkease/nas-packages-luci.git package/nas-luci
mv package/nas-packages/network/services/* package/nas-packages/
rm -rf package/nas-packages/network

#下载5g模块
#git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
#sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh-cn/modem.po
#sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh_Hans/modem.po

rm -rf feeds/luci/themes/luci-theme-argon
#git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon

rm -rf feeds/packages/net/adguardhome
git clone --depth 1 https://github.com/kenzok8/small-package.git package/kz8-small
mv package/kz8-small/adguardhome package/adguardhome
mv package/kz8-small/luci-app-adguardhome package/luci-app-adguardhome
mv package/kz8-small/luci-app-bypass package/luci-app-bypass
mv package/kz8-small/luci-app-easymesh package/luci-app-easymesh
mv package/kz8-small/luci-app-eqosplus package/luci-app-eqosplus
rm -rf package/kz8-small
#修复TailScale配置文件冲突
sed -i '/\/etc\/init\.d\/tailscale/d;/\/etc\/config\/tailscale/d;' feeds/packages/net/tailscale/Makefile
