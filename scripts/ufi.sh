sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate

sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
./scripts/feeds update -a
./scripts/feeds install -a
rm -rf feeds/packages/net/{microsocks,xray*,v2ray*,sing*}
rm -rf feeds/packages/utils/v2dat
