# 修改默认IP，主机名，WiFi名称
sed -i 's/192.168.1.1/192.168.13.1/g' package/base-files/files/bin/config_generate
sed -i 's/r1.2/v24.5.15/g' package/emortal/default-settings/files/99-default-settings
sed -i 's/OpenWRT/OpenWrt/g' package/emortal/default-settings/files/99-default-settings
