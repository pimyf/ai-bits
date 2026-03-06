---
title: "Kubernetes 零停机部署实战指南"
date: 2026-03-06
draft: false
tags: ["Kubernetes", "DevOps", "零停机部署", "云原生", "微服务"]
description: "深入介绍 Kubernetes 零停机部署的完整方案，包括滚动更新策略、健康检查机制、优雅终止流程、Pod中断预算配置，以及实战 YAML 示例和常见问题排查"
author: "Gavin"
---

在微服务架构和云原生时代，应用的持续可用性已成为基础设施的核心要求。无论是发布新功能、修复漏洞还是扩容缩容，开发者都希望在不影响用户体验的前提下完成部署。

本文将深入介绍 Kubernetes 零停机部署的完整方案，从核心概念到实战配置，帮助你构建高可用的应用发布流程。

---

## 核心概念

零停机部署的核心理念是：**在整个更新过程中，始终有健康的 Pod 实例在处理用户请求**。要实现这一目标，需要协调多个 Kubernetes 机制协同工作。

### 1. 滚动更新策略

Kubernetes Deployment 默认采用 RollingUpdate 策略，通过 `maxSurge` 和 `maxUnavailable` 两个参数控制更新节奏。

`maxSurge` 定义了更新过程中可以临时创建的额外 Pod 数量，比如设置为 1 表示允许比期望值多 1 个 Pod。`maxUnavailable` 则规定了更新过程中允许不可用的 Pod 数量上限。

在生产环境中，建议将 `maxUnavailable` 设为 0，这样可以确保即使在新版本 Pod 启动过程中，旧版本 Pod 也至少有一个在运行，不会出现服务真空期。

### 2. 健康检查机制

健康检查是零停机部署的"守门员"，它确保只有真正准备好处理流量的 Pod 才会接收请求。

**Readiness Probe（就绪探针）**负责判断 Pod 是否已准备好接收流量。当探针通过时，Pod 的 IP 会被加入 Service 的后端列表；失败时则被移除。这个机制防止了新启动但尚未完成初始化的 Pod 被分配流量。

**Liveness Probe（存活探针）**则用于检测应用是否陷入死锁或卡顿状态。当探针连续失败达到阈值时，Kubernetes 会自动重启容器，避免僵尸进程占用资源。

### 3. 优雅终止

当 Pod 需要被删除时，Kubernetes 会执行一系列预设流程，给应用足够的时间处理完正在进行的请求。

首先执行 `preStop` 钩子，可以执行一些清理脚本。随后 Kubernetes 向容器主进程发送 SIGTERM 信号，通知应用开始关闭。应用在收到信号后应该停止接收新请求，同时等待现有请求处理完成。如果在 `terminationGracePeriodSeconds` 规定的时间内应用仍未退出，系统将强制发送 SIGKILL 信号终止进程。

### 4. Pod 中断预算

PodDisruptionBudget（PDB）是一种保护机制，用于应对**自愿中断**场景，比如节点维护、集群升级或自动缩容。

通过设置 `minAvailable` 或 `maxUnavailable`，PDB 确保在任何时刻都保持足够数量的可用 Pod。当 Kubernetes 需要驱逐 Pod 时，会检查 PDB 约束，如果操作会导致可用 Pod 数量低于阈值，则该操作会被阻止。

---

## 配置详解

理解了核心概念后，让我们来看看具体的配置实现。

### Deployment 配置

一个完整的零停机部署配置包含以下关键部分：

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  selector:
    matchLabels:
      app: web-app
  template:
    spec:
      terminationGracePeriodSeconds: 60
      containers:
      - name: web
        image: myapp:v1.0.0
        ports:
        - containerPort: 8080
        readinessProbe:
          httpGet:
            path: /health/ready
            port: 8080
          initialDelaySeconds: 10
          periodSeconds: 5
          timeoutSeconds: 3
          failureThreshold: 3
        livenessProbe:
          httpGet:
            path: /health/live
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 10
          timeoutSeconds: 5
          failureThreshold: 3
        lifecycle:
          preStop:
            exec:
              command: ["/bin/sh", "-c", "sleep 15"]
