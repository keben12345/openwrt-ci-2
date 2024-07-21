sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate

rm -rf feeds/packages/net/{microsocks,xray*,v2ray*,sing*}
rm -rf feeds/packages/utils/v2dat
sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
./scripts/feeds update -a
./scripts/feeds install -a
rm -rf feeds/small/luci-app-bypass
rm -rf feeds/small/luci-app-ssr-plus
# rm -rf feeds/packages/net/modemmanager
# rm -rf feeds/luci/protocols/luci-proto-modemmanager
# sed -i 's/qcom-msm8916-modem-openstick-ufi003-firmware //g' target/linux/msm89xx/image/msm8916.mk
