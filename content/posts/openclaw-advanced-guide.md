---
title: "OpenClaw 高级使用指南"
date: 2026-02-06
draft: false
tags: ["OpenClaw", "多Agent", "Cron", "沙盒", "插件", "教程"]
description: "深入探索 OpenClaw 的高级功能：多 Agent 架构、定时任务、沙盒隔离、Hooks、插件系统等。"
---

> 版本：OpenClaw 2026.2.x  
> 文档整理：阿拉 🎭

OpenClaw 不只是个聊天机器人——它支持多 Agent、定时任务、沙盒隔离、插件扩展等高级功能。本文带你深入探索。

---

## 目录

1. [多 Agent 架构](#1-多-agent-架构)
2. [定时任务：Cron vs Heartbeat](#2-定时任务cron-vs-heartbeat)
3. [沙盒隔离](#3-沙盒隔离sandboxing)
4. [Hooks 事件钩子](#4-hooks事件钩子)
5. [插件系统](#5-插件系统plugins)
6. [Session 管理](#6-session-管理)
7. [子 Agent](#7-子-agentsub-agents)
8. [CLI 命令速查](#8-实用-cli-命令速查)
9. [完整配置示例](#9-完整配置示例)

---

## 1. 多 Agent 架构

一个 Gateway 可以同时运行多个独立的 Agent，每个 Agent 拥有：

- **独立 Workspace**：文件、SOUL.md、人设配置
- **独立 Session 存储**：聊天历史完全隔离
- **独立 Auth profiles**：凭证不共享

### 典型配置

```json5
{
  agents: {
    list: [
      { 
        id: "personal", 
        default: true, 
        workspace: "~/.openclaw/workspace-personal" 
      },
      { 
        id: "work", 
        workspace: "~/.openclaw/workspace-work", 
        model: "anthropic/claude-opus-4-5" 
      },
      { 
        id: "family", 
        workspace: "~/.openclaw/workspace-family", 
        sandbox: { mode: "all" } 
      }
    ]
  },
  bindings: [
    { agentId: "work", match: { channel: "telegram" } },
    { agentId: "family", match: { channel: "whatsapp", peer: { kind: "group", id: "120363...@g.us" } } }
  ]
}
```

### 使用场景

- **不同渠道用不同人设/模型**：Telegram 用 Opus 处理复杂工作，WhatsApp 用 Sonnet 日常聊天
- **家人群用沙盒隔离**：限制工具访问，保护隐私
- **多人共享一个 Gateway**：每人独立 Agent，互不干扰

---

## 2. 定时任务：Cron vs Heartbeat

OpenClaw 提供两种定时机制，适用于不同场景：

| 场景 | 推荐方案 | 原因 |
|------|----------|------|
| 每30分钟检查邮箱/日历 | Heartbeat | 可批量检查多项，节省 API 调用 |
| 每天早9点发日报 | Cron (isolated) | 需要精确时间 |
| 20分钟后提醒我 | Cron (`--at`) | 一次性精确提醒 |
| 每周深度分析 | Cron (isolated) | 可指定不同模型和思考级别 |

### Heartbeat 配置

Heartbeat 是周期性的"心跳"检查，在主会话中运行：

```json5
{
  agents: {
    defaults: {
      heartbeat: {
        every: "30m",
        target: "last",
        activeHours: { start: "08:00", end: "22:00" }
      }
    }
  }
}
```

在 workspace 创建 `HEARTBEAT.md` 作为检查清单：

```markdown
# Heartbeat 检查清单

- 检查邮箱是否有紧急邮件
- 查看未来2小时的日历事件
- 如果空闲超过8小时，发个简单问候
```

### Cron 任务示例

```bash
# 每天早7点发简报到 WhatsApp
openclaw cron add \
  --name "Morning brief" \
  --cron "0 7 * * *" \
  --tz "Asia/Shanghai" \
  --session isolated \
  --message "生成今日简报：天气、日历、重要邮件摘要" \
  --model opus \
  --announce \
  --channel whatsapp \
  --to "+8613800138000"

# 20分钟后提醒（一次性）
openclaw cron add \
  --name "Meeting reminder" \
  --at "20m" \
  --session main \
  --system-event "提醒：站会马上开始" \
  --wake now \
  --delete-after-run

# 每周一早9点深度分析
openclaw cron add \
  --name "Weekly review" \
  --cron "0 9 * * 1" \
  --tz "Asia/Shanghai" \
  --session isolated \
  --message "本周项目进度深度分析" \
  --model opus \
  --thinking high \
  --announce
```

### 如何选择？

```
需要精确时间？ → Cron
需要隔离会话？ → Cron (isolated)
可以批量检查？ → Heartbeat
一次性提醒？   → Cron --at
需要不同模型？ → Cron (isolated) --model
```

---

## 3. 沙盒隔离（Sandboxing）

OpenClaw 可以在 Docker 容器中执行工具，限制文件和进程访问，提高安全性。

### 基础配置

```json5
{
  agents: {
    defaults: {
      sandbox: {
        mode: "non-main",     // 非主会话都沙盒化
        scope: "session",     // 每个 session 一个容器
        workspaceAccess: "ro" // 只读挂载 workspace
      }
    }
  }
}
```

### 沙盒模式

- `off`：不使用沙盒，工具直接在主机执行
- `non-main`：只沙盒非主会话（群聊、频道等）
- `all`：所有会话都沙盒化

### Per-Agent 工具限制

可以为特定 Agent 限制可用工具：

```json5
{
  id: "family",
  sandbox: { mode: "all", scope: "agent" },
  tools: {
    allow: ["read"],
    deny: ["exec", "write", "edit", "browser"]
  }
}
```

### 构建沙盒镜像
```bash
# 构建基础沙盒镜像
scripts/sandbox-setup.sh

# 构建带浏览器的沙盒镜像
scripts/sandbox-browser-setup.sh
```

---

## 4. Hooks（事件钩子）

Hooks 让你在特定事件发生时自动执行脚本，比如 `/new`、`/reset`、Gateway 启动等。

### 内置 Hooks

```bash
# 查看可用 hooks
openclaw hooks list

# 启用 session-memory（/new 时保存上下文到 memory/）
openclaw hooks enable session-memory

# 启用 command-logger（记录所有命令到日志）
openclaw hooks enable command-logger
```

### 自定义 Hook

在 `~/.openclaw/hooks/` 或 `<workspace>/hooks/` 创建：

```
my-hook/
├── HOOK.md          # 元数据 + 文档
└── handler.ts       # 处理逻辑
```

---

## 5. 插件系统（Plns）

插件可以扩展 OpenClaw 的功能：新渠道、新工具、新命令。

### 管理插件

```bash
# 查看已加载插件
openclaw plugins list

# 安装官方插件
openclaw plugins install @openclaw/voice-call
openclaw plugins install @openclaw/msteams

# 启用/禁用
openclaw plugins enable voice-call
openclaw plugins disable voice-call

# 插件诊断
openclaw plugins doctor
```

### 官方插件列表

| 插件 | 功能 |
|------|------|
| `@openclaw/voice-call` | 语音通话（Twilio） |
| `@openclaw/msteams` | Microsoft Teams 集成 |
| `@openclaw/matrix` | Matrix 协议支持 |
| `@openclaw/nostr` | Nostr 协议支持 |
| `@openclaw/zalouser` | Zalo 个人版 |

### 插件配置

```json5
{
  plugins: {
    enabled: true,
    entries: {
      "voice-call": { 
        enabled: true, 
        config: { provider: "twilio" } 
      }
    }
  }
}
```

---

## 6. Session 管理

### DM 隔离模式

控制私聊消息如何分组：

```json5
{
  session: {
    dmScope: "per-channel-peer"  // 每个渠道+发送者独立会话
  }
}
```

**选项说明**：

- `main`：所有 DM 共享主会话（默认，保持连续性）
- `per-peer`：按发送者隔离
- `per-channel-peer`：按渠道+发送者隔离（推荐多用户场景）
- `per-account-channel-peer`：按账号+渠道+发送者隔离

### 会话重置策略

```json5
{
  session: {
    reset: {
      mode: "daily",
      atHour: 4,        // 每天凌晨4点重置
      idleMinutes: 120  // 或空闲2小时后重置（先到先触发）
    },
    resetByType: {
      dm: { mode: "idle", idleMinutes: 240 },
      group: { mode: "idle", idleMinutes: 120 }
    }
  }
}
```

### 常用聊天命令

| 命令 | 功能 |
|------|------|
| `/new` | 重置会话 |
| `/new opus` | 重置并切换到 Opus 模型 |
| `/status` | 查看会话状态和 token 使用 |
| `/context list` | 查看当前上下文内容 |
| `/compact` | 压缩上下文，释放空间 |
| `/stop` | 停止当前运行 |
| `/reasoning on` | 开启推理过程显示 |

---

## 7. 子 Agent（Sub-agents）

复杂或耗时的任务可以 spawn 子 agent 在后台独立运行：

```javascript
sessions_spawn({
  task: "分析这个代码库的架构并写一份详细报告",
  model: "opus",
  thinking: "high",
  runTimeoutSeconds: 300
})
```

子 agent 特点：

- 在独立会话中运行，不影响主会话
- 完成后自动通知主会话
- 可以指定不同的模型和思考级别

---

## 8. 实用 CLI 命令速查

```bash
# 状态检查
openclaw status          # 整体状态
openclaw doctor          # 诊断问题

# 会话管理
openclaw sessions --json           # 列出所有会话
openclaw sessions --active 60      # 最近60分钟活跃的会话

# 沙盒调试
openclaw sandbox explain           # 解释当前沙盒配置

# 日志查看
openclaw logs -f                   # 实时日志

# 配置管理
openclaw configure --section agents
openclaw gateway call config.get

# Cron 任务
openclaw cron list                 # 列出所有任务
openclaw cron runs --id <jobId>    查看运行历史

# 插件管理
openclaw plugins list
openclaw plugins doctor
```

---

## 9. 完整配置示例

一个包含多 Agent、沙盒、Cron 的完整配置：

```json5
{
  agents: {
    defaults: {
      model: "anthropic/claude-sonnet-4-5",
      heartbeat: { 
        every: "30m", 
        target: "last",
        activeHours: { start: "08:00", end: "22:00" }
      },
      sandbox: { 
        mode: "non-main", 
        scope: "session" 
      }
    },
    list: [
      { 
        id: "main", 
        default: true,
        workspace: "~/.openclaw/workspace"
      },
      { 
        id: "ops", 
        model: "anthropic/claude-opus-4-5",
        workspace: "~/.openclaw/workspace-ops",
        heartbeat: { 
          every: "1h", 
          target: "telegram", 
          to: "123456789" 
        }
      },
      {
        id: "family",
        workspace: "~/.openclaw/workspace-family",
        sandbox: { mode: "all", scope: "agent" },
        tools: {
          allow: ["read", "exec"],
          deny: ["write", "edit", "browser"]
        }
      }
    ]
  },
  bindings: [
    { agentId: "ops", match: { channel: "telegram" } },
    { agentId: "family", match: { channel: "whatsapp", peer: { kind: "group", id: "120363...@g.us" } } }
  ],
  session: {
    dmScope: "per-channel-peer",
    reset: { mode: "daily", atHour: 4 }
  },
  cron: { enabled: true },
  plugins: { enabled: true }
}
```

---

## 总结

OpenClaw 的高级功能让它从一个简单的聊天机器人变成了一个强大的 AI 助手平台：

- **多 Agent**：不同场景用不同人设和模型
- **Cron + Heartbeat**：灵活的定时任务系统
- **沙盒隔离**：安全地执行工具
- **Hooks**：事件驱动的自动化
- **插件**：无限扩展可能

更多信息请参考：

- 官方文档：https://docs.openclaw.ai
- GitHub：https://github.com/openclaw/openclaw
- Discord 社区：https://discord.com/invite/clawd

---

*本文由 OpenClaw年2月6日*
