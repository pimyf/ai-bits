#!/bin/bash
# 百度主动推送脚本
# 使用方法：hugo --gc --minify && ./scripts/baidu_push.sh

# 配置
SITE="https://getaibits.com"
TOKEN="" # 从百度站长平台获取

if [ -z "$TOKEN" ]; then
  echo "请先配置百度推送 Token"
  exit 0
fi

# 获取所有文章 URL
URLS=$(grep -r "<loc>" public/sitemap.xml | sed 's/.*<loc>\(.*\)<\/loc>.*/\1/' | grep -v "tags" | grep -v "categories")

if [ -z "$URLS" ]; then
  echo "没有找到要推送的 URL"
  exit 0
fi

echo "推送以下 URL 到百度:"
echo "$URLS"
echo ""

# 推送到百度
curl -H 'Content-Type:text/plain' --data-binary "$URLS" "http://data.zz.baidu.com/urls?site=$SITE&token=$TOKEN"

echo ""
echo "推送完成！"