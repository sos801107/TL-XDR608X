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
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

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
# rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box,adguardhome}
rm -rf feeds/luci/packages/luci-app-ssr-plus
rm -rf feeds/luci/packages/luci-i18n-ssr-plus-zh-cn
rm -rf feeds/luci/applications/luci-app-ssr-plus
rm -rf feeds/luci/applications/luci-i18n-ssr-plus-zh-cn
rm -rf feeds/luci/applications/luci-app-wol

##更新FQ
rm -rf feeds/luci/themes/luci-theme-argon/*
cp -af feeds/kenzo/luci-theme-argon/*  feeds/luci/themes/luci-theme-argon/

rm -rf feeds/luci/applications/luci-app-passwall/*
cp -af feeds/small/luci-app-passwall/*  feeds/luci/applications/luci-app-passwall/

rm -rf feeds/luci/applications/luci-app-openclash/*
cp -af feeds/small/luci-app-openclash/*  feeds/luci/applications/luci-app-openclash/

