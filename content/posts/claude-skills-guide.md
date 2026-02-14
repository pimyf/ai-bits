---
title: "Claude Skills 神级用法指南"
date: 2026-02-14
draft: false
tags: ["Claude", "AI", "Skills", "教程", "Claude Code"]
description: "Claude Skills 完整指南：10 个神级技巧、实战示例、最佳实践，让 Claude 从通用助手变成专属专家"
author: "Gavin"
---

> 整理自 Anthropic 官方文档、GitHub 社区和实战经验

## 一、Skills 是什么？

Skills 是自定义指令，扩展 Claude 的能力。通过 `SKILL.md` 文件，你可以：
- 编码机构知识和最佳实践
- 标准化输出格式
- 处理复杂的多步骤工作流

## 二、Skills vs 其他扩展方式

| 类型 | 用途 | 特点 |
|------|------|------|
| **Skills** | 可复用的知识/工作流 | 便携、可跨项目共享 |
| **Subagents** | 独立的专用代理 | 隔离上下文、受限工具 |
| **Commands** | 快捷操作 | 用户手动触发 |
| **Hooks** | 自动化脚本 | 在特定时机自动执行 |
| **MCP Servers** | 外部工具集成 | 连接第三方服务 |

## 三、神级技巧

### 1. 🎯 精准触发：写好 description

**差的写法：**
```yaml
description: 帮助处理 PDF 和文档
```

**神级写法：**
```yaml
description: "PDF 操作工具包：提取文本和表格、创建新 PDF、合并/拆分文档、处理表单。当需要填写 PDF 表单或批量处理 PDF 时使用。不用于简单查看或基本转换。"
```

关键：具体动词 + 使用场景 + 明确边界

### 2. 🔒 控制调用权限

```yaml
---
name: deploy
description: 部署应用到生产环境
disable-model-invocation: true  # 只能手动触发，防止 Claude 自作主张
---
```

| 配置 | 你能调用 | Claude 能调用 |
|------|---------|--------------|
| 默认 | ✅ | ✅ |
| `disable-model-invocation: true` | ✅ | ❌ |
| `user-invocable: false` | ❌ | ✅ |

### 3. 🍴 Fork 模式：隔离执行

```yaml
---
name: deep-research
description: 深度研究某个主题
context: fork        # 在隔离的子代理中运行
agent: Explore       # 使用只读探索代理
---

研究 $ARGUMENTS：
1. 用 Glob 和 Grep 找相关文件
2. 阅读分析代码
3. 总结发现，附带文件引用
```

### 4. 💉 动态注入上下文

用 `` !`command` `` 语法在 skill 执行前运行命令：

```yaml
---
name: pr-summary
description: 总结 PR 变更
context: fork
---

## PR 上下文
- PR diff: !`gh pr diff`
- PR 评论: !`gh pr view --comments`
- 变更文件: !`gh pr diff --name-only`

## 任务
总结这个 PR...
```

命令输出会替换占位符，Claude 看到的是实际数据！

### 5. 🔧 限制工具访问

```yaml
---
name: safe-reader
description: 只读模式浏览文件
allowed-tools: Read, Grep, Glob  # 只能读，不能写
---
```

### 6. 📁 多文件 Skill 结构
\ill/
├── SKILL.md          # 主入口（必需）
├── reference.md      # 详细 API 文档（按需加载）
├── examples.md       # 使用示例
├── templates/
│   └── output.md     # 输出模板
└── scripts/
    └── validate.sh   # 可执行脚本
```

在 SKILL.md 中引用：
```markdown
## 资源
- 完整 API 详情见 [reference.md](reference.md)
- 使用示例见 [examples.md](examples.md)
```

### 7. 🎭 参数传递

```yaml
---
name: migrate-component
description: 迁移组件到新框架
---

将 $0 组件从 $1 迁移到 $2。
保留所有现有行为和测试。
```

调用：`/migrate-component SearchBar React Vue`

### 8. 🪝 Hooks：确定性自动化

Hooks 比 CLAUDE.md 指令更可靠——它们是确定性的，保证执行：

```bash
# 让 Claude 帮你写 hook
"写一个 hook，在每次文件编辑后运行 eslint"
"写一个 hook，阻止对 migrations 文件夹的写入"
```

### 9. 🧠 Subagent 记忆指令

在 subagent 的 markdown 中加入记忆指令：

```markdown
## 记忆维护
发现代码路径、模式、库位置和关键架构决策时，更新你的代理记忆。
这会在对话间积累机构知识。
简洁记录你发现了什么、在哪里。
```

### 10. 🎯 用 Gemini CLI 作为后备

Claude 的 WebFetch 无法访问某些网站（如 Reddit）。创建一个 skill 让 Claude 用 Gemini CLI 作为后备：

```yaml
---
name: web-fallback
description: 当 WebFetch 失败时使用 Gemini CLI 获取网页内容
---

如果 WebFetch 无法访问某个 URL，使用 Gemini CLI 作为后备：
gemini "请获取并总结这个网页的内容: [URL]"
```

## 四、实战 Skill 示例

### 代码可视化器

```yaml
---
name: codebase-visualizer
description: 生成项目文件结构的交互式 HTML 树视图
allowed-tools: Bash(python *)
---

# 代码库可视化器
生成交互式 HTML 树视图，显示项目文件结构和可折叠目录。

## 使用
从项目根目录运行：
```bash
python ~/.claude/skills/codebase-visualizer/scripts/visualize.py .
```
```

### 业务定位参考

```yaml
---
name: business-context
description: 业务定位和品牌信息参考
user-invocable: false  # 只让 Claude 自动调用
---

# 业务定位
- 目标客户：...
- 核心价值：...
- 差异化：...

写 CTA、关于页面、销售文案时参考此文件。
```

### Git 提交规范

```yaml
---
name: commit
description: 按规范创建 git commit
disable-model-invocation: true
---

创建符合规范的 commit：
1. 运行 `git diff --staged` 查看变更
2. 按 Conventional Commits 格式写 commit message
3. 类型：feat/fix/docs/style/refactor/test/chore
4. 执行 `git commit -m "..."` 
```

## 五、最佳实践

1. **从真实用例开始** - 至少做过 5 次、还会做 10 次以上的任务才值得写 skill
2. **定义成功标准** - 告诉 Claude 好的输出长什么样
3. **用 skill-creator** - Anthropic 官方的 [skill-creator](https://github.com/anthropics/skills/tree/main/skill-creator) 帮你写结构良好的 skill
4. **测试三种场景**：正常操作、边缘情况、超出范围的请求
5. **迭代优化** - 根据实际使用不断改进

## 六、资源链接

- [官方 Skills 文档](https://code.claude.com/docs/en/skills)
- [Anthropic Skills 仓库](https://github.com/anthropics/skills)
- [Awesome Claude Skills](https://github.com/travisvn/awesome-claude-skills)
- [45 Claude Code Tips](https://github.com/ykdojo/claude-code-tips)
- [36 Skills 实例](https://aiblewmymind.substack.com/p/claude-skills-36-examples)
