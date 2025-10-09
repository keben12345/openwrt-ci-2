sed -i 's/192.168.1.1/192.168.10.5/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.10.5/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's#mirrors.vsean.net/openwrt#mirror.nju.edu.cn/immortalwrt#g' package/emortal/default-settings/files/99-default-settings-chinese
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner

mkdir -p package/base-files/files/diy4me
mv $GITHUB_WORKSPACE/patch/virtualhere/zz-diy.sh package/base-files/files/etc/uci-defaults/zz-diy.sh
mv $GITHUB_WORKSPACE/patch/virtualhere/vhusbdarm64 package/base-files/files/diy4me/vhusbdarm64
mv $GITHUB_WORKSPACE/patch/virtualhere/config.ini package/base-files/files/diy4me/virtualhere-config.ini

#完全删除luci版本,缩减luci长度
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release

