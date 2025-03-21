sed -i 's/192.168.1.1/192.168.13.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.13.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
#sed -i 's/ImmortalWrt/X86/g' package/base-files/files/bin/config_generate
#mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
#mv $GITHUB_WORKSPACE/patch/glinet/199-diy.sh package/base-files/files/etc/uci-defaults/199-diy.sh
