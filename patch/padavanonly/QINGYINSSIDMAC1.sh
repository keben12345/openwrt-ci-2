#!/bin/bash /etc/rc.common
START=00

start() {
    # chmod +x /lib/QINGYINMAC.sh
    # /lib/QINGYINMAC.sh start
    # 定义MAC地址前缀数组
    prefixes=(
    "EC:01:33" "08:57:00" "F4:83:CD" "3C:6A:48" "CC:29:BD" "B0:8B:92" "14:3D:F2" "0C:9D:92" "34:CE:00" "50:D2:F5"
    "BC:5F:F6" "00:4B:F3" "00:5C:C2" "4C:77:66" "5C:DE:34" "34:47:D4" "BC:D1:77" "44:97:5A" "74:F8:DB" "6C:E8:73"
    "1C:56:FE" "9C:A2:F4" "7C:A2:3E" "50:1A:A5" "F0:9A:51" "58:F1:02" "B8:F8:83" "B8:69:C2" "00:5C:86" "00:90:5F"
    "F4:B8:A7" "E8:BD:D1" "D8:0B:CB" "B0:B1:94" "38:EB:47" "98:8B:0A" "FC:E3:3C" "6C:B1:58" "DC:D8:7C" "DC:84:E9"
    "60:3A:7C" "60:EE:5C" "AC:C1:EE" "40:31:3C" "B8:60:61" "88:36:CF" "C4:17:0E" "74:59:09" "74:22:BB" "3C:CD:5D"
    )
    # 获取前缀数组的长度
    prefix_length=${#prefixes[@]}
    # 生成一个随机数作为索引
    indexMAC=$((RANDOM % prefix_length))
    # 获取随机选择的前缀
    selected_prefix=${prefixes[$indexMAC]}
    # 生成随机的后缀部分
    random_suffix=$(hexdump -n3 -e '/1 ":%02x"' /dev/urandom)
    # 生成新的 MAC 地址
    NEW_MAC="${selected_prefix}${random_suffix}"
    chmod +x /lib/QINGYINMAC1.sh
    /lib/QINGYINMAC1.sh start $NEW_MAC
    array=("ZTE" "TP-Link" "Tenda" "Xiaomi" "ChinaNet" "360WiFi" "CMCC" "H3C" "ASUS" "CN" "Cisco" "MERCURY" "TOTOLINK" "Netgear" "rujie" "TP" "UBNT" "honor" "FAST" "CU" "HUAWEI" "Netcore" "LINKSYS" "Phicomm" "AFR" "D-Link")
    array_length=${#array[@]}
    index=$((RANDOM % array_length))
    random_string=${array[$index]}
    NEW_SSID5G1="${random_string}01_$(tr -dc 'A-F0-9' < /dev/urandom | head -c 6)_5G"
    index=$((RANDOM % array_length))
    random_string=${array[$index]}
    NEW_SSID5G2="${random_string}27_$(tr -dc 'A-F0-9' < /dev/urandom | head -c 6)"
    index=$((RANDOM % array_length))
    random_string=${array[$index]}
    NEW_SSID5G3="${random_string}28_$(tr -dc 'A-F0-9' < /dev/urandom | head -c 6)"
    index=$((RANDOM % array_length))
    random_string=${array[$index]}
    NEW_SSID5G4="${random_string}29_$(tr -dc 'A-F0-9' < /dev/urandom | head -c 6)"
    index=$((RANDOM % array_length))
    random_string=${array[$index]}
    NEW_SSID5G5="${random_string}30_$(tr -dc 'A-F0-9' < /dev/urandom | head -c 6)"
    # NEW_SSID24G="ZTE_$(cat /proc/sys/kernel/random/uuid | cut -c 25-)_30-2.4G"

    # 轻音：指定WiFi顺序生成
    uci set wireless.@wifi-iface[0].ssid="$NEW_SSID5G1"
    # uci set wireless.@wifi-iface[0].ssid="$NEW_SSID24G"
    uci set wireless.@wifi-iface[1].ssid="$NEW_SSID5G1"
    uci set wireless.@wifi-iface[2].ssid="$NEW_SSID5G2"
    uci set wireless.@wifi-iface[3].ssid="$NEW_SSID5G3"
    uci set wireless.@wifi-iface[4].ssid="$NEW_SSID5G4"
    uci set wireless.@wifi-iface[5].ssid="$NEW_SSID5G5"
    # 轻音:永久存储名称防止自动还原
    uci commit wireless
    # 轻音:重启SH服务即可生效！
    # /etc/init.d/network restart
    reboot
    # 轻音:再三提醒!!!
    # 轻音:再三提醒!!!
    # 轻音:再三提醒!!!
    # 轻音:以上代码切勿乱修改（如私自修改导致u-boot丢失软路由变砖概不负责）!!!
    # 轻音:以上代码切勿乱修改（如私自修改导致u-boot丢失软路由变砖概不负责）!!!
    # 轻音:以上代码切勿乱修改（如私自修改导致u-boot丢失软路由变砖概不负责）!!!
}