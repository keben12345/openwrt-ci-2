#!/bin/sh

. /lib/functions.sh
. /lib/functions/uci-defaults.sh
. /lib/functions/system.sh

# 定义 MAC 地址前 6 位的列表
mac_prefixes="EC:01:33 08:57:00 F4:83:CD 3C:6A:48 CC:29:BD B0:8B:92 14:3D:F2 0C:9D:92 34:CE:00 50:D2:F5
BC:5F:F6 00:4B:F3 00:5C:C2 4C:77:66 5C:DE:34 34:47:D4 BC:D1:77 44:97:5A 74:F8:DB 6C:E8:73
1C:56:FE 9C:A2:F4 7C:A2:3E 50:1A:A5 F0:9A:51 58:F1:02 B8:F8:83 B8:69:C2 00:5C:86 00:90:5F
F4:B8:A7 E8:BD:D1 D8:0B:CB B0:B1:94 38:EB:47 98:8B:0A FC:E3:3C 6C:B1:58 DC:D8:7C DC:84:E9
60:3A:7C 60:EE:5C AC:C1:EE 40:31:3C B8:60:61 88:36:CF C4:17:0E 74:59:09 74:22:BB 3C:CD:5D"

# 生成随机 MAC 地址，前 6 位从列表中选取
generate_random_mac() {
    local prefix=$(echo $mac_prefixes | tr ' ' '\n' | shuf -n 1)
    local suffix=$(hexdump -n3 -e '/1 ":%02x"' /dev/urandom)
    echo "$prefix$suffix"
}

mtk_facrory_write_mac()
{
    local part_name=$1
    local offset=$2
    local macaddr=$(generate_random_mac)
    local data=""

    part=$(find_mtd_part $part_name)
    if [ -n "$part" ] && [ -n "$macaddr" ]; then
        local i=1
        for x in ${macaddr//:/ }; do
            [ $i -gt 6 ] && break
            data=${data}"\x${x}"
            i=$((i+1))
        done
        dd if=$part of=/tmp/Factory.backup
        printf "${data}" | dd conv=notrunc of=/tmp/Factory.backup bs=1 seek=$((${offset}))
        mtd write /tmp/Factory.backup $part_name
        rm -rf /tmp/Factory.backup
    fi
}

mtk_facrory_write_mac_firmware()
{
    local offset=$1
    local macaddr=$(generate_random_mac)
    local data=""

    if [ -n "$macaddr" ]; then
        local i=1
        for x in ${macaddr//:/ }; do
            [ $i -gt 6 ] && break
            data=${data}"\x${x}"
            i=$((i+1))
        done
        printf "${data}" | dd conv=notrunc of=/lib/firmware/MT7981_iPAiLNA_EEPROM.bin bs=1 seek=$((${offset}))
    fi
}

case "$1" in
    "start")
        factory_mac=$(generate_random_mac)
        wifi_mac=$(generate_random_mac)
        mtk_facrory_write_mac ART 0 $(generate_random_mac)
        mtk_facrory_write_mac ART 6 $(generate_random_mac)
        mtk_facrory_write_mac Factory 4 $(generate_random_mac)
        mtk_facrory_write_mac_firmware 4 $(generate_random_mac)
        ;;
esac

exit 0
