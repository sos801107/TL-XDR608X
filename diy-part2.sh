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
sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
#补充汉化
echo -e "\nmsgid \"NAS\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
echo -e "msgstr \"存储\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po

##清除默认密码password
sed -i '/V4UetPzk$CYXluq4wUazHjmCDBCqXF/d' package/lean/default-settings/files/zzz-default-settings

# 移除要替换的包
rm -rf feeds/small/{shadowsocksr-libev,shadowsocks-rust,luci-app-ssr-plus,luci-i18n-ssr-plus-zh-cn,luci-app-ssr-plus,luci-i18n-ssr-plus-zh-cn,luci-app-wol,luci-app-bypass}
rm -rf feeds/luci/applications/{shadowsocksr-libev,shadowsocks-rust,luci-app-ssr-plus,luci-i18n-ssr-plus-zh-cn,luci-app-ssr-plus,luci-i18n-ssr-plus-zh-cn,luci-app-wol,luci-app-bypass}
rm -rf feeds/luci/packages/net/{shadowsocksr-libev-ssr-check,shadowsocksr-libev-ssr-local,shadowsocksr-libev-ssr-redir,shadowsocksr-libev-ssr-server}
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



##更新FQ
rm -rf feeds/luci/applications/{luci-app-passwall,luci-app-openclash}
cp -r feeds/small/luci-app-passwall feeds/luci/applications/luci-app-passwall
cp -r feeds/small/luci-app-openclash feeds/luci/applications/luci-app-openclash

rm -rf feeds/luci/applications/luci-app-turboacc
cp -r feeds/turboacc/luci-app-turboacc feeds/luci/applications/luci-app-turboacc

# istoreos-theme
rm -rf feeds/luci/themes/luci-theme-argon
cp -r feeds/theme/luci-theme-argon feeds/luci/themes/luci-theme-argon

#cp -r feeds/kenzo/luci-theme-argon feeds/luci/themes/luci-theme-argon



#rm -rf feeds/luci/applications/luci-app-passwall/*
#cp -af feeds/small/luci-app-passwall/*  feeds/luci/applications/luci-app-passwall/

#rm -rf feeds/luci/applications/luci-app-openclash/*
#cp -af feeds/small/luci-app-openclash/*  feeds/luci/applications/luci-app-openclash/

