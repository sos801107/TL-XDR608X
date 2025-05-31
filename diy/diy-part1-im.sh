
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
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >> feeds.conf.default
echo 'src-git turboacc https://github.com/chenmozhijin/turboacc.git;luci' >> feeds.conf.default
#echo 'src-git turboaccpackage https://github.com/chenmozhijin/turboacc.git;package' >> feeds.conf.default
#echo 'src-git nftables https://github.com/fullcone-nat-nftables/nft-fullcone' >> feeds.conf.default

echo 'src-git appvlmcsd https://github.com/AutoCONFIG/luci-app-vlmcsd;master' >> feeds.conf.default

#echo 'src-git theme https://github.com/zijieKwok/istoreos-theme' >> feeds.conf.default
echo 'src-git theme https://github.com/sbwml/luci-theme-argon' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
#echo 'src-git kenzo https://github.com/xuanranran/openwrt-package' >> feeds.conf.default

#echo 'src-git kiddin9 https://github.com/kiddin9/kwrt-packages' >> feeds.conf.default

#mkdir -p files/etc/openclash/core
#wget -qO- https://raw.githubusercontent.com/vernesong/OpenClash/refs/heads/core/dev/meta/clash-linux-arm64.tar.gz | tar xOvz > files/etc/openclash/core/clash_meta
#chmod +x files/etc/openclash/core/clash_meta
#wget -qO- https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat > files/etc/openclash/GeoIP.dat
#wget -qO- https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat > files/etc/openclash/GeoSite.dat

mkdir -p files/etc/config
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/openclash > files/etc/config/openclash
#wget -qO- https://raw.githubusercontent.com/liandu2024/clash/refs/heads/main/main_router/openclash > files/etc/config/openclash
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/mosdns > files/etc/config/mosdns
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/smartdns > files/etc/config/smartdns

mkdir -p files/etc
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/opkg.conf > files/etc/opkg.conf
mkdir -p files/etc/opkg
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/distfeeds.conf > files/etc/opkg/distfeeds.conf
mkdir -p files/root
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/.profile > files/root/.profile
#mkdir -p files/lib/wifi
#wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/mac80211.uc > files/lib/wifi/mac80211.uc
#luci openwrt-24.10
#sed -i 's/coolsnowwolf\/luci/immortalwrt\/luci/g' ./feeds.conf.default
#sed -i 's/openwrt-23.05/openwrt-24.10/g' ./feeds.conf.default
