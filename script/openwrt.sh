sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")

mv $GITHUB_WORKSPACE/patch/imm21.02/199-diy package/base-files/files/etc/uci-defaults/199-diy.sh
