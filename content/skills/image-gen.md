---
title: "AI图片生成"
date: 2026-03-06
draft: false
url: "/skills/image-gen.html"
---

<style>
.skill-detail {
  max-width: 900px;
  margin: 0 auto;
}

.skill-header {
  text-align: center;
  padding: 3rem 0;
  background: linear-gradient(135deg, rgba(236, 72, 153, 0.1), rgba(139, 92, 246, 0.1));
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

.model-list {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1rem;
  margin: 1.5rem 0;
}

.model-item {
  background: var(--code-bg);
  border-radius: 8px;
  padding: 1rem;
  border: 1px solid var(--border);
}

.model-item h4 {
  margin: 0 0 0.5rem 0;
  color: var(--primary);
}

.model-item p {
  margin: 0;
  font-size: 0.85rem;
  color: var(--secondary);
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

.tip-box {
  background: rgba(59, 130, 246, 0.1);
  border-left: 4px solid #3b82f6;
  padding: 1rem 1.5rem;
  border-radius: 0 8px 8px 0;
  margin: 1rem 0;
}

.tip-box strong {
  color: #3b82f6;
}
</style>

<div class="skill-detail">

<a href="/skills.html" class="back-link">← 返回技能商店</a>

<div class="skill-header">
  <div class="skill-icon-large">🖼️</div>
  <h1 class="skill-title">AI图片生成</h1>
  <div class="skill-tags">
    <span class="skill-tag official">官方</span>
    <span class="skill-tag required">必装</span>
  </div>
</div>

## 概述

Nano Banana Pro (Gemini 3 Pro Image) 文生图，2K高清配图生成，支持多种风格。专为博客文章、公众号、社交媒体配图设计。

---

## 🤖 支持模型

<div class="model-list">
  <div class="model-item">
    <h4>gemini-2.5-flash-image</h4>
    <p>快速生成，适合草稿和迭代</p>
  </div>
  <div class="model-item">
    <h4>gemini-3-flash-preview</h4>
    <p>平衡速度和质量</p>
  </div>
  <div class="model-item">
    <h4>gemini-3-pro-image-preview</h4>
    <p>默认模型，最佳质量</p>
  </div>
  <div class="model-item">
    <h4>veo-3.1-fast-generate-preview</h4>
    <p>视频生成（实验性）</p>
  </div>
</div>

---

## 💻 使用方法

### 方式1：命令行脚本（推荐）

<div class="code-block">
<pre># 进入技能目录
cd ~/.openclaw/workspace/skills/nano-banana-pro

# 生成图片
uv run scripts/generate_image.py \
  --prompt "一只戴墨镜的可爱猫咪，赛博朋克风格，霓虹灯光" \
  --filename "cyber-cat.png" \
  --resolution 2K

# 输出
# 图片保存到当前目录
# 分辨率: 2816 x 1536 (2K)</pre>
</div>

### 方式2：API直接调用

<div class="code-block">
<pre>curl "http://zx2.52youxi.cc:3000/v1/images/generations" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer sk-GseFWg0amtOfp6MdkHK7bk1nvLHb5FC5dYtFH1g7Kc2YaYVx" \
  -d '{
    "model": "gemini-3-pro-image-preview",
    "prompt": "A professional workspace with laptop and coffee, minimalist style, soft lighting",
    "n": 1,
    "size": "1024x1024"
  }'

# 响应
{
  "data": [
    {
      "url": "https://.../image.png",
      "revised_prompt": "优化后的提示词"
    }
  ]
}</pre>
</div>

### 方式3：OpenAI兼容格式

<div class="code-block">
<pre>import requests

response = requests.post(
    "http://zx2.52youxi.cc:3000/v1/chat/completions",
    headers={
        "Authorization": "Bearer sk-xxx",
        "Content-Type": "application/json"
    },
    json={
        "model": "gemini-3-pro-image-preview",
        "messages": [
            {"role": "user", "content": "生成一张科技风格的博客封面图"}
        ]
    }
)

# 返回图片URL</pre>
</div>

---

## ⚙️ 配置

### OpenClaw技能配置

<div class="code-block">
<pre># ~/.openclaw/openclaw.json

{
  "skills": {
    "entries": {
      "nano-banana-pro": {
        "env": {
          "GEMINI_API_KEY": "sk-GseFWg0amtOfp6MdkHK7bk1nvLHb5FC5dYtFH1g7Kc2YaYVx",
          "GEMINI_BASE_URL": "http://zx2.52youxi.cc:3000"
        }
      }
    }
  }
}</pre>
</div>

### 环境变量方式

<div class="code-block">
<pre># ~/.zshrc 或 ~/.bashrc

export GEMINI_API_KEY="sk-xxx"
export GEMINI_BASE_URL="http://zx2.52youxi.cc:3000"</pre>
</div>

---

## 🎨 提示词技巧

### 博客封面图

<div class="code-block">
<pre># 技术类文章
"A futuristic data center with glowing servers, blue and purple gradient, 
cinematic lighting, wide angle, professional tech blog cover style"

# 商业分析
"Modern office workspace with holographic charts and graphs, 
clean minimalist style, professional lighting, business blog cover"

# 教程类
"Step-by-step learning concept, abstract visualization of knowledge transfer, 
bright and inviting colors, educational blog style"</pre>
</div>

### 公众号配图

<div class="code-block">
<pre># 情感类文章
"Warm sunset scene with silhouette of person thinking, 
soft golden hour lighting, contemplative mood, WeChat article style"

# 科技资讯
"Abstract representation of AI and human collaboration, 
neon accents on dark background, futuristic tech news style"</pre>
</div>

<div class="tip-box">
<strong>💡 提示</strong>：在提示词中包含风格描述（如"minimalist style"、"cinematic lighting"）和质量描述（如"highly detailed"、"professional"）可以获得更好的效果。
</div>

---

## 📐 分辨率选项

| 选项 | 分辨率 | 适用场景 |
|------|--------|----------|
| 1K | 1408 x 768 | 社交媒体头像、小图 |
| 2K | 2816 x 1536 | 博客封面、公众号配图（推荐） |
| 4K | 5632 x 3072 | 海报、印刷物料 |

---

## 🚀 批量生成

<div class="code-block">
<pre>#!/bin/bash

# 批量生成配图
prompts=(
  "科技风格封面图"
  "商务会议场景"
  "数据可视化"
  "团队协作"
)

for i in "${!prompts[@]}"; do
  uv run scripts/generate_image.py \
    --prompt "${prompts[$i]}, professional blog style, 2K" \
    --filename "cover-$(($i+1)).png" \
    --resolution 2K
done</pre>
</div>

---

## 📚 相关技能

- [✍️ 公众号文章写作](/skills/content-writing.html) - 配图+文章一站式完成
- [🎨 多媒体制作](/skills/media.html) - PPT、视频脚本制作
- [📤 内容发布](/skills/publish.html) - 配图自动上传到图床

---

<div style="text-align: center; margin-top: 3rem; padding: 2rem; background: var(--code-bg); border-radius: 12px;">
  <h3>🚀 开始使用</h3>
  <p>描述你想要的图片场景，AI会自动生成高清配图。</p>
  <a href="/skills.html" style="display: inline-block; margin-top: 1rem; padding: 0.8rem 2rem; background: var(--primary); color: white; text-decoration: none; border-radius: 8px; font-weight: 500;">查看全部技能 →</a>
</div>

</div>
