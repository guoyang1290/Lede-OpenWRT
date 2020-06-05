#!/bin/bash
# Modify default IP
#sed -i 's/192.168.1.1/192.168.0.250/g' package/base-files/files/bin/config_generate

#移除不用软件包    
rm -rf package/lean/luci-app-dockerman
rm -rf package/lean/luci-theme-argon
rm -rf package/lean/luci-app-acme
#添加额外软件包
git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
git clone https://github.com/lisaac/luci-app-dockerman.git package/luci-app-dockerman
git clone https://github.com/Repobor/luci-app-koolproxyR.git package/luci-app-koolproxyR
svn co https://github.com/Lienol/openwrt-package/trunk/package/tcping package/tcping
git clone --depth=1 https://github.com/pexcn/openwrt-chinadns-ng.git package/chinadns-ng
svn co https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus package/luci-app-ssr-plus
svn co https://github.com/Lienol/openwrt-package/trunk/package/brook
svn co https://github.com/Lienol/openwrt-package/trunk/package/ipt2socks
svn co https://github.com/openwrt/luci/trunk/applications/luci-app-sqm
svn co https://github.com/openwrt/luci/trunk/applications/luci-app-acme
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-passwall
git clone https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-aduardhome
git clone https://github.com/garypang13/openwrt-adguardhome package/adguardhome
git clone https://github.com/garypang13/luci-app-eqos package/luci-app-eqos
git clone https://github.com/garypang13/luci-app-baidupcs-web package/luci-app-baidupcs-web
git clone https://github.com/brvphoenix/luci-app-wrtbwmon package/luci-app-wrtbwmon
git clone https://github.com/brvphoenix/wrtbwmon package/wrtbwmon
git clone https://github.com/destan19/OpenAppFilter package/OpenAppFilter
git clone https://github.com/pymumu/luci-app-smartdns -b lede package/luci-app-smartdns
git clone https://github.com/pymumu/openwrt-smartdns package/smartdns
# Add OpenClash
git clone --depth=1 https://github.com/vernesong/OpenClash package/OpenClash
# Add Lienol's Packages
git clone --depth=1 https://github.com/SuLingGG/openwrt-package package/Lienol
# Add Rclone-OpenWrt
git clone https://github.com/ElonH/Rclone-OpenWrt package/Rclone-OpenWrt
# Add luci-theme-atmaterial-ci
git clone https://github.com/esirplayground/luci-theme-atmaterial-ColorIcon package/luci-theme-atmaterial-ColorIcon
# Add luci-theme-argon
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon

#加载个性化配置
cp -f ../default-settings package/lean/default-settings/files/zzz-default-settings
if [ -n "$(ls -A "patches" 2>/dev/null)" ]; then
   find "patches" -type f -name '*.patch'| xargs -i git apply {}
fi
date=`date +%m.%d.%Y`
sed -i "s/# REVISION:=x/REVISION:= $date/g" include/version.mk
./scripts/feeds update -a
./scripts/feeds install -a