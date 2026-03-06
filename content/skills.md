---
title: "技能商店"
date: 2026-03-06
draft: false
layout: "skills"
url: "/skills.html"
---

<style>
.skills-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 1.5rem;
  margin-top: 2rem;
}

.skill-card {
  background: var(--code-bg);
  border-radius: 12px;
  padding: 1.5rem;
  transition: transform 0.2s, box-shadow 0.2s;
  border: 1px solid var(--border);
}

.skill-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(0,0,0,0.12);
}

.skill-header {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  margin-bottom: 0.75rem;
}

.skill-icon {
  font-size: 1.5rem;
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--primary);
  border-radius: 8px;
}

.skill-title {
  font-size: 1.1rem;
  font-weight: 600;
  color: var(--primary);
  margin: 0;
}

.skill-tags {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
  margin-bottom: 0.75rem;
}

.skill-tag {
  font-size: 0.75rem;
  padding: 0.25rem 0.5rem;
  border-radius: 4px;
  background: var(--tertiary);
  color: var(--secondary);
}

.skill-tag.official {
  background: #3b82f6;
  color: white;
}

.skill-tag.hot {
  background: #ef4444;
  color: white;
}

.skill-desc {
  font-size: 0.9rem;
  color: var(--secondary);
  line-height: 1.5;
  margin: 0;
}

.section-title {
  font-size: 1.5rem;
  font-weight: 600;
  margin: 2rem 0 1rem;
  padding-bottom: 0.5rem;
  border-bottom: 2px solid var(--primary);
  display: inline-block;
}
</style>

<div class="skills-container">

🔧 **全部技能**

这里是 AI Bits 博客背后的全部技能和能力展示。每个技能都代表一个可独立运行的功能模块。

---

<span class="section-title">🤖 Agent 协作</span>

<div class="skills-grid">

<div class="skill-card">
  <div class="skill-header">
    <span class="skill-icon">🏗️</span>
    <h3 class="skill-title">多Agent团队配置</h3>
  </div>
  <div class="skill-tags">
    <span class="skill-tag official">官方</span>
    <span class="skill-tag hot">热门</span>
  </div>
  <p class="skill-desc">一只AI变一支团队——配置6个AI角色协作，总控中心+研究分析+内容创作+技术开发+多媒体+发布运营。</p>
</div>

<div class="skill-card">
  <div class="skill-header">
    <span class="skill-icon">🔄</span>
    <h3 class="skill-title">Agent任务分发</h3>
  </div>
  <div class="skill-tags">
    <span class="skill-tag official">官方</span>
    <span class="skill-tag">必装</span>
  </div>
  <p class="skill-desc">智能识别任务类型，自动派发给对应Agent执行，支持复杂多步骤工作流编排。</p>
</div>

<div class="skill-card">
  <div class="skill-header">
    <span class="skill-icon">✅</span>
    <h3 class="skill-title">质量审核机制</h3>
  </div>
  <div class="skill-tags">
    <span class="skill-tag official">官方</span>
  </div>
  <p class="skill-desc">关键节点人工审核，支持通过/修改/重写三种反馈，确保输出质量可控。</p>
</div>

</div>

<span class="section-title">🔍 信息获取</span>

<div class="skills-grid">

<div class="skill-card">
  <div class="skill-header">
    <span class="skill-icon">🌐</span>
    <h3 class="skill-title">网页搜索</h3>
  </div>
  <div class="skill-tags">
    <span class="skill-tag official">官方</span>
    <span class="skill-tag">必装</span>
  </div>
  <p class="skill-desc">Tavily Search + Brave Search Worker 双引擎，实时获取网络信息，国内直连可用。</p>
</div>

<div class="skill-card">
  <div class="skill-header">
    <span class="skill-icon">🔬</span>
    <h3 class="skill-title">深度研究</h3>
  </div>
  <div class="skill-tags">
    <span class="skill-tag official">官方</span>
  </div>
  <p class="skill-desc">多引擎搜索 + 网页提取 + 结构化分析报告，自动生成完整调研报告。</p>
</div>

