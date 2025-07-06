#!/bin/bash
#luci openwrt-24.10
#sed -i 's/coolsnowwolf\/luci/immortalwrt\/luci/g' ./feeds.conf.default
sed -i 's/openwrt-23.05/openwrt-24.10/g' ./feeds.conf.default

mkdir -p files/etc/config
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/openclash > files/etc/config/openclash
#wget -qO- https://raw.githubusercontent.com/liandu2024/clash/refs/heads/main/main_router/openclash > files/etc/config/openclash
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/mosdns > files/etc/config/mosdns
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/smartdns > files/etc/config/smartdns

mkdir -p files/etc
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/opkg.conf > files/etc/opkg.conf
mkdir -p files/etc/opkg
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/distfeeds.conf > files/etc/opkg/distfeeds.conf-86
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/distfeeds.conf > files/etc/opkg/distfeeds.conf

mkdir -p files/root
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/.profile > files/root/.profile
#修改默认IP地址
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.1.1/g" ./package/base-files/files/bin/config_generate
#修改默认主机名
sed -i "s/hostname='.*'/hostname='LEDE'/g" ./package/base-files/files/bin/config_generate
#修改默认时区
sed -i "s/timezone='.*'/timezone='CST-8'/g" ./package/base-files/files/bin/config_generate
sed -i "/timezone='.*'/a\\\t\t\set system.@system[-1].zonename='Asia/Shanghai'" ./package/base-files/files/bin/config_generate
# TTYD
sed -i 's/services/system/g' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
# sed -i '3 a\\t\t"order": 50,' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
# sed -i 's/procd_set_param stdout 1/procd_set_param stdout 0/g' feeds/packages/utils/ttyd/files/ttyd.init
# sed -i 's/procd_set_param stderr 1/procd_set_param stderr 0/g' feeds/packages/utils/ttyd/files/ttyd.init

##清除默认密码password
sed -i '/V4UetPzk$CYXluq4wUazHjmCDBCqXF/d' package/lean/default-settings/files/zzz-default-settings

##取消bootstrap为默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-nginx/Makefile

# default-settings
#git clone --depth=1 -b openwrt-24.10 https://github.com/Jaykwok2999/default-settings package/default-settings

# mwan3
sed -i 's/MultiWAN 管理器/负载均衡/g' feeds/luci/applications/luci-app-mwan3/po/zh_Hans/mwan3.po

# samba4
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-samba4/root/usr/share/luci/menu.d/luci-app-samba4.json

# linkease调至NAS
sed -i 's/services/nas/g' feeds/nas-packages-luci/luci/luci-app-linkease/luasrc/controller/linkease.lua
sed -i 's/services/nas/g' feeds/nas-packages-luci/luci/luci-app-linkease/luasrc/view/linkease_status.htm

# HD磁盘工具调至NAS
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-hd-idle/root/usr/share/luci/menu.d/luci-app-hd-idle.json

# 修改FileBrowser
sed -i 's/msgstr "FileBrowser"/msgstr "文件浏览器"/g' feeds/istoreos_ipk/op-fileBrowser/luci-app-filebrowser/po/zh_Hans/filebrowser.po
sed -i 's/services/nas/g' feeds/istoreos_ipk/op-fileBrowser/luci-app-filebrowser/root/usr/share/luci/menu.d/luci-app-filebrowser.json

# 修改socat为端口转发
sed -i 's/msgstr "Socat"/msgstr "端口转发"/g' feeds/third_party/luci-app-socat/po/zh-cn/socat.po

##加入作者信息
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='LEDE-$(date +%Y%m%d)'/g"  package/base-files/files/etc/openwrt_release
sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION=' By sos07'/g" package/base-files/files/etc/openwrt_release

