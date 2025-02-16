#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.

echo 'src-git smpackage https://github.com/kenzok8/small-package' >> feeds.conf.default

mkdir -p files/etc/openclash/core
wget -qO- https://raw.githubusercontent.com/vernesong/OpenClash/refs/heads/core/dev/meta/clash-linux-arm64.tar.gz | tar xOvz > files/etc/openclash/core/clash_meta
chmod +x files/etc/openclash/core/clash_meta
#wget -qO- https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat > files/etc/openclash/GeoIP.dat
#wget -qO- https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat > files/etc/openclash/GeoSite.dat

mkdir -p files/etc/config
wget -qO- https://raw.githubusercontent.com/sos801107/TP-Link-TL-XDR6086/refs/heads/main/etc/openclash > files/etc/config/openclash
wget -qO- https://raw.githubusercontent.com/sos801107/TP-Link-TL-XDR6086/refs/heads/main/etc/mosdns > files/etc/config/mosdns
wget -qO- https://raw.githubusercontent.com/sos801107/TP-Link-TL-XDR6086/refs/heads/main/etc/smartdns > files/etc/config/smartdns