```

**配置要点解析**：

- `maxUnavailable: 0` 确保更新时不会有服务中断
- `terminationGracePeriodSeconds: 60` 给应用 60 秒完成优雅关闭
- Readiness Probe 设置 10 秒初始延迟，给应用启动时间
- preStop 钩子添加 15 秒延迟，确保 Service 能及时将 Pod 从后端列表中移除

### PodDisruptionBudget 配置

```yaml
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: web-app-pdb
spec:
  minAvailable: 2
  selector:
    matchLabels:
      app: web-app
```

这个配置保证即使在进行节点维护或集群操作时，至少还有 2 个 Pod 可用。

### Service 配置

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-app-service
spec:
  selector:
    app: web-app
  ports:
  - port: 80
    targetPort: 8080
  publishNotReadyAddresses: false
```

关键配置是 `publishNotReadyAddresses: false`，确保流量只转发到 Ready 状态的 Pod。

---

## 实践指南

### 应用层面的优雅关闭实现

仅配置 Kubernetes 还不够，应用本身也需要正确处理关闭信号。以下是一个 Python 示例：

```python
import signal
import sys
import time

def graceful_shutdown(signum, frame):
    print("Received SIGTERM, starting graceful shutdown...")
    # 1. 停止接收新请求（如关闭 HTTP 服务器）
    server.stop_accepting()
    # 2. 等待现有请求完成
    server.wait_for_requests(timeout=30)
    # 3. 关闭数据库连接等资源
    db.close()
    # 4. 退出
    sys.exit(0)

signal.signal(signal.SIGTERM, graceful_shutdown)
```

核心逻辑是：**先停止接收新流量，再处理完存量流量，最后清理资源退出**。

### 部署验证步骤

在生产环境实施前，建议按以下步骤验证配置：

**步骤 1：模拟滚动更新**
```bash
# 执行更新并观察
kubectl set image deployment/web-app web=myapp:v2.0.0
kubectl rollout status deployment/web-app --watch
```

**步骤 2：验证服务可用性**
在另一个终端持续请求服务，确认更新过程中没有 502/503 错误：
```bash
while true; do curl -s -o /dev/null -w "%{http_code}\n" http://service-ip/; sleep 1; done
```

**步骤 3：测试优雅终止**
删除一个 Pod，观察应用是否正确处理：
```bash
kubectl delete pod <pod-name> --grace-period=60
kubectl logs <pod-name> --follow
```

### 常见问题与解决方案

**问题 1：更新过程中服务中断**

现象：滚动更新时偶尔出现请求失败。

排查：检查 Readiness Probe 配置是否合理。如果应用启动时间较长但 `initialDelaySeconds` 设置太短，Pod 可能在未准备好时就被加入流量池。

解决：增加 `initialDelaySeconds` 或使用 startupProbe 替代。

**问题 2：Pod 终止时连接丢失**

现象：用户请求在部署过程中被中断。

排查：查看应用日志，确认是否正确处理了 SIGTERM 信号。检查 `terminationGracePeriodSeconds` 是否足够长。

解决：在应用中添加信号处理逻辑，确保收到 SIGTERM 后不再接受新连接。同时增加 preStop 钩子延迟，给负载均衡器更新后端列表的时间。

**问题 3：PDB 阻止节点维护**

现象：执行 `kubectl drain` 时卡住，提示被 PDB 阻止。

排查：确认 PDB 的 `minAvailable` 设置是否与当前副本数匹配。

解决：临时增加副本数，或调整 PDB 为 `maxUnavailable: 1`。注意不要在生产高峰期进行节点维护。

---

## 总结

Kubernetes 零停机部署的实现依赖于多个组件的协同配合：

**滚动更新策略**控制新旧 Pod 的切换节奏，通过合理设置 `maxSurge` 和 `maxUnavailable`，可以在保证容量的前提下平滑过渡。

**健康检查机制**是流量路由的"开关"，Readiness Probe 确保只有真正就绪的 Pod 接收流量，Liveness Probe 则保障整体服务的健康度。

**优雅终止流程**给了应用体面的"告别"机会，通过 SIGTERM 信号传递和 preStop 钩子，确保正在处理的请求能够完整响应。

**Pod 中断预算**则是高可用性的最后一道防线，在集群运维操作时保护业务不被意外中断。

将这些机制组合使用，并配合应用层的信号处理实现，就能构建真正可靠的零停机部署方案。建议团队建立部署规范检查清单，在每次发布前确认相关配置，逐步将零停机部署打造成标准实践。

---

*本文由 OpenClaw 多 Agent 协作系统生成*  
*参考 EvoMap 悬赏任务整理*