<div class="skill-card">
  <div class="skill-header">
    <span class="skill-icon">📄</span>
    <h3 class="skill-title">PDF文档分析</h3>
  </div>
  <div class="skill-tags">
    <span class="skill-tag official">官方</span>
  </div>
  <p class="skill-desc">智能PDF解析，提取关键信息，支持学术论文、报告、合同等文档类型。</p>
</div>

</div>

<span class="section-title">✍️ 内容创作</span>

<div class="skills-grid">

<div class="skill-card">
  <div class="skill-header">
    <span class="skill-icon">📝</span>
    <h3 class="skill-title">公众号文章写作</h3>
  </div>
  <div class="skill-tags">
    <span class="skill-tag official">官方</span>
    <span class="skill-tag hot">热门</span>
  </div>
  <p class="skill-desc">卡兹克风格写作，极短段落、口语化、情绪穿插，自动生成高质量公众号文章。</p>
</div>

<div class="skill-card">
  <div class="skill-header">
    <span class="skill-icon">🖼️</span>
    <h3 class="skill-title">AI图片生成</h3>
  </div>
  <div class="skill-tags">
    <span class="skill-tag official">官方</span>
    <span class="skill-tag">必装</span>
  </div>
  <p class="skill-desc">Nano Banana Pro (Gemini 3) 文生图，2K高清配图生成，支持多种风格。</p>
</div>

<div class="skill-card">
  <div class="skill-header">
    <span class="skill-icon">🧑</span>
    <h3 class="skill-title">文本人性化</h3>
  </div>
  <div class="skill-tags">
    <span class="skill-tag official">官方</span>
    <span class="skill-tag">必装</span>
  </div>
  <p class="skill-desc">去除AI生成痕迹，支持小红书/知乎/学术等多种风格转换。</p>
</div>

</div>

<span class="section-title">💻 技术开发</span>

<div class="skills-grid">

<div class="skill-card">
  <div class="skill-header">
    <span class="skill-icon">💻</span>
    <h3 class="skill-title">代码开发</h3>
  </div>
  <div class="skill-tags">
    <span class="skill-tag official">官方</span>
  </div>
  <p class="skill-desc">Python/Node.js/Shell脚本开发，工具制作，自动化流程搭建。</p>
</div>

<div class="skill-card">
  <div class="skill-header">
    <span class="skill-icon">🔭</span>
    <h3 class="skill-title">浏览器控制</h3>
  </div>
  <div class="skill-tags">
    <span class="skill-tag official">官方</span>
    <span class="skill-tag">必装</span>
  </div>
  <p class="skill-desc">无头Chrome截图、网页自动化、视觉调试，支持UI自动化测试。</p>
</div>

<div class="skill-card">
  <div class="skill-header">
    <span class="skill-icon">🐙</span>
    <h3 class="skill-title">GitHub操作</h3>
  </div>
  <div class="skill-tags">
    <span class="skill-tag official">官方</span>
  </div>
  <p class="skill-desc">仓库/Issues/PR/代码搜索，不开网页管理GitHub项目。</p>
</div>

</div>

<span class="section-title">📱 平台集成</span>

<div class="skills-grid">

<div class="skill-card">
  <div class="skill-header">
    <span class="skill-icon">📄</span>
    <h3 class="skill-title">飞书文档</h3>
  </div>
  <div class="skill-tags">
    <span class="skill-tag official">官方</span>
  </div>
  <p class="skill-desc">飞书文档读写、知识库管理、多维表格操作，完整办公自动化。</p>
</div>

<div class="skill-card">
  <div class="skill-header">
    <span class="skill-icon">🚀</span>
    <h3 class="skill-title">内容发布</h3>
  </div>
  <div class="skill-tags">
    <span class="skill-tag official">官方</span>
  </div>
  <p class="skill-desc">公众号/博客/飞书多平台发布，一键分发到多个渠道。</p>
</div>

<div class="skill-card">
  <div class="skill-header">
    <span class="skill-icon">🎯</span>
    <h3 class="skill-title">EvoMap任务</h3>
  </div>
  <div class="skill-tags">
    <span class="skill-tag official">官方</span>
  </div>
  <p class="skill-desc">自动发现和执行EvoMap悬赏任务，赚取积分奖励。</p>
</div>

</div>

---

**使用方法**：在总控中心描述你的需求，系统会自动调用相关技能组合完成任务。

</div>
