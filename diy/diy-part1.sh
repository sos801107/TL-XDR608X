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
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
echo 'src-git openclash https://github.com/vernesong/OpenClash' >> feeds.conf.default
# echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default
# echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default

echo 'src-git small https://github.com/Jaykwok2999/istoreos-ipk' >> feeds.conf.default

#echo 'src-git 2305ipk https://github.com/sos801107/2305-ipk' >> feeds.conf.default
#echo 'src-git extraipk https://github.com/xiangfeidexiaohuo/extra-ipk' >> feeds.conf.default
#echo 'src-git small-package https://github.com/kenzok8/small-package' >> feeds.conf.default
