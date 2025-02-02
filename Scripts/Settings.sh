#!/bin/bash

#删除冲突插件
rm -rf $(find ./feeds/luci/ -type d -iregex ".*\(argon\|adguardhome\|mosdns\|design\|helloworld\|homeproxy\|openclash\|passwall\).*")
#修改默认主题
#sed -i "s/luci-theme-bootstrap/luci-theme-$OWRT_THEME/g" $(find ./feeds/luci/collections/ -type f -name "Makefile")
#修改默认IP地址
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.1.11/g" ./package/base-files/files/bin/config_generate
#修改默认主机名
sed -i "s/hostname='.*'/hostname='ImmortalWrt'/g" ./package/base-files/files/bin/config_generate
#修改默认时区
sed -i "s/timezone='.*'/timezone='CST-8'/g" ./package/base-files/files/bin/config_generate
sed -i "/timezone='.*'/a\\\t\t\set system.@system[-1].zonename='Asia/Shanghai'" ./package/base-files/files/bin/config_generate
#修改版本为编译日期
#cp -f feeds/smpackage/.github/diy/banner package/base-files/files/etc/banner
#sed -i "s/%D %V, %C/openwrt $(date +'%m.%d') by Masaaki/g" package/base-files/files/etc/banner
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='ImmortalWrt by Masaaki'/g"  package/base-files/files/etc/openwrt_release

#根据源码来修改
if [[ $OWRT_URL == *"lede"* ]] ; then
  #修改默认时间格式
  sed -i 's/os.date()/os.date("%Y-%m-%d %H:%M:%S %A")/g' $(find ./package/*/autocore/files/ -type f -name "index.htm")
fi