# 移除要替换的包
rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box,adguardhome}
rm -rf feeds/packages/net/alist feeds/luci/applications/luci-app-alist
rm -rf feeds/packages/utils/v2dat
rm -rf feeds/third_party/luci-app-LingTiGameAcc
rm -rf feeds/istoreos_ipk/op-daed
rm -rf feeds/third/luci-theme-argon
rm -rf feeds/istoreos_ipk/patch/istoreos-24.10/istoreos-files
rm -rf feeds/small/{shadowsocksr-libev,shadowsocks-rust,luci-app-ssr-plus,luci-i18n-ssr-plus-zh-cn,luci-app-ssr-plus,luci-i18n-ssr-plus-zh-cn,luci-app-wol,luci-app-bypass,luci-app-argon-config,luci-theme-argon}
rm -rf feeds/luci/applications/{shadowsocksr-libev,shadowsocks-rust,luci-app-ssr-plus,luci-i18n-ssr-plus-zh-cn,luci-app-ssr-plus,luci-i18n-ssr-plus-zh-cn,luci-app-wol,luci-app-bypass,luci-app-argon-config,luci-theme-argon}
rm -rf feeds/luci/packages/net/{shadowsocksr-libev-ssr-check,shadowsocksr-libev-ssr-local,shadowsocksr-libev-ssr-redir,shadowsocksr-libev-ssr-server}
# 将packages源的相关文件替换成passwall_packages源的
rm -rf feeds/istoreos_ipk/patch/wall-luci/luci-app-passwall
rm -rf feeds/istoreos_ipk/geoview
rm -rf feeds/third_party/luci-app-smartdns
rm -rf feeds/third_party/smartdns
rm -rf feeds/istoreos_ipk/op-mosdns
rm -rf feeds/istoreos_ipk/xray-core
rm -rf feeds/istoreos_ipk/sing-box
rm -rf feeds/istoreos_ipk/chinadns-ng
rm -rf feeds/istoreos_ipk/microsocks
rm -rf feeds/istoreos_ipk/dns2socks
rm -rf feeds/istoreos_ipk/ipt2socks
rm -rf package/feeds/istoreos_ipk/vlmcsd
rm -rf feeds/istoreos_ipk/vlmcsd
rm -rf feeds/istoreos_ipk/vlmcsd
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
cp -r feeds/small/ipt2socks feeds/packages/net
cp -r feeds/small/microsocks feeds/packages/net
cp -r feeds/small/geoview feeds/packages/net

rm -rf tools/erofs-utils

rm -rf feeds/istoreos_ipk/patch/istoreos-files
git clone https://github.com/sos801107/istoreos-files -b main feeds/packages/istoreos-files

rm -rf feeds/small/luci-app-passwall
rm -rf feeds/kenzo/{luci-app-argon-config,luci-theme-argon}
rm -rf feeds/luci/applications/{luci-app-tailscale,luci-app-turboacc}
# istoreos-theme
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/third/luci-theme-argon
rm -rf feeds/istoreos_ipk/theme/luci-theme-argon
#cp -r feeds/theme/luci-theme-argon feeds/luci/themes/luci-theme-argon
rm -rf feeds/third/luci-app-argon-config
rm -rf feeds/luci/applications/luci-app-argon-config
rm -rf feeds/istoreos_ipk/theme/luci-app-argon-config
#cp -r feeds/theme/luci-app-argon-config feeds/luci/applications/luci-app-argon-config

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

function merge_package() {
    # 参数1是分支名,参数2是库地址,参数3是所有文件下载到指定路径。
    # 同一个仓库下载多个文件夹直接在后面跟文件名或路径，空格分开。
    if [[ $# -lt 3 ]]; then
        echo "Syntax error: [$#] [$*]" >&2
        return 1
    fi
    trap 'rm -rf "$tmpdir"' EXIT
    branch="$1" curl="$2" target_dir="$3" && shift 3
    rootdir="$PWD"
    localdir="$target_dir"
    [ -d "$localdir" ] || mkdir -p "$localdir"
    tmpdir="$(mktemp -d)" || exit 1
    git clone -b "$branch" --depth 1 --filter=blob:none --sparse "$curl" "$tmpdir"
    cd "$tmpdir"
    git sparse-checkout init --cone
    git sparse-checkout set "$@"
    # 使用循环逐个移动文件夹
    for folder in "$@"; do
        mv -f "$folder" "$rootdir/$localdir"
    done
    cd "$rootdir"
}


git_sparse_clone openwrt-24.10 https://github.com/sbwml/luci-theme-argon luci-theme-argon
git_sparse_clone openwrt-24.10 https://github.com/sbwml/luci-theme-argon luci-app-argon-config
git_sparse_clone main https://github.com/xiaorouji/openwrt-passwall luci-app-passwall
git_sparse_clone luci https://github.com/chenmozhijin/turboacc luci-app-turboacc

#git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-app-mosdns
#git_sparse_clone main https://github.com/kiddin9/kwrt-packages mosdns
#git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-app-tailscale
#git_sparse_clone main https://github.com/kiddin9/kwrt-packages tailscale
git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-app-upnp
git_sparse_clone main https://github.com/kiddin9/kwrt-packages miniupnpd

rm -rf feeds/small/luci-app-openclash
git_sparse_clone dev https://github.com/vernesong/OpenClash luci-app-openclash


# golong1.24.2依赖
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang

# UPnP
rm -rf feeds/{packages/net/miniupnpd,luci/applications/luci-app-upnp}
git clone https://git.kejizero.online/zhao/miniupnpd feeds/packages/net/miniupnpd -b v2.3.7
git clone https://git.kejizero.online/zhao/luci-app-upnp feeds/luci/applications/luci-app-upnp -b master

# 必要的补丁
pushd feeds/luci
   curl -s https://raw.githubusercontent.com/oppen321/path/refs/heads/main/Firewall/0001-luci-mod-status-firewall-disable-legacy-firewall-rul.patch | patch -p1
popd

pushd
   curl -sSL https://raw.githubusercontent.com/Jaykwok2999/turboacc/luci/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh
popd


./scripts/feeds update -a
./scripts/feeds install -a
