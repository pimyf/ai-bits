---
title: "网页搜索"
date: 2026-03-06
draft: false
url: "/skills/web-search.html"
---

<style>
.skill-detail {
  max-width: 900px;
  margin: 0 auto;
}

.skill-header {
  text-align: center;
  padding: 3rem 0;
  background: linear-gradient(135deg, rgba(59, 130, 246, 0.1), rgba(139, 92, 246, 0.1));
  border-radius: 16px;
  margin-bottom: 2rem;
}

.skill-icon-large {
  font-size: 4rem;
  margin-bottom: 1rem;
}

.skill-title {
  font-size: 2.5rem;
  font-weight: 700;
  margin: 0 0 1rem 0;
  color: var(--primary);
}

.skill-tags {
  display: flex;
  gap: 0.5rem;
  justify-content: center;
  flex-wrap: wrap;
}

.skill-tag {
  padding: 0.3rem 0.8rem;
  border-radius: 20px;
  font-size: 0.85rem;
  font-weight: 500;
}

.skill-tag.official { background: #3b82f6; color: white; }
.skill-tag.required { background: #10b981; color: white; }

.section {
  margin: 3rem 0;
}

.section h2 {
  font-size: 1.8rem;
  color: var(--primary);
  border-bottom: 2px solid var(--primary);
  padding-bottom: 0.5rem;
  margin-bottom: 1.5rem;
}

.code-block {
  background: #1e1e1e;
  border-radius: 8px;
  padding: 1.5rem;
  overflow-x: auto;
  margin: 1rem 0;
}

.code-block pre {
  margin: 0;
  font-family: 'Consolas', 'Monaco', monospace;
  font-size: 0.9rem;
  line-height: 1.6;
  color: #d4d4d4;
}

.provider-card {
  background: var(--code-bg);
  border-radius: 12px;
  padding: 1.5rem;
  margin: 1rem 0;
  border: 1px solid var(--border);
}

.provider-card h3 {
  margin: 0 0 1rem 0;
  color: var(--primary);
}

.back-link {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  color: var(--primary);
  text-decoration: none;
  margin-bottom: 2rem;
  font-weight: 500;
}

.back-link:hover {
  text-decoration: underline;
}
</style>

<div class="skill-detail">

<a href="/skills.html" class="back-link">← 返回技能商店</a>

<div class="skill-header">
  <div class="skill-icon-large">🌐</div>
  <h1 class="skill-title">网页搜索</h1>
  <div class="skill-tags">
    <span class="skill-tag official">官方</span>
    <span class="skill-tag required">必装</span>
  </div>
</div>

## 概述

Tavily Search + Brave Search Worker 双引擎搜索，实时获取网络信息，国内直连可用。支持AI优化的搜索结果，适合研究、调研、信息收集场景。

---

## 🔧 搜索引擎对比

<div class="provider-card">
  <h3>Tavily Search (默认)</h3>  
  <p><strong>特点</strong>：AI优化的搜索结果，专为AI Agent设计，返回结构化数据</p>  
  <p><strong>网络</strong>：国内直连，无需代理</p>  
  <p><strong>适用</strong>：日常搜索、研究调研</p>
</div>

<div class="provider-card">
  <h3>Brave Search Worker</h3>  
  <p><strong>特点</strong>：精准搜索，隐私保护，无广告</p>  
  <p><strong>网络</strong>：通过Cloudflare Worker中转</p>  
  <p><strong>适用</strong>：需要精准结果时使用</p>
</div>

---

## 💻 使用方法

### 方式1：OpenClaw内置工具（推荐）

<div class="code-block">
<pre># 基础搜索
web_search(query="AI编程工具对比", count=10)

# 带语言筛选
web_search(
    query="Kubernetes最佳实践",
    count=5,
    search_lang="zh"
)

# 指定时间范围
web_search(
    query="GPT-4最新功能",
    freshness="pw"  # pw=本周, pm=本月, py=今年
)</pre>
</div>

### 方式2：Tavily API直接调用

<div class="code-block">
<pre>import requests

response = requests.post(
    "https://api.tavily.com/search",
    json={
        "query": "Kubernetes零停机部署",
        "api_key": "tvly-dev-xxx",
        "search_depth": "comprehensive",
        "include_answer": True,
        "max_results": 10
    }
)

data = response.json()
# data["results"] - 搜索结果列表
# data["answer"] - AI生成的答案摘要</pre>
</div>

### 方式3：Brave Search Worker

<div class="code-block">
<pre>curl "https://search.getaibits.com/search?q=关键词" \
  -H "X-Proxy-Token: 5c48fc61849dfbdfa7cf9d1cf45057d0f8f6193afa2ba0cba90a04c9b4641488" \
  -H "Accept: application/json"

# 响应格式
{
  "results": [
    {
      "title": "...",
      "url": "...",
      "description": "..."
    }
  ]
}</pre>
</div>

---

## ⚙️ 配置

### OpenClaw配置

<div class="code-block">
<pre># ~/.openclaw/openclaw.json

{
  "tools": {
    "web": {
      "search": {
        "enabled": true,
        "provider": "tavily",
        "apiKey": "tvly-dev-YOUR_API_KEY"
      },
      "fetch": {
        "enabled": true
      }
    }
  }
}</pre>
</div>

### 获取Tavily API Key

1. 访问 https://tavily.com
2. 注册账号
3. 在Dashboard获取API Key
4. 填入openclaw.json配置

---

## 🎯 高级用法

### 结合网页抓取

<div class="code-block">
<pre># 搜索后抓取详细内容
results = web_search(query="Kubernetes部署指南", count=5)

for result in results:
    # 抓取网页全文
    content = web_fetch(url=result["url"])
    # 分析内容
    analyze(content)</pre>
</div>

### 多语言搜索

<div class="code-block">
<pre># 中文搜索
web_search(query="云原生架构", search_lang="zh")

# 英文搜索
web_search(query="cloud native architecture", search_lang="en")

# 日文搜索
web_search(query="クラウドネイティブ", search_lang="ja")</pre>
</div>

---

## 📊 响应格式

<div class="code-block">
<pre>{
  "query": "搜索关键词",
  "results": [
    {
      "title": "文章标题",
      "url": "https://example.com/article",
      "content": "文章摘要内容...",
      "score": 0.95,
      "raw_content": "可选的完整内容"
    }
  ],
  "answer": "AI生成的答案摘要（可选）",
  "response_time": "1.23s"
}</pre>
</div>

---

## 📚 相关技能

- [🔬 深度研究](/skills/deep-research.html) - 多引擎搜索+结构化分析
- [📄 PDF文档分析](/skills/pdf-analysis.html) - 提取文档关键信息
- [🔭 浏览器控制](/skills/browser.html) - 网页自动化和截图

---

<div style="text-align: center; margin-top: 3rem; padding: 2rem; background: var(--code-bg); border-radius: 12px;">
  <h3>🚀 开始使用</h3>
  <p>直接在对话中输入搜索需求，AI会自动调用搜索工具获取最新信息。</p>
  <a href="/skills.html" style="display: inline-block; margin-top: 1rem; padding: 0.8rem 2rem; background: var(--primary); color: white; text-decoration: none; border-radius: 8px; font-weight: 500;">查看全部技能 →</a>
</div>

</div>
