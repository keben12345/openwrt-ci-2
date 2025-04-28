#!/bin/sh

uci -q get system.@imm_init[0] > "/dev/null" || uci -q add system imm_init > "/dev/null"

if ! uci -q get system.@imm_init[0].system_chn > "/dev/null"; then
	uci -q batch <<-EOF
		set system.@system[0].timezone="CST-8"
		set system.@system[0].zonename="Asia/Shanghai"

		delete system.ntp.server
		add_list system.ntp.server="ntp.tencent.com"
		add_list system.ntp.server="ntp1.aliyun.com"
		add_list system.ntp.server="ntp.ntsc.ac.cn"
		add_list system.ntp.server="cn.ntp.org.cn"

		set system.@imm_init[0].system_chn="1"
		commit system
	EOF
fi

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

#其他网络设置
uci commit

sed -i '/modem/d' /etc/opkg/distfeeds.conf
sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
#sed -i 's#downloads.openwrt.org#mirrors.pku.edu.cn/openwrt#g' /etc/opkg/distfeeds.conf
sed -i '$a src/gz kmods http://downloads.openwrt.org/releases/24.10.0/targets/mediatek/filogic/kmods/6.6.73-1-d649d775435da5a8637f7a955a80d331' /etc/opkg/distfeeds.conf
sed -i '$a #src/gz opkg https://opkg.888608.xyz/openwrt-24.10/aarch64_cortex-a53' /etc/opkg/customfeeds.conf
sed -i 's/https/http/g' /etc/opkg/distfeeds.conf

OPENCLASH_FILE="/etc/config/openclash"
if [ -f "$OPENCLASH_FILE" ]; then
    mv /etc/my-clash /etc/openclash/core/clash_meta
fi

# wifi设置
uci set wireless.default_radio0.ssid=CUDY
uci set wireless.default_radio1.ssid=CUDY-5G
uci set wireless.default_radio0.encryption=psk2+ccmp
uci set wireless.default_radio1.encryption=psk2+ccmp
uci set wireless.default_radio0.key=XLNB6666
uci set wireless.default_radio1.key=XLNB6666
uci commit wireless
uci set network.lan.netmask='255.0.0.0'
uci commit network
uci commit

#uci commit dhcp
#uci commit network
#uci commit
/etc/init.d/network restart
#/etc/init.d/odhcpd restart

exit 0
