---
title: "从零开始：用 OpenClaw 打造你的飞书 AI 助手（保姆级教程）"
date: 2026-02-02
draft: false
tags: ["OpenClaw", "飞书", "AI", "教程"]
description: "让 Claude 住进你的飞书，随时随地帮你干活。从安装到配置，手把手教你搭建私人 AI 助手。"
---

> 让 Claude 住进你的飞书，随时随地帮你干活

## 这是什么？

你可能听说过 ChatGPT、Claude 这些 AI，但每次用都要打开网页，复制粘贴，很麻烦。

**OpenClaw** 可以把这些 AI 接入你常用的聊天软件——飞书、微信、Telegram 等。装好之后，你直接在飞书里跟 AI 对话，就像跟同事聊天一样自然。

**它能做什么？**
- 💬 在飞书里直接和 AI 对话
- 📝 帮你写文档、改文案、翻译
- 🧠 记住你们的对话历史（不用每次重新解释背景）
- 🔧 执行各种任务（读文件、查天气、管理日程等）

## OpenClaw 的前世今生

这个项目改过好几次名字，你在网上搜可能会看到不同的名字：

| 时间 | 名字 | 说明 |
|------|------|------|
| 最早 | Clawdbot | 最初的名字 |
| 中期 | Moltbot | 改过一次名 |
| 现在 | **OpenClaw** | 当前正式名称 |

所以 Clawdbot、Moltbot、OpenClaw 都是同一个东西，图标是只小龙虾 🦞

**官方资源：**
- GitHub：https://github.com/openclaw/openclaw
- 文档：https://docs.openclaw.ai
- 技能市场：https://clawhub.com

---

## 第一步：准备工作

### 1.1 检查 Node.js 版本

OpenClaw 需要 Node.js 22 或更高版本。

打开终端（Mac 按 `Cmd + 空格`，输入 `terminal`），输入：

```bash
node --version
```

