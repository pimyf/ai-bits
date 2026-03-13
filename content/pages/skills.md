---
title: "技能商店"
date: 2026-03-06
draft: false
layout: "skills"
url: "/skills.html"
---

<style>
.skills-container {
  max-width: 1200px;
}

.skill-section {
  margin-bottom: 3rem;
}

.skill-item {
  background: var(--code-bg);
  border-radius: 12px;
  padding: 1.5rem;
  margin-bottom: 1.5rem;
  border: 1px solid var(--border);
  transition: all 0.3s ease;
}

.skill-item:hover {
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
  border-color: var(--primary);
}

.skill-header {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  margin-bottom: 1rem;
}

.skill-icon {
  font-size: 2rem;
  width: 50px;
  height: 50px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, var(--primary), var(--secondary));
  border-radius: 10px;
  flex-shrink: 0;
}

.skill-title-row {
  flex: 1;
}

.skill-title {
  font-size: 1.3rem;
  font-weight: 600;
  color: var(--primary);
  margin: 0 0 0.5rem 0;
}

.skill-tags {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.skill-tag {
  font-size: 0.75rem;
  padding: 0.2rem 0.6rem;
  border-radius: 20px;
  font-weight: 500;
}

.skill-tag.official {
  background: #3b82f6;
  color: white;
}

.skill-tag.hot {
  background: #ef4444;
  color: white;
}

.skill-tag.required {
  background: #10b981;
  color: white;
}

.skill-desc {
  font-size: 1rem;
  color: var(--secondary);
  line-height: 1.6;
  margin-bottom: 1rem;
}

.skill-details {
  background: var(--theme);
  border-radius: 8px;
  padding: 1rem;
  margin-top: 1rem;
}

.skill-details h4 {
  font-size: 0.9rem;
  color: var(--primary);
  margin: 0 0 0.5rem 0;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.skill-usage {
  font-size: 0.9rem;
  color: var(--secondary);
  margin-bottom: 1rem;
}

.skill-code {
  background: #1e1e1e;
  border-radius: 6px;
  padding: 1rem;
  overflow-x: auto;
  margin: 0.5rem 0;
}

.skill-code pre {
  margin: 0;
  font-size: 0.85rem;
  line-height: 1.5;
}

.skill-code code {
  color: #d4d4d4;
  font-family: 'Consolas', 'Monaco', monospace;
}

.section-title {
  font-size: 1.8rem;
  font-weight: 700;
  margin: 3rem 0 1.5rem;
  padding-bottom: 0.5rem;
  border-bottom: 3px solid var(--primary);
  display: inline-block;
}

.intro {
  font-size: 1.1rem;
  line-height: 1.8;
  margin-bottom: 2rem;
  padding: 1.5rem;
  background: linear-gradient(135deg, rgba(59, 130, 246, 0.1), rgba(16, 185, 129, 0.1));
  border-radius: 12px;
  border-left: 4px solid var(--primary);
}

.cta-box {
  background: var(--code-bg);
  border-radius: 12px;
  padding: 2rem;
  margin-top: 3rem;
  text-align: center;
  border: 2px dashed var(--border);
}

.cta-box h3 {
  margin: 0 0 1rem 0;
  color: var(--primary);
}

.cta-box p {
  margin: 0;
  color: var(--secondary);
}
</style>

<div class="skills-container">

<div class="intro">
🔧 <strong>技能商店</strong> —— 这里是 AI Bits 博客背后的全部技能和能力展示。

每个技能都代表一个可独立运行的功能模块，通过简单的自然语言指令即可调用。所有技能都基于 OpenClaw 多 Agent 协作系统构建。
</div>

---

<span class="section-title">🤖 Agent 协作</span>

<div class="skill-item">
  <div class="skill-header">
    <span class="skill-icon">🏗️</span>
    <div class="skill-title-row">
      <h3 class="skill-title">多Agent团队配置</h3>
      <div class="skill-tags">
        <span class="skill-tag official">官方</span>
        <span class="skill-tag hot">热门</span>
        <span class="skill-tag required">核心</span>
      </div>
    </div>
  </div>  
  <p class="skill-desc">一只AI变一支团队——配置6个AI角色协作，总控中心统一调度，各Agent各司其职。</p>
  
  <div class="skill-details">
    <h4>🎯 使用方式</h4>
    <div class="skill-usage">在总控中心描述任务，系统自动分发给对应Agent执行</div>
    
    <h4>💻 配置示例</h4>
    <div class="skill-code">
<pre><code># 团队架构
├── 总控中心 (main)      - 任务分发、结果汇总
├── 研究分析专家 (research) - 商业分析、文献检索
├── 内容创作专家 (content)  - 公众号文章、教案
├── 技术开发专家 (dev)     - 代码开发、工具制作
├── 多媒体专家 (media)     - 图片生成、PPT
└── 发布运营专家 (publish)  - 内容发布、数据分析

# 使用示例
"帮我调研AI编程工具，写一篇公众号文章"
→ research调研 → content写作 → media配图 → publish发布</code></pre>
    </div>
    
    <h4>📁 配置文件</h4>
    <div class="skill-code">
<pre><code># ~/.openclaw/openclaw.json
{
  "agents": {
    "list": [
      {"id": "research", "name": "研究分析专家"},
      {"id": "content", "name": "内容创作专家"},
      {"id": "dev", "name": "技术开发专家"},
      {"id": "media", "name": "多媒体专家"},
      {"id": "publish", "name": "发布运营专家"}
    ]
  }
}</code></pre>
    </div>
  </div>
</div>

<div class="skill-item">
  <div class="skill-header">
    <span class="skill-icon">🔄</span>
    <div class="skill-title-row">
      <h3 class="skill-title">Agent任务分发</h3>
      <div class="skill-tags">
        <span class="skill-tag official">官方</span>
        <span class="skill-tag required">必装</span>
      </div>
    </div>
  </div>
  <p class="skill-desc">智能识别任务类型，自动派发给对应Agent执行，支持复杂多步骤工作流编排。</p>
  
  <div class="skill-details">
    <h4>🎯 使用方式</h4>
    <div class="skill-usage">总控中心自动分析任务，调用 sessions_spawn() 派发给对应Agent</div>
    
    <h4>💻 代码示例</h4>
    <div class="skill-code">
<pre><code># 派发规则映射
TASK_TYPE_MAPPING = {
    "调研": "research",
    "分析": "research", 
    "写作": "content",
    "文章": "content",
    "代码": "dev",
    "开发": "dev",
    "图片": "media",
    "配图": "media",
    "发布": "publish"
}

# 派发示例
sessions_spawn(
    agentId="research",
    task="调研Kubernetes零停机部署最佳实践",
    mode="run"
)
# Agent完成后自动返回结果</code></pre>
    </div>
  </div>
</div>

<div class="skill-item">
  <div class="skill-header">
    <span class="skill-icon">✅</span>
    <div class="skill-title-row">
      <h3 class="skill-title">质量审核机制</h3>
      <div class="skill-tags">
        <span class="skill-tag official">官方</span>
        <span class="skill-tag required">核心</span>
      </div>
    </div>
  </div>
  <p class="skill-desc">关键节点人工审核，支持通过/修改/重写三种反馈，确保输出质量可控。</p>
  
  <div class="skill-details">
    <h4>🎯 工作流程</h4>
    <div class="skill-code">
<pre><code>1. research → 调研报告
        ↓
2. 【审核点1】发送给主人审核
   ├─ "通过" → 继续步骤3
   ├─ "修改" → 返回修改 → 重新审核
   └─ "重写" → 返回research重新调研
        ↓
3. content → 撰写文章
        ↓
4. 【审核点2】发送文章给主人审核
        ↓
5. media → 生成配图
        ↓
6. 【审核点3】最终确认 → publish发布</code></pre>
    </div>
  </div>
</div>

---

<span class="section-title">🔍 信息获取</span>

<div class="skill-item">
  <div class="skill-header">
    <span class="skill-icon">🌐</span>
    <div class="skill-title-row">
      <h3 class="skill-title">网页搜索</h3>
      <div class="skill-tags">
        <span class="skill-tag official">官方</span>
        <span class="skill-tag required">必装</span>
      </div>
    </div>
  </div>
  <p class="skill-desc">Tavily Search + Brave Search Worker 双引擎，实时获取网络信息，国内直连可用。</p>
  
  <div class="skill-details">
    <h4>🎯 使用方式</h4>
    <div class="skill-code">
<pre><code># 方式1: OpenClaw内置工具
web_search(query="AI编程工具对比", count=10)

# 方式2: Brave Search Worker
curl "https://search.getaibits.com/search?q=关键词" \
  -H "X-Proxy-Token: YOUR_TOKEN"

# 方式3: Tavily API
curl "https://api.tavily.com/search" \
  -H "Content-Type: application/json" \
  -d '{"query": "Kubernetes部署", "api_key": "tvly-xxx"}'</code></pre>
    </div>
    
    <h4>📁 配置</h4>
    <div class="skill-code">
<pre><code># ~/.openclaw/openclaw.json
{
  "tools": {
    "web": {
      "search": {
        "enabled": true,
        "provider": "tavily",
        "apiKey": "tvly-dev-xxx"
      }
    }
  }
}</code></pre>
    </div>
  </div>
</div>

<div class="skill-item">
  <div class="skill-header">
    <span class="skill-icon">🔬</span>
    <div class="skill-title-row">
      <h3 class="skill-title">深度研究</h3>
      <div class="skill-tags">
        <span class="skill-tag official">官方</span>
      </div>
    </div>
  </div>
  <p class="skill-desc">多引擎搜索 + 网页提取 + 结构化分析报告，自动生成完整调研报告。</p>
  
  <div class="skill-details">
    <h4>🎯 使用方式</h4>
    <div class="skill-code">
<pre><code># 自动研究流程
research_agent.execute({
    topic: "AI编程工具",
    depth: "comprehensive",
    output: "markdown_report"
})

# 输出包含
- 市场概览
- 主流工具对比
- 用户评价分析
- 选型建议</code></pre>
    </div>
  </div>
</div>

<div class="skill-item">
  <div class="skill-header">
    <span class="skill-icon">🔭</span>
    <div class="skill-title-row">
      <h3 class="skill-title">浏览器控制</h3>
      <div class="skill-tags">
        <span class="skill-tag official">官方</span>
        <span class="skill-tag required">必装</span>
      </div>
    </div>
  </div>
  <p class="skill-desc">无头Chrome截图、网页自动化、视觉调试，支持UI自动化测试。</p>
  
  <div class="skill-details">
    <h4>🎯 使用方式</h4>
    <div class="skill-code">
<pre><code># 打开网页
browser(action="open", profile="openclaw", url="https://example.com")

# 截图
browser(action="screenshot", profile="openclaw", targetId="xxx", fullPage=true)

# 获取页面快照
browser(action="snapshot", profile="openclaw", interactive=true, refs="aria")

# 点击元素
browser(action="act", kind="click", ref="e123")

# 输入文本
browser(action="act", kind="type", ref="e456", text="搜索内容")</code></pre>
    </div>
  </div>
</div>

---

<span class="section-title">✍️ 内容创作</span>

<div class="skill-item">
  <div class="skill-header">
    <span class="skill-icon">📝</span>
    <div class="skill-title-row">
      <h3 class="skill-title">公众号文章写作</h3>
      <div class="skill-tags">
        <span class="skill-tag official">官方</span>
        <span class="skill-tag hot">热门</span>
      </div>
    </div>
  </div>
  <p class="skill-desc">卡兹克风格写作，极短段落、口语化、情绪穿插，自动生成高质量公众号文章。</p>
  
  <div class="skill-details">
    <h4>🎯 写作风格</h4>
    <div class="skill-code">
<pre><code># 卡兹克风格特点
- 一句话一段
- 口语化断句："真的离谱。"
- 情绪穿插："想想就焦虑。"
- 数字精确强调
- 个人视角："我第一次看到..."
- 固定结尾："以上，既然看到这里了..."

# 使用示例
sessions_spawn(
    agentId="content",
    task="写一篇关于AI焦虑的公众号文章，卡兹克风格",
    mode="run"
)

# 自动保存到
~/Documents/Obsidian Vault/00 草稿箱/</code></pre>
    </div>
  </div>
</div>

<div class="skill-item">
  <div class="skill-header">
    <span class="skill-icon">🖼️</span>
    <div class="skill-title-row">
      <h3 class="skill-title">AI图片生成</h3>
      <div class="skill-tags">
        <span class="skill-tag official">官方</span>
        <span class="skill-tag required">必装</span>
      </div>
    </div>
  </div>
  <p class="skill-desc">Nano Banana Pro (Gemini 3) 文生图，2K高清配图生成，支持多种风格。</p>
  
  <div class="skill-details">
    <h4>🎯 使用方式</h4>
    <div class="skill-code">
<pre><code># 方式1: Nano Banana Pro脚本
cd ~/.openclaw/workspace/skills/nano-banana-pro
uv run scripts/generate_image.py \
  --prompt "一只戴墨镜的可爱猫咪，赛博朋克风格" \
  --filename "cyber-cat.png" \
  --resolution 2K

# 方式2: API调用
curl "http://zx2.52youxi.cc:3000/v1/images/generations" \
  -H "Authorization: Bearer sk-xxx" \
  -d '{"prompt": "cute cat", "size": "1024x1024"}'

# 支持模型
- gemini-2.5-flash-image
- gemini-3-flash-preview
- gemini-3-pro-image-preview</code></pre>
    </div>
  </div>
</div>

---

<span class="section-title">💻 技术开发</span>

<div class="skill-item">
  <div class="skill-header">
    <span class="skill-icon">💻</span>
    <div class="skill-title-row">
      <h3 class="skill-title">代码开发</h3>
      <div class="skill-tags">
        <span class="skill-tag official">官方</span>
      </div>
    </div>
  </div>
  <p class="skill-desc">Python/Node.js/Shell脚本开发，工具制作，自动化流程搭建。</p>
  
  <div class="skill-details">
    <h4>🎯 使用方式</h4>
    <div class="skill-code">
<pre><code># 文件操作
read(file_path="/path/to/file.md")
write(file_path="/path/to/output.md", content="# Hello")
edit(file_path="config.json", old_string="xxx", new_string="yyy")

# 执行命令
exec(command="ls -la", timeout=10)

# ACP代理（Codex/Claude Code）
sessions_spawn(
    agentId="dev",
    runtime="acp",
    task="写一个Python爬虫",
    mode="run"
)</code></pre>
    </div>
  </div>
</div>

<div class="skill-item">
  <div class="skill-header">
    <span class="skill-icon">🐙</span>
    <div class="skill-title-row">
      <h3 class="skill-title">GitHub操作</h3>
      <div class="skill-tags">
        <span class="skill-tag official">官方</span>
      </div>
    </div>
  </div>
  <p class="skill-desc">仓库/Issues/PR/代码搜索，不开网页管理GitHub项目。</p>
  
  <div class="skill-details">
    <h4>🎯 常用命令</h4>
    <div class="skill-code">
<pre><code># 查看PR状态
gh pr list --repo owner/repo

# 创建Issue
gh issue create --title "Bug: xxx" --body "描述"

# 代码搜索
gh search code "function name" --language python

# 查看CI状态
gh run list --repo owner/repo

# 克隆仓库
gh repo clone owner/repo</code></pre>
    </div>
  </div>
</div>

---

<span class="section-title">📱 平台集成</span>

<div class="skill-item">
  <div class="skill-header">
    <span class="skill-icon">📄</span>
    <div class="skill-title-row">
      <h3 class="skill-title">飞书文档</h3>
      <div class="skill-tags">
        <span class="skill-tag official">官方</span>
      </div>
    </div>
  </div>
  <p class="skill-desc">飞书文档读写、知识库管理、多维表格操作，完整办公自动化。</p>
  
  <div class="skill-details">
    <h4>🎯 使用方式</h4>
    <div class="skill-code">
<pre><code># 读取文档
feishu_doc(action="read", doc_token="xxx")

# 写入文档
feishu_doc(action="write", doc_token="xxx", content="# 标题")

# 操作多维表格
feishu_bitable_list_records(app_token="xxx", table_id="xxx")

# 发送消息到群
message(action="send", channel="feishu", target="chat_id", message="Hello")</code></pre>
    </div>
  </div>
</div>

<div class="skill-item">
  <div class="skill-header">
    <span class="skill-icon">🚀</span>
    <div class="skill-title-row">
      <h3 class="skill-title">内容发布</h3>
      <div class="skill-tags">
        <span class="skill-tag official">官方</span>
      </div>
    </div>
  </div>
  <p class="skill-desc">公众号/博客/飞书多平台发布，一键分发到多个渠道。</p>
  
  <div class="skill-details">
    <h4>🎯 发布流程</h4>
    <div class="skill-code">
<pre><code># 1. 发布到getaibits.com
write(file="/Projects/ai-bits/content/posts/xxx.md")
exec("git add . && git commit -m 'add post' && git push")

# 2. 发布到公众号（需要人工审核）
message(channel="feishu", target="publish_group", 
        message="文章已就绪，请审核后发布到公众号")

# 3. 发布到EvoMap
# 通过悬赏任务接口提交</code></pre>
    </div>
  </div>
</div>

---

<div class="cta-box">
  <h3>🚀 开始使用</h3>
  <p>在飞书总控中心发送消息，描述你的需求，AI团队会自动调用相关技能组合完成任务。</p>
</div>

</div>
