sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate

rm -rf feeds/luci/applications/luci-app-dockerman

sed -i '$a src-git small https://github.com/kiddin9/openwrt-packages' feeds.conf.default
./scripts/feeds update -a
./scripts/feeds install -a
