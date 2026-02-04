---
title: "OpenClaw 小白入门 + 黑科技玩法"
date: 2026-02-04T16:50:00+08:00
draft: false
tags: ["openclaw", "教程", "cli", "ai"]
categories: ["教程"]
description: "从零开始，5分钟上手 OpenClaw AI 神器"
---

> 从零开始，5分钟上手你的 AI 神器

📌 **说明**：本文使用**原生 OpenClaw 命令**（终端操作）。聊天框里直接输 `/model xxx` 这种快捷方式是**插件功能**，下一篇教程专门讲怎么做这个插件。

---

## 一、OpenClaw 是什么？

简单说：**OpenClaw 是一个 AI 智能助手框架**，它可以把 Claude、GPT、Kimi 等大模型变成你的"数字管家"。

它最厉害的地方是——**不仅能在聊天框里对话，还能操控你的电脑、浏览器、文件、甚至其他设备**。

---

## 二、基础命令（必学）

### 1. 查看状态
```bash
openclaw status          # 看看 OpenClaw 还活着吗
openclaw gateway status  # 网关状态
openclaw gateway health  # 健康检查
```

### 2. 网关管理（重点！）
```bash
openclaw gateway start   # 启动网关
openclaw gateway stop    # 停止网关
openclaw gateway restart # 重启网关（配置改完必做）
```

💡 **什么时候用？**
- 刚安装完 → `start`
- 改了配置（比如换 API 地址）→ `restart`
- 出问题了先试试 → `restart`

### 3. 查看日志（排错神器）
```bash
openclaw logs            # 看日志
openclaw logs -f         # 实时跟踪日志
```

---

## 三、终端模型管理（核心功能）

OpenClaw 强大的地方在于**终端命令控制一切**，不需要在聊天框里输命令。

### 查看模型状态
```bash
openclaw models status           # 当前在用哪个模型
openclaw models list             # 列出所有可用模型
openclaw models aliases list     # 查看已配置的别名
```

### 切换模型（重点！）
```bash
# 切换到指定模型
openclaw models set kimi-coding/kimi-k2p5
openclaw models set anthropic/claude-opus-4

# 使用别名（如果配置了）
openclaw models set kimi
openclaw models set claude

# 切换后必须重启网关才能生效
openclaw gateway restart
```

### 配置模型别名（推荐！）
在 `~/.openclaw/openclaw.json` 里添加：
```json
{
  "models": {
    "aliases": {
      "kimi": "kimi-coding/kimi-k2p5",
      "claude": "anthropic/claude-opus-4",
      "opus": "anthropic/claude-opus-4"
    }
  }
}
```

然后就能用简写切换：
```bash
openclaw models set kimi    # 代替长长的模型ID
```

### 认证管理
```bash
openclaw models auth add              # 添加 API Key
openclaw models auth login --provider anthropic   # OAuth 登录
openclaw models scan                  # 扫描可用模型
```

---

## 四、进阶玩法（开始变强）

### 1. 多模型配置
OpenClaw 支持同时配置多个模型，随时切换：

```json
{
  "models": {
    "providers": {
      "anthropic": {
        "baseUrl": "https://api.anthropic.com",
        "apiKey": "sk-xxx"
      },
      "china-claude": {
        "baseUrl": "http://43.228.76.217:13003",
        "apiKey": "sk-xxx"
      }
    }
  }
}
```

完整配置示例（`~/.openclaw/openclaw.json`）：
```json
{
  "models": {
    "aliases": {
      "claude": "anthropic/claude-opus-4",
      "kimi": "kimi-coding/kimi-k2p5"
    },
    "providers": {
      "anthropic": {
        "baseUrl": "https://api.anthropic.com",
        "apiKey": "sk-xxx"
      },
      "kimi-coding": {
        "baseUrl": "https://api.moonshot.cn",
        "apiKey": "sk-xxx"
      }
    }
  }
}
```

然后终端里 `openclaw models set claude` 就能切换！

### 2. 定时任务（Cron）
让 AI 定时帮你做事：

```bash
# 查看定时任务
openclaw cron list

# 添加任务 - 主会话模式（简单提醒）
openclaw cron add --name "morning-reminder" \
  --cron "0 8 * * *" \
  --tz "Asia/Shanghai" \
  --session main \
  --system-event "早上好！检查今天的日程和邮件。" \
  --wake now

# 添加任务 - 隔离会话模式（复杂任务，可发送到渠道）
openclaw cron add --name "daily-report" \
  --cron "0 9 * * *" \
  --session isolated \
  --message "总结昨天的工作并生成报告" \
  --deliver --channel telegram --to "@username"
```

💡 **实用场景**：
- 定时检查邮箱
- 定时查天气并提醒
- 定时备份文件

### 3. 子代理（Sessions Spawn）
**黑科技来了！** 可以让 AI 开"小号"去执行任务：

```
# 在聊天里让 AI 开子代理
去帮我搜索最新的 AI 新闻，然后总结给我
```

或者直接终端（使用工具调用）：
```bash
# 通过工具直接创建子会话任务
# 实际命令：sessions_spawn（通过 OpenClaw 工具系统）
```

💡 更常见的是在聊天中让 AI 直接执行，AI 会自动调用 `sessions_spawn` 工具创建子代理。

**子代理会**：
- 独立运行，不打扰你
- 完成任务后汇报结果
- 可以同时开多个任务

### 4. 浏览器自动化
让 AI 帮你操作浏览器：

