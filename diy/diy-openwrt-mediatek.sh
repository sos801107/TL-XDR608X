#!/bin/bash
mkdir -p files/etc/config
wget -qO- https://raw.githubusercontent.com/liandu2024/clash/refs/heads/main/main_router/openclash > files/etc/config/openclash
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/mosdns > files/etc/config/mosdns
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/smartdns > files/etc/config/smartdns

mkdir -p files/etc
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/opkg.conf > files/etc/opkg.conf
mkdir -p files/etc/opkg
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/distfeeds.conf > files/etc/opkg/distfeeds.conf

mkdir -p files/root
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/.profile > files/root/.profile

mkdir -p files/lib/wifi
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/mac80211.uc > files/lib/wifi/mac80211.uc
pushd
   curl -sSL https://raw.githubusercontent.com/chenmozhijin/turboacc/luci/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh
popd
#修改默认IP地址
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.1.1/g" ./package/base-files/files/bin/config_generate
#修改默认主机名
sed -i "s/hostname='.*'/hostname='OpenWrt'/g" ./package/base-files/files/bin/config_generate
#修改默认时区
sed -i "s/timezone='.*'/timezone='CST-8'/g" ./package/base-files/files/bin/config_generate
sed -i "/timezone='.*'/a\\\t\t\set system.@system[-1].zonename='Asia/Shanghai'" ./package/base-files/files/bin/config_generate
# TTYD
sed -i 's/services/system/g' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json

##取消bootstrap为默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-nginx/Makefile

##加入作者信息
sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION=' By sos07'/g" package/base-files/files/etc/openwrt_release

# 移除要替换的包
rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box,adguardhome,mosdns,v2ray-geodata,v2ray-geoip,chinadns-ng,dns2socks,dns2tcp,microsocks,alist}
rm -rf feeds/packages/utils/v2dat
rm -rf feeds/third_party/{luci-app-LingTiGameAcc,luci-app-smartdns,smartdns}
rm -rf feeds/small/{luci-app-openclash,sing-box,luci-app-passwall,shadowsocksr-libev,shadowsocks-rust,luci-app-ssr-plus,luci-i18n-ssr-plus-zh-cn,luci-app-ssr-plus,luci-i18n-ssr-plus-zh-cn,luci-app-wol,luci-app-bypass,luci-app-argon-config,luci-theme-argon}
rm -rf feeds/luci/applications/{luci-app-tailscale,luci-app-turboacc,luci-app-alist,shadowsocksr-libev,shadowsocks-rust,luci-app-ssr-plus,luci-i18n-ssr-plus-zh-cn,luci-app-ssr-plus,luci-i18n-ssr-plus-zh-cn,luci-app-wol,luci-app-bypass,luci-app-argon-config,luci-theme-argon}
rm -rf feeds/luci/packages/net/{shadowsocksr-libev-ssr-check,shadowsocksr-libev-ssr-local,shadowsocksr-libev-ssr-redir,shadowsocksr-libev-ssr-server}

# istoreos-theme
rm -rf feeds/kenzo/{luci-app-argon-config,luci-theme-argon}
rm -rf feeds/third/{luci-app-argon-config,luci-theme-argon}
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config
rm -rf feeds/turboaccpackage/nft-fullcone
rm -rf package/turboacc/nft-fullcone
rm -rf package/feeds/small/dns2socks
rm -rf feeds/small/dns2socks
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


git_sparse_clone main https://github.com/xiaorouji/openwrt-passwall luci-app-passwall

#git_sparse_clone luci https://github.com/chenmozhijin/turboacc luci-app-turboacc

#git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-app-mosdns
#git_sparse_clone main https://github.com/kiddin9/kwrt-packages mosdns
#git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-app-tailscale
#git_sparse_clone main https://github.com/kiddin9/kwrt-packages tailscale
git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-app-upnp
git_sparse_clone main https://github.com/kiddin9/kwrt-packages miniupnpd

git_sparse_clone dev https://github.com/vernesong/OpenClash luci-app-openclash

#git_sparse_clone main https://github.com/sos801107/packages sing-box

# golong1.24.2依赖
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang


# 必要的补丁
pushd feeds/luci
   curl -s https://raw.githubusercontent.com/oppen321/path/refs/heads/main/Firewall/0001-luci-mod-status-firewall-disable-legacy-firewall-rul.patch | patch -p1
popd


./scripts/feeds update -a
./scripts/feeds install -a
