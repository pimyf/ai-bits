---
title: "从 Clawdbot 升级到 OpenClaw：超简单迁移指南"
date: 2026-02-03
draft: false
tags: ["OpenClaw", "Clawdbot", "升级", "迁移"]
description: "Clawdbot 升级到 OpenClaw 的完整步骤，以及一个容易踩的坑。"
---

刚把 Clawdbot 升级到了 OpenClaw，整个过程特别简单，数据和配置都能自动迁移过来。

## 升级步骤

**1. 停止旧服务**

```
clawdbot gateway stop
```

**2. 安装 OpenClaw**

```
npm i -g openclaw@latest
```

**3. 迁移数据**

```
openclaw doctor
```

这一步会自动把你的数据、配置全部迁过来，不用手动备份。

**4. 启动新服务**

```
openclaw gateway start
```

搞定！原来的历史记录什么的都还在。

---

## ⚠️ 踩坑提醒

**安装完之后，先别急着执行 `openclaw gateway start`！**

如果你跟我一样手快先启动了，会创建新的配置目录，导致旧数据不会自动迁移。

**补救方法：**

```
rm -rf ~/.openclaw
```

```
openclaw doctor
```

删掉新建的目录，重新跑一遍 doctor 就好了。

---

## 总结

升级顺序：**stop → install → doctor → start**

记住先跑 `openclaw doctor` 再启动，别踩我的坑 😅
