#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
#补充汉化
echo -e "\nmsgid \"NAS\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
echo -e "msgstr \"存储\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
# 更改菜单名字
# echo -e "\nmsgid \"HomeProxy\"" >> feeds/luci/applications/luci-app-homeproxy/po/zh_Hans/homeproxy.po
# echo -e "msgstr \"科学代理\"" >> feeds/luci/applications/luci-app-homeproxy/po/zh_Hans/homeproxy.po

echo -e "\nmsgid \"UPnP\"" >> feeds/luci/applications/luci-app-upnp/po/zh_Hans/upnp.po
echo -e "msgstr \"即插即用\"" >> feeds/luci/applications/luci-app-upnp/po/zh_Hans/upnp.po

echo -e "\nmsgid \"Turbo ACC 网络加速\"" >> feeds/turboacc/luci-app-turboacc/po/zh-cn/turboacc.po
echo -e "msgstr \"网络加速\"" >> feeds/turboacc/luci-app-turboacc/po/zh-cn/turboacc.po

echo -e "\nmsgid \"Argon 主题设置\"" >> feeds/luci/applications/luci-app-argon-config/po/zh_Hans/tailscale.po
echo -e "msgstr \"主题设置\"" >> feeds/luci/applications/luci-app-argon-config/po/zh_Hans/tailscale.po

##清除默认密码password
#sed -i '/V4UetPzk$CYXluq4wUazHjmCDBCqXF/d' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
#修改WIFI名称
#sed -i "s/ssid='.*'/ssid='OpenWrt'/g" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
#修改WIFI密码
#sed -i "s/key='.*'/key='12345678'/g" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
#修改WIFI地区
#sed -i "s/country='.*'/country='CN'/g" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
#修改WIFI加密
#sed -i "s/encryption='.*'/encryption='psk2+ccmp'/g" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# 移除要替换的包
rm -rf feeds/small/{shadowsocksr-libev,shadowsocks-rust,luci-app-ssr-plus,luci-i18n-ssr-plus-zh-cn,luci-app-ssr-plus,luci-i18n-ssr-plus-zh-cn,luci-app-wol,luci-app-bypass}
rm -rf feeds/luci/applications/{shadowsocksr-libev,shadowsocks-rust,luci-app-ssr-plus,luci-i18n-ssr-plus-zh-cn,luci-app-ssr-plus,luci-i18n-ssr-plus-zh-cn,luci-app-wol,luci-app-bypass,luci-app-argon-config,luci-theme-argon}
rm -rf feeds/luci/packages/net/{shadowsocksr-libev-ssr-check,shadowsocksr-libev-ssr-local,shadowsocksr-libev-ssr-redir,shadowsocksr-libev-ssr-server,luci-app-argon-config,luci-theme-argon}
#rm -rf feeds/small/luci-app-ssr-plus
#rm -rf feeds/small/luci-i18n-ssr-plus-zh-cn
#rm -rf feeds/luci/applications/luci-app-ssr-plus
#rm -rf feeds/luci/applications/luci-i18n-ssr-plus-zh-cn
#rm -rf feeds/luci/applications/luci-app-wol
#rm -rf feeds/luci/packages/net/{shadowsocksr-libev-ssr-check,shadowsocksr-libev-ssr-local,shadowsocksr-libev-ssr-redir,shadowsocksr-libev-ssr-server}

# 将packages源的相关文件替换成passwall_packages源的
rm -rf feeds/packages/net/xray-core
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/v2ray-geodata
rm -rf feeds/packages/net/v2ray-geoip
rm -rf feeds/packages/net/sing-box
rm -rf feeds/packages/net/chinadns-ng
rm -rf feeds/packages/net/dns2socks
rm -rf feeds/packages/net/dns2tcp
rm -rf feeds/packages/net/microsocks
cp -r feeds/small/xray-core feeds/packages/net
cp -r feeds/small/mosdns feeds/packages/net
cp -r feeds/small/v2ray-geodata feeds/packages/net
cp -r feeds/small/v2ray-geoip feeds/packages/net
cp -r feeds/small/sing-box feeds/packages/net
cp -r feeds/small/chinadns-ng feeds/packages/net
cp -r feeds/small/dns2socks feeds/packages/net
cp -r feeds/small/dns2tcp feeds/packages/net
cp -r feeds/small/microsocks feeds/packages/net

rm -rf package/feeds/packages/rust
#rm -rf package/feeds/packages/gnutls

##更新FQ
rm -rf feeds/luci/applications/{luci-app-passwall,luci-app-openclash}
cp -r feeds/small/luci-app-passwall feeds/luci/applications/luci-app-passwall
cp -r feeds/small/luci-app-openclash feeds/luci/applications/luci-app-openclash

#rm -rf feeds/luci/applications/luci-app-turboacc
#cp -r feeds/turboacc/luci-app-turboacc feeds/luci/applications/luci-app-turboacc

# istoreos-theme
rm -rf feeds/luci/themes/luci-theme-argon
cp -r feeds/theme/luci-theme-argon feeds/luci/themes/luci-theme-argon

rm -rf feeds/luci/applications/luci-app-argon-config
cp -r feeds/theme/luci-app-argon-config feeds/luci/applications/luci-app-argon-config


#cp -r feeds/kenzo/luci-theme-argon feeds/luci/themes/luci-theme-argon

## golang 为 1.24.x
#rm -rf feeds/packages/lang/golang
#git clone https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang

# 必要的补丁
pushd feeds/luci
   curl -s https://raw.githubusercontent.com/oppen321/path/refs/heads/main/Firewall/0001-luci-mod-status-firewall-disable-legacy-firewall-rul.patch | patch -p1
popd
pushd
   curl -sSL https://raw.githubusercontent.com/Jaykwok2999/turboacc/luci/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh
popd
#rm -rf feeds/luci/applications/luci-app-passwall/*
#cp -af feeds/small/luci-app-passwall/*  feeds/luci/applications/luci-app-passwall/

#rm -rf feeds/luci/applications/luci-app-openclash/*
#cp -af feeds/small/luci-app-openclash/*  feeds/luci/applications/luci-app-openclash/

./scripts/feeds update -a
./scripts/feeds install -a
