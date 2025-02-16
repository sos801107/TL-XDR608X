#!/bin/bash
#=================================================
# DaoDao's script
#=================================================


#补充汉化
#echo -e "\nmsgid \"Control\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
#echo -e "msgstr \"控制\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po

echo -e "\nmsgid \"NAS\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
echo -e "msgstr \"存储\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po

#echo -e "\nmsgid \"VPN\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
#echo -e "msgstr \"魔法网络\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po

#echo -e "\nmsgid \"Temperature\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
#echo -e "msgstr \"温度\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
              
##配置ip等
#sed -i 's|^TARGET_|# TARGET_|g; s|# TARGET_DEVICES += phicomm-k3|TARGET_DEVICES += phicomm-k3| ; s|# TARGET_DEVICES += phicomm_k3|TARGET_DEVICES += phicomm_k3|' target/linux/bcm53xx/image/Makefile
#sed -i 's/192\.168\.[0-9]*\.[0-9]*/192.168.1.1/g' package/base-files/files/bin/config_generate
#sed -i 's/192\.168\.[0-9]*\.[0-9]*/192.168.1.1/g' package/base-files/luci2/bin/config_generate

##清除默认密码password
sed -i '/V4UetPzk$CYXluq4wUazHjmCDBCqXF/d' package/lean/default-settings/files/zzz-default-settings

##加入作者信息
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='LEDE-$(date +%Y%m%d)'/g"  package/base-files/files/etc/openwrt_release
sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION=' By sos07'/g" package/base-files/files/etc/openwrt_release

# 修改socat为端口转发
# sed -i 's/msgstr "Socat"/msgstr "端口转发"/g' feeds/third_party/luci-app-socat/po/zh-cn/socat.po
# mwan3
# sed -i 's/MultiWAN 管理器/负载均衡/g' feeds/luci/applications/luci-app-mwan3/po/zh_Hans/mwan3.po

# 移除要替换的包
# rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box,adguardhome}

rm -rf feeds/luci/themes/luci-theme-argon


##更新FQ
rm -rf feeds/luci/applications/luci-app-passwall/*
cp -af feeds/small/patch/wall-luci/luci-app-passwall/*  feeds/luci/applications/luci-app-passwall/

#rm -rf feeds/luci/applications/luci-app-ssr-plus/*
#cp -af feeds/small/patch/wall-luci/luci-app-ssr-plus/*  feeds/luci/applications/luci-app-ssr-plus/

rm -rf feeds/luci/applications/luci-app-openclash/*
cp -af feeds/small/patch/wall-luci/luci-app-openclash/*  feeds/luci/applications/luci-app-openclash/

rm -rf feeds/luci/applications/luci-app-openclash/*
cp -af feeds/small/patch/wall-luci/luci-app-openclash/*  feeds/luci/applications/luci-app-openclash/


