---
title: "多Agent团队配置"
date: 2026-03-06
draft: false
url: "/skills/multi-agent.html"
---

<style>
.skill-detail {
  max-width: 900px;
  margin: 0 auto;
}

.skill-header {
  text-align: center;
  padding: 3rem 0;
  background: linear-gradient(135deg, rgba(59, 130, 246, 0.1), rgba(16, 185, 129, 0.1));
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
.skill-tag.hot { background: #ef4444; color: white; }
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

.section h3 {
  font-size: 1.3rem;
  color: var(--secondary);
  margin: 2rem 0 1rem 0;
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

.agent-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1rem;
  margin: 1.5rem 0;
}

.agent-card {
  background: var(--code-bg);
  border-radius: 12px;
  padding: 1.5rem;
  border: 1px solid var(--border);
}

.agent-card h4 {
  margin: 0 0 0.5rem 0;
  color: var(--primary);
  font-size: 1.1rem;
}

.agent-card p {
  margin: 0;
  font-size: 0.9rem;
  color: var(--secondary);
}

.workflow {
  background: var(--code-bg);
  border-radius: 12px;
  padding: 1.5rem;
  margin: 1rem 0;
}

.workflow-step {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 0.8rem 0;
  border-bottom: 1px dashed var(--border);
}

.workflow-step:last-child {
  border-bottom: none;
}

.step-num {
  width: 30px;
  height: 30px;
  background: var(--primary);
  color: white;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  flex-shrink: 0;
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
  <div class="skill-icon-large">🏗️</div>
  <h1 class="skill-title">多Agent团队配置</h1>
  <div class="skill-tags">
    <span class="skill-tag official">官方</span>
    <span class="skill-tag hot">热门</span>
    <span class="skill-tag required">核心</span>
  </div>
</div>

## 概述

一只AI变一支团队——通过配置多个AI角色协作，实现复杂任务的自动化处理。总指挥统一调度，各Agent各司其职，形成完整的工作流。

---

## 🎯 包含技能

<div class="agent-grid">
  <div class="agent-card">
    <h4>🎯 总控中心 (main)</h4>
    <p>任务分发、结果汇总、协调各Agent工作</p>
  </div>
  <div class="agent-card">
    <h4>🔬 研究分析专家 (research)</h4>
    <p>商业分析、文献检索、数据调研</p>
  </div>
  <div class="agent-card">
    <h4>✍️ 内容创作专家 (content)</h4>
    <p>公众号文章、博客、教案撰写</p>
  </div>
  <div class="agent-card">
    <h4>💻 技术开发专家 (dev)</h4>
    <p>代码开发、工具制作、脚本编写</p>
  </div>
  <div class="agent-card">
    <h4>🎨 多媒体专家 (media)</h4>
    <p>图片生成、PPT制作、视频脚本</p>
  </div>
  <div class="agent-card">
    <h4>🚀 发布运营专家 (publish)</h4>
    <p>内容排版、多平台发布、数据分析</p>
  </div>
</div>

---

## 💻 配置方法

### 1. 基础配置

<div class="code-block">
<pre># ~/.openclaw/openclaw.json

{
  "agents": {
    "defaults": {
      "model": {
        "primary": "kimi-coding/k2p5"
      },
      "workspace": "/Users/mac/.openclaw/workspace"
    },
    "list": [
      {
        "id": "main",
        "name": "总控中心",
        "default": true,
        "workspace": "/Users/mac/.openclaw/workspace"
      },
      {
        "id": "research",
        "name": "研究分析专家",
        "workspace": "/Users/mac/.openclaw/workspace-research"
      },
      {
        "id": "content",
        "name": "内容创作专家",
        "workspace": "/Users/mac/.openclaw/workspace-content"
      },
      {
        "id": "dev",
        "name": "技术开发专家",
        "workspace": "/Users/mac/.openclaw/workspace-dev"
      },
      {
        "id": "media",
        "name": "多媒体专家",
        "workspace": "/Users/mac/.openclaw/workspace-media"
      },
      {
        "id": "publish",
        "name": "发布运营专家",
        "workspace": "/Users/mac/.openclaw/workspace-publish"
      }
    ]
  }
}</pre>
</div>

### 2. 飞书群绑定

<div class="code-block">
<pre>"bindings": [
  {
    "agentId": "research",
    "match": {
      "channel": "feishu",
      "peer": {
        "kind": "group",
        "id": "oc_xxx"  // 研究分析中心群
      }
    }
  },
  {
    "agentId": "content",
    "match": {
      "channel": "feishu",
      "peer": {
        "kind": "group", 
        "id": "oc_xxx"  // 内容创作工坊群
      }
    }
  }
  // ... 其他Agent同理
]</pre>
</div>

---

## 🔄 工作流程

### 典型任务执行流程

<div class="workflow">
  <div class="workflow-step">
    <span class="step-num">1</span>
    <div>用户在总控中心描述需求："帮我调研AI编程工具，写一篇公众号文章"</div>
  </div>
  <div class="workflow-step">
    <span class="step-num">2</span>
    <div>总控中心分析任务，派发给 research Agent 进行调研</div>
  </div>
  <div class="workflow-step">
    <span class="step-num">3</span>
    <div>research 完成调研报告，返回给总控中心</div>
  </div>
  <div class="workflow-step">
    <span class="step-num">4</span>
    <div>【审核点】主人审核调研报告，确认后继续</div>
  </div>
  <div class="workflow-step">
    <span class="step-num">5</span>
    <div>总控中心派发 content Agent 撰写文章</div>
  </div>
  <div class="workflow-step">
    <span class="step-num">6</span>
    <div>【审核点】主人审核文章内容，确认后继续</div>
  </div>
  <div class="workflow-step">
    <span class="step-num">7</span>
    <div>media Agent 生成配图</div>
  </div>
  <div class="workflow-step">
    <span class="step-num">8</span>
    <div>publish Agent 发布到各平台</div>
  </div>
</div>

---

## 📋 代码示例

### 派发任务

<div class="code-block">
<pre># 在总控中心执行

sessions_spawn(
    agentId="research",
    task="调研Kubernetes零停机部署最佳实践",
    mode="run"
)

# Agent完成后自动返回结果
# 结果包含：调研报告、数据来源、分析结论</pre>
</div>

### 任务类型映射

<div class="code-block">
<pre>TASK_TYPE_MAPPING = {
    # 研究分析类
    "调研": "research",
    "分析": "research",
    "检索": "research",
    "报告": "research",
    
    # 内容创作类
    "写作": "content",
    "文章": "content",
    "博客": "content",
    "公众号": "content",
    
    # 技术开发类
    "代码": "dev",
    "开发": "dev",
    "脚本": "dev",
    "工具": "dev",
    
    # 多媒体类
    "图片": "media",
    "配图": "media",
    "PPT": "media",
    
    # 发布运营类
    "发布": "publish",
    "排版": "publish",
    "运营": "publish"
}

# 自动识别并派发
def dispatch_task(user_input):
    for keyword, agent_id in TASK_TYPE_MAPPING.items():
        if keyword in user_input:
            return sessions_spawn(agentId=agent_id, task=user_input)
    
    # 复杂任务需要多个Agent协作
    return dispatch_multi_agent_workflow(user_input)</pre>
</div>

---

## 🎯 使用场景

| 场景 | Agent组合 | 输出 |
|------|-----------|------|
| **公众号文章** | research → content → media → publish | 完整文章+配图+发布 |
| **技术调研** | research → dev | 调研报告+Demo代码 |
| **产品发布** | research → content → media → publish | 发布文案+海报+多平台发布 |
| **工具开发** | research → dev → publish | 需求分析+代码实现+文档 |

---

## ⚙️ 高级配置

### 质量审核机制

在每个关键环节设置审核点：

<div class="code-block">
<pre># content Agent 的 SOUL.md 中添加

## 质量审核规则

完成文章后，必须：
1. 将文章发送给主人审核
2. 等待主人反馈（通过/修改/重写）
3. 根据反馈处理后再继续下一步

审核消息模板：
```
【文章初稿完成，等待审核】

标题：XXX
字数：XXX字
文件路径：XXX

请审核，回复：
- "通过" → 进入配图阶段
- "修改：具体意见" → 我修改后再提交
- "重写" → 需要重新调研资料
```</pre>
</div>

---

## 📚 相关技能

- [🔄 Agent任务分发](/skills/task-dispatch.html) - 智能识别任务类型自动派发
- [✅ 质量审核机制](/skills/quality-review.html) - 关键节点人工审核
- [📤 飞书消息通知](/skills/feishu-msg.html) - Agent完成任务后通知到群

---

<div style="text-align: center; margin-top: 3rem; padding: 2rem; background: var(--code-bg); border-radius: 12px;">
  <h3>🚀 开始使用</h3>
  <p>在飞书总控中心描述你的需求，AI团队会自动协作完成任务。</p>
  <a href="/skills.html" style="display: inline-block; margin-top: 1rem; padding: 0.8rem 2rem; background: var(--primary); color: white; text-decoration: none; border-radius: 8px; font-weight: 500;">查看全部技能 →</a>
</div>

</div>
