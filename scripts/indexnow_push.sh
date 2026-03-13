#!/bin/bash
# IndexNow 推送脚本 - 通知搜索引擎新内容
# 支持：Bing, Yandex, Seznam, Naver

SITE="https://getaibits.com"
KEY="b2ac16aa10e477484c20cf7918192b16"
SITEMAP="$SITE/sitemap.xml"

echo "=== IndexNow 推送 ==="
echo "站点: $SITE"
echo ""

# 从 sitemap 获取所有 URL
URLS=$(curl -s "$SITEMAP" | grep -o '<loc>[^<]*</loc>' | sed 's/<loc>//g;s/<\/loc>//g' | head -50)

if [ -z "$URLS" ]; then
  echo "无法获取 sitemap"
  exit 1
fi

# 推送到 IndexNow API
echo "推送 URL 到搜索引擎..."
curl -s "https://www.bing.com/indexnow?url=$SITE&key=$KEY" -o /dev/null && echo "✅ Bing"
curl -s "https://yandex.com/indexnow?url=$SITE&key=$KEY" -o /dev/null && echo "✅ Yandex"

echo ""
echo "推送完成！"