```bash
# 查看浏览器标签页
openclaw browser tabs

# 查看浏览器配置
openclaw browser profiles

# 打开网页
openclaw browser open https://example.com

# 截图
openclaw browser screenshot
```

💡 **配合聊天更香**：
> "帮我去京东查一下 iPhone 16 的价格"

AI 会自动打开浏览器、搜索、截图给你！

---

## 五、黑科技玩法（高手篇）

### 1. 消息渠道集成
OpenClaw 可以对接各种聊天软件：

```bash
# 查看已配置渠道
openclaw channels list

# 发送消息
openclaw message send --channel telegram --to "用户名" --message "你好"
```

支持：**Telegram、Discord、Slack、WhatsApp、Signal、飞书** 等

💡 **骚操作**：
- AI 监听到重要邮件 → 自动发微信提醒
- 定时任务完成 → 自动发 Discord 通知
- 服务器出问题了 → 自动发报警消息

### 2. 节点管理（Nodes）
如果你有多个设备（手机、平板、另一台电脑）：

```bash
# 查看配对设备
openclaw nodes list
openclaw nodes status

# 拍照（需要设备已配对并支持 camera）
openclaw nodes camera snap --node "iPhone"

# 屏幕录制（需要设备已配对并支持 screen）
openclaw nodes screen record --node "iPad" --duration 10s --out ~/Desktop/screen.mp4
```

💡 **骚操作**：
- 让 AI 用你手机拍张照
- 远程查看家里电脑屏幕
- 手机收到消息自动转发到电脑

### 3. 插件系统（Plugins）
OpenClaw 支持插件扩展：

```bash
# 查看已安装插件
openclaw plugins list

# 查看插件详情
openclaw plugins info <plugin-name>
```

💡 **Skills vs Plugins**：OpenClaw 中 `skills` 是功能模块（需要特定条件），`plugins` 是官方/社区插件。通过 `openclaw plugins list` 查看可用的插件。

实用插件推荐：
- **weather** - 查天气
- **github** - 操作 GitHub
- **apple-notes** - 管理备忘录
- **video-frames** - 视频截图

### 4. 飞书集成（国内用户福利）
飞书功能通过**飞书相关工具**实现，在 AI 聊天中直接使用：

```
# 读取飞书文档
请读取这个文档：https://xxx.feishu.cn/docx/xxx

# 读取多维表格
请查看这个表格的前10行：https://xxx.feishu.cn/base/xxx

# 发送飞书消息（需配置渠道）
openclaw message send --channel feishu --to "用户ID" --message "测试"
```

💡 需要先配置飞书应用的 `app_id` 和 `app_secret` 到环境变量。

---

## 六、配置技巧

### 1. 配置模型别名
在 `~/.openclaw/openclaw.json` 里配置别名，方便切换：

```json
{
  "models": {
    "aliases": {
      "kimi": "kimi-coding/kimi-k2p5",
      "claude": "anthropic/claude-opus-4"
    }
  }
}
```

然后就能简写切换：
```bash
openclaw models set kimi
```

💡 **下一篇预告**：我们还会写一个**模型切换插件**，让你在聊天框里直接输 `/model kimi` 就能切，比终端命令更方便！

### 2. 心跳任务（Heartbeat）
创建工作区 `HEARTBEAT.md`，AI 会定期检查：

```markdown
# 我的定时检查清单
- 检查未读邮件
- 查看今天日程
- 检查天气
```

### 3. 记忆系统
- `memory/YYYY-MM-DD.md` - 每日记录
- `MEMORY.md` - 长期记忆
- AI 会自动读取这些文件保持上下文

---

## 七、常见问题

**Q: 改了配置没生效？**
A: 记得 `openclaw gateway restart`

**Q: 怎么查看当前用什么模型？**
A: `openclaw models status`

**Q: 切换模型后对话还是用旧的？**
A: 需要 `openclaw gateway restart` 重启网关，然后新开会话

**Q: 子代理怎么用？**
A: 直接说"帮我开个任务去 xxx"，AI 会自己处理

**Q: 支持哪些模型？**
A: Claude、GPT、Kimi、Gemini、本地模型（Ollama）都可以

---

## 八、实战示例

### 示例1：让 AI 定时汇报
```bash
# 每天早上8点，让 AI 检查邮件并总结
openclaw cron add \
  --name "morning-email" \
  --cron "0 8 * * *" \
  --tz "Asia/Shanghai" \
  --session main \
  --system-event "检查未读邮件并总结要点" \
  --wake now
```

### 示例2：多设备拍照
```bash
# 让手机拍张照保存到电脑
openclaw nodes camera snap --node "iPhone"
```

### 示例3：自动发消息
```bash
# 任务完成后自动发 Telegram
openclaw message send \
  --channel telegram \
  --to "@your_username" \
  --message "任务完成！"
```

---

## 总结

OpenClaw = AI 大脑 + 自动化工具箱

**小白路线**：
1. 学会 `gateway start/restart`
2. 学会 `openclaw models set` 切换模型
3. 试试让 AI 帮你搜东西

**进阶路线**：
1. 配置多个模型
2. 用 Cron 做定时任务
3. 玩子代理和浏览器

**高手路线**：
1. 对接消息渠道
2. 多设备联动
3. 写自己的插件

---

## 📚 下期预告

下一篇我们会写：**《OpenClaw 模型切换插件开发》**

教你做一个插件，实现聊天框里直接输 `/model kimi` 就能切换模型，比终端命令更方便！

---

> 💡 **最后提醒**：OpenClaw 很强大，但别用来干坏事哦！

祝玩得开心！🎉