![终端显示 node 版本](https://img.getaibits.com/openclaw-guide/node-version.png)

**如果显示 v22.x.x 或更高** → 继续下一步

**如果显示版本太低或 command not found** → 去 [Node.js 官网](https://nodejs.org/) 下载安装 LTS 版本

### 1.2 准备大模型 API

OpenClaw 需要连接大模型才能工作。你有几个选择：

| 方案 | 模型 | 价格 | 推荐指数 | 说明 |
|------|------|------|----------|------|
| **Anthropic 官方** | Claude 4 | 按量付费 | ⭐⭐⭐⭐⭐ | 最聪明，需要国外信用卡 |
| **OpenRouter** | Claude/GPT 等 | 按量付费 | ⭐⭐⭐⭐⭐ | 中转站，支持多种模型，支付方便 |
| **智谱 GLM** | GLM-4 | 有免费额度 | ⭐⭐⭐⭐ | 国产模型，注册送 token |
| **DeepSeek** | DeepSeek | 很便宜 | ⭐⭐⭐⭐ | 国产模型，性价比高 |

**我的推荐：**
- 💰 **预算充足** → Anthropic 官方 Claude（最强）
- 🌏 **没有国外信用卡** → OpenRouter（可以用支付宝）或智谱 GLM
- 🆓 **想免费试试** → 智谱 GLM（新用户送 2000 万 token）

下面我会教你配置 **OpenRouter**（最灵活）和 **Anthropic 官方**（最强）两种方案。

---

## 第二步：安装 OpenClaw

打开终端，复制粘贴以下命令：

```bash
npm install -g openclaw@latest
```

等待安装完成，看到类似这样的输出就成功了：

![npm 安装成功](https://img.getaibits.com/openclaw-guide/npm-install.png)

---

## 第三步：初始化配置

运行初始化向导：

```bash
openclaw onboard --install-daemon
```

会出现一系列问题，按下面的选择：

### 3.1 风险确认

```
◇ I understand this is powerful and inherently risky. Continue?
│ Yes
```

选 **Yes**

### 3.2 选择模式

```
◇ Onboarding mode
│ QuickStart
```

选 **QuickStart**

### 3.3 选择模型提供商

这里根据你的情况选择：

![模型提供商选择界面](https://img.getaibits.com/openclaw-guide/model-provider.png)

---

#### 方案 A：使用 OpenRouter（推荐大多数人）

**第一步：注册 OpenRouter**

1. 打开 https://openrouter.ai
2. 点击右上角 Sign In，用 Google 账号登录
3. 点击头像 → Keys → Create Key
4. 复制生成的 API Key（以 `sk-or-` 开头）

![OpenRouter 创建 API Key](https://img.getaibits.com/openclaw-guide/openrouter-key.png)

**第二步：充值（可选）**

OpenRouter 有少量免费额度可以试用。如果要正式使用：
- 点击头像 → Credits → Add Credits
- 支持支付宝，充 $5 够用很久

**第三步：在 OpenClaw 中配置**

初始化时选择：
```
◇ Model/auth provider
│ OpenRouter
```

然后粘贴你的 API Key：
```
◇ Enter OpenRouter API key
│ sk-or-v1-xxxxxxxxxxxxxxxx
```

**第四步：选择默认模型**

推荐选择：
```
◇ Default model
│ anthropic/claude-sonnet-4 (推荐，性价比高)
```

或者如果预算充足：
```
│ anthropic/claude-opus-4 (最强，但贵)
```

---

#### 方案 B：使用 Anthropic 官方

**第一步：注册 Anthropic**

1. 打开 https://console.anthropic.com
2. 注册账号（需要国外手机号验证）
3. 绑定信用卡（需要国外信用卡）
4. 进入 API Keys → Create Key
5. 复制 API Key（以 `sk-ant-` 开头）

![Anthropic API Key 页面](https://img.getaibits.com/openclaw-guide/anthropic-key.png)

**第二步：在 OpenClaw 中配置**

初始化时选择：
```
◇ Model/auth provider
│ Anthropic
```

粘贴 API Key：
```
◇ Enter Anthropic API key
│ sk-ant-api03-xxxxxxxxxxxxxxxx
```

默认模型会自动设置为 Claude。

---

#### 方案 C：使用智谱 GLM（国内免费方案）

**第一步：注册智谱**

1. 打开 https://open.bigmodel.cn
2. 注册账号（手机号即可）
3. 进入控制台 → API Keys → 创建 API Key
4. 复制 API Key

新用户赠送 2000 万 token，够用很久。

**第二步：在 OpenClaw 中配置**

初始化时选择：
```
◇ Model/auth provider
│ Z.AI (GLM 4.7)
```

粘贴 API Key：
```
◇ Enter Z.AI API key
│ xxxxxxxxxxxxxxxx
```

---

### 3.4 配置技能（可选）

```
◇ Configure skills now? (recommended)
```

新手建议直接跳过（选 No），后面可以随时添加。

### 3.5 启用 Hooks

```
◇ Enable hooks?
│ 🚀 boot-md, 📝 command-logger, 💾 session-memory
```

建议全选，特别是 **session-memory**（让 AI 记住对话历史）。

### 3.6 完成！

看到这个界面就成功了：

![安装成功，显示 Dashboard ready](https://img.getaibits.com/openclaw-guide/dashboard-ready.png)

浏览器会自动打开控制面板，你可以在这里测试对话。

---

## 第四步：接入飞书

现在 OpenClaw 已经在运行了，接下来把它接入飞书。

### 4.1 创建飞书应用

1. 打开 [飞书开放平台](https://open.feishu.cn/app)
2. 点击「创建应用」→「企业自建应用」

平台首页](https://img.getaibits.com/openclaw-guide/feishu-create-app.png)

3. 填写应用信息：
   - 应用名称：随便起（比如"AI 助手"）
   - 应用描述：随便写
   
4. 创建完成后，进入应用详情页

### 4.2 添加机器人能力

1. 左侧菜单点击「应用能力」→「添加应用能力」
2. 选择「机器人」，点击添加

![添加机器人能力](https://img.getaibits.com/openclaw-guide/feishu-add-bot.png)

### 4.3 配置权限

1. 左侧菜单点击「权限管理」
2. 点击「批量导入权限」
3. 粘贴以下 JSON：

```json
{
  "scopes": {
    "tenant": [
      "im:message",
      "im:message:send_as_bot",
      "im:message.p2p_msg:readonly",
      "im:message.group_at_msg:readonly",
      "im:resource",
      "im:message.group_msg",
      "im:message:readonly",
      "im:message:update",
      "im:message:recall",
      "im:message.reactions:read"
    ],
    "user": [
      "contact:user.base:readonly"
    ]
  }
}
```

4. 点击「导入」，然后「申请开通」

![批量导入权限](https://img.getaibits.com/openclaw-guide/feishu-permissions.png)

### 4.4 获取密钥

1. 左侧菜单点击「凭证与基础信息」
2. 找到「应用凭证」部分
3. 记下这两个值：
   - **App ID**（格式：`cli_xxxxxx`）
   - **App Secret**（点击显示后复制）

![应用凭证页面](https://img.getaibits.com/openclaw-guide/feishu-credentials.png)

### 4.5 安装飞书插件

回到终端，运行：

```bash
openclaw plugins install @m1hewd/feishu
```

### 4.6 配置飞书连接

把下面的命令中的 `cli_xxxxxx` 和 `你的AppSecret` 替换成你刚才记下的值：

```bash
openclaw config set channels.feishu.appId "cli_xxxxxx"
openclaw config set channels.feishu.appSecret "你的AppSecret"
openclaw config set channels.feishu.enabled true
openclaw config set channels.feishu.connectionMode "websocket"
```

然后重启：

```bash
openclaw gateway restart
```

### 4.7 启用飞书回调

回到飞书开放平台：

1. 左侧菜单点击「事件与回调」
2. 点击「回调配置」→ 订阅方式选「**使用长连接接收回调**」→ 保存

![回调配置页面](https://img.getaibits.com/openclaw-guide/feishu-callback.png)

3. 点击「事件配置」→ 同样选择「使用长连接接收回调」→ 保存

4. 点击「添加事件」→ 搜索 `im.message.receive_v1` → 添加

![添加事件](https://img.getaibits.com/openclaw-guide/feishu-events.png)

### 4.8 发布应用

1. 点击页面顶部的「创建版本」
2. 填写版本号（比如 1.0.0）和更新说明
3. 点击「保存」然后「申请发布」

![创建版本](https://img.getaibits.com/openclaw-guide/feishu-publish.png)

---

## 第五步：开始使用！

现在打开飞书：

1. 搜索你刚创建的机器人名称
2. 发起私聊
3. 发送一条消息试试！

![飞书中和机器人对话](https://img.getaibits.com/openclaw-guide/feishu-chat.png)

**恭喜！你的 AI 助手已经上线了！** 🎉

---

## 常见问题

### Q: 机器人不回复消息？

检查清单：
1. ✅ 确认添加了 `im.message.receive_v1` 事件
2. ✅ 确认回调配置使用了「长连接」
3. ✅ 确认应用已发布
4. ✅ 运行 `openclaw gateway status` 检查服务状态

### Q: 提示"应用未建立长连接"？

确保先完成 OpenClaw 配置并重启（`openclaw gateway restart`），再去飞书后台设置回调。

### Q: 如何查看日志？

```bapenclaw gateway logs
```

### Q: 如何停止/重启服务？

```bash
# 查看状态
openclaw gateway status

# 重启
openclaw gateway restart

# 停止
openclaw gateway stop

# 启动
openclaw gateway start
```

### Q: 如何更换模型？

```bash
# 查看当前配置
openclaw config get model

# 修改默认模型（以 OpenRouter 为例）
openclaw config set model.default "anthropic/claude-sonnet-4"

# 重启生效
openclaw gateway restart
```

---

## 进阶玩法

装好基础版之后，你还可以：

- 📅 **连接日历** - 让 AI 帮你管理日程
- 📧 **读取邮件** - 自动处理收件箱
- 🔧 **执行命令** - 让 AI 帮你操作电脑
- 📝 **管理笔记** - 记录和检索信息

这些功能需要安装额外的技能（Skills），可以在 [ClawHub](https://clawhub.com) 探索。

---
## 总结

| 步骤 | 内容 |
|------|------|
| 1 | 安装 Node.js 22+ |
| 2 | `npm install -g openclaw@latest` |
| 3 | `openclaw onboard --install-daemon` |
| 4 | 创建飞书应用 + 配置权限 |
| 5 | 安装飞书插件 + 配置连接 |
| 6 | 启用飞书回调 + 发布应用 |

整个过程大约 15-30 分钟，遇到问题欢迎留言！

---

**相关链接：**
- [OpenClaw 官方文档](https://docs.openclaw.ai)
- [GitHub 仓库](https://github.com/openclaw/openclaw)
- [飞书插件源码](https://github.com/m1heng/clawdbot-feishu)
- [Discord 社区](https://discord.com/invite/clawd)
