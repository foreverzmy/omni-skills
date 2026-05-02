# Spec Coding

Spec Coding 是一套面向“纯 AI 持续开发大型项目”的工程工作流。它的目标不是写更多文档，而是让 AI agent 在长期、多轮、多任务的开发过程中，始终知道：当前系统真相是什么、下一步策略是什么、此刻该执行什么。

大型项目不能依赖聊天上下文持续推进。聊天会丢失、会膨胀、会混入过期信息，也无法稳定表达依赖关系。Spec Coding 把 AI 持续开发所需的上下文拆成三层稳定资产：

```text
Spec  ->  Plan  ->  Task
是什么    怎么做    现在做什么
```

- `Spec`：定义系统是什么，以及哪些约束必须成立。
- `Plan`：定义为了满足 Spec，采用什么策略、路径和编排方式。
- `Task`：定义当前可以执行、重试、追踪和 review 的最小工作单元。

## 为什么纯 AI 大型项目需要 Spec Coding

纯 AI 持续开发大型项目时，常见失败模式不是“不会写代码”，而是：

- **上下文污染**：AI 同时读到旧方案、新方案、临时讨论和废弃约束，无法判断哪个是真的。
- **真相漂移**：接口、能力、权限和边界在代码里变化了，但没有稳定 source of truth。
- **策略断层**：AI 知道目标，但不知道迁移顺序、依赖关系、rollout 风险和取舍。
- **任务失焦**：一个任务混入设计、实现、测试、重构和 follow-up，无法独立验收。
- **长程失忆**：跨多天、多 agent、多次会话后，只有聊天记录，缺少可恢复的执行状态。
- **错误复利**：小的假设偏差没有回写到 Spec 或 Plan，后续任务继续基于错误前提推进。

Spec Coding 的目标是让大型项目具备 AI 可持续推进的基本性质：

- **可裁剪上下文**：AI 只读取当前需要的 Spec、Plan 和 Task，不把历史噪声全部塞进上下文。
- **唯一当前真相**：`Spec` 层提供 current source of truth，避免多个版本同时生效。
- **可解释策略路径**：`Plan` 层保存为什么这样做、先后顺序是什么、风险如何控制。
- **可恢复执行状态**：`Task` 层记录当前执行、验收、阻塞、日志和 review。
- **向上回写机制**：Task 中的发现能更新 Plan；Plan 中的冲突能触发 Spec Patch。

## 三层模型

```text
Spec = source of truth
Plan = strategy + path
Task = execution unit
```

这三层不只是文档分类，而是 AI agent 的工作记忆分层；新功能尚未确认时，可以先在 Spec 层的 Draft Workspace 中调研和验证，再 promote 成 current Spec：

- `Spec` 给 AI 判断“什么必须保持正确”。
- `Plan` 给 AI 判断“为了满足 Spec，当前路线是什么”。
- `Task` 给 AI 判断“这一轮应该做什么，做到什么算完成”。

## 包含的 Skills

### `writing-spec`

当难点是维护当前唯一 source of truth 时，使用 `writing-spec`。

它关注：
- 输入和输出
- 行为规则
- 边界和边界条件
- invariants
- 权限和限制
- 新功能 Draft、需求调研、测试计划、验证证据和 candidate patches
- Current State Snapshot、Patch Log、Archive 和 Spec Graph 治理

核心定义：

```text
Spec = source of truth
```

安装：

```bash
npx skills add https://github.com/aiomni/omni-skills --skill writing-spec
```

### `writing-plan`

当难点是决定如何满足 Spec 的实施策略时，使用 `writing-plan`。

它关注：
- 技术路径
- 阶段拆解
- 依赖顺序
- orchestration
- 迁移路径
- rollout 和 rollback 策略
- tradeoff、风险和验证方式

核心定义：

```text
Plan = strategy + path
```

安装：

```bash
npx skills add https://github.com/aiomni/omni-skills --skill writing-plan
```

### `writing-tasks`

当难点是把 Plan 或明确目标下沉成可执行工作时，使用 `writing-tasks`。

它关注：
- 原子任务卡
- 可调度、可重试的执行单元
- 依赖和 blocker
- 验收标准
- 执行日志
- dashboard、inbox capture 和 review

核心定义：

```text
Task = execution unit
```

安装：

```bash
npx skills add https://github.com/aiomni/omni-skills --skill writing-tasks
```

> `writing-tasks` 是任务执行层，承接旧 `writing-plans` 中的任务系统职责。策略层 planning 现在由 `writing-plan` 负责。

## 推荐工作流

### 1. 建立 current truth

当系统真相不清楚、接口边界混乱、权限约束分散或旧文档互相冲突时，先用 `writing-spec` 建立当前唯一真相。

AI 默认应该读 current Spec，而不是 replay 历史讨论、Patch Log 或 Archive。

如果是新功能调研、需求尚不清晰、需要测试开发或有多种演进路线，先用 `writing-spec` 创建 Draft。Draft 不是 current truth；只有用户确认并通过 candidate patches promote 后，才更新 current Spec。

### 2. 从 Spec 推导 Plan

用 `writing-plan` 把 Spec 转成实施策略：
- 选择技术路径。
- 拆分阶段和里程碑。
- 写清依赖、关键路径和 orchestration。
- 标注风险、验证方式、rollout 和 rollback。
- 识别可下沉的 task candidates。

Plan 不是 TODO list。Plan 解决“怎么做”和“为什么这样做”。

### 3. 从 Plan 下沉 Task

用 `writing-tasks` 把 Plan 中的 task candidates 变成可执行任务：
- 每个 Task 有独立目标和验收标准。
- 每个 Task 可调度、可重试、可 review。
- 执行日志、阻塞和动态调整必须写回任务系统。
- 完成前必须 review 是否影响后续任务、Plan 或 Spec。

Task 不是 Spec，也不是策略文档。Task 解决“现在做什么”。

### 4. 执行发现向上回写

纯 AI 长期开发必须有回写机制：

```text
Task discovery -> Plan update -> Spec Patch when needed
```

- Task 执行发现路线变化，更新 Plan。
- Task 执行发现系统真相变化，提出 Spec Patch。
- Plan 发现 Spec 缺失或冲突，提出 Spec Patch。
- Spec 变化后，同步检查 Plan 和 Task 是否失效。

### 5. 完成后触发下一层

Spec Coding 的每一层完成后，都应该主动判断是否需要进入下一层，而不是把链路断在当前产物：

- `writing-spec` 更新完 Spec 后，如果当前环境已安装 `writing-plan`，询问用户是否要基于已更新的 Spec 制定实施计划；如果未安装 `writing-plan`，提示用户可以使用 `writing-plan` 执行实施计划。
- `writing-plan` 制定完实施计划后，如果当前环境已安装 `writing-tasks`，询问用户是否要把 Plan 下沉成可执行工作；如果未安装 `writing-tasks`，提示用户可以使用 `writing-tasks` 创建可追踪、可 review 的执行任务。

这个 hook 只负责提示下一步，不自动创建下游产物。是否继续进入下一层，由用户确认。

## 大型项目的运行规则

- **Current first**：AI 默认读取 current Spec、active Plan 和当前 Task，不默认读取历史归档。
- **Small context cut**：每次只加载与当前任务相关的最小 Spec/Plan/Task 子集。
- **No hidden truth**：不要把新的接口、权限、invariant 或边界藏在 Plan 或 Task 里。
- **No strategy in task logs**：任务日志只记录执行事实；路线变化要更新 Plan。
- **No epic task**：Task 必须能独立执行和验收，不能是大型模糊 epic。
- **Review before done**：Task 完成前必须检查是否需要更新后续 Task、Plan 或 Spec。
- **Archive is not context**：Archive 和历史日志默认不是当前决策输入，除非明确做历史分析。

## 快速选择

| 需求 | Skill |
| --- | --- |
| 定义系统应该是什么 | `writing-spec` |
| 选择如何实现或迁移 | `writing-plan` |
| 创建和追踪可执行工作 | `writing-tasks` |
| Review source-of-truth 漂移 | `writing-spec` |
| Review 策略风险或 rollout 路径 | `writing-plan` |
| Review 任务状态和验收 | `writing-tasks` |
| 让 AI 跨会话恢复项目状态 | `writing-spec` + `writing-plan` + `writing-tasks` |
| 让多个 AI agent 协作而不互相污染上下文 | `writing-spec` + `writing-plan` + `writing-tasks` |

## 安装完整 Spec Coding 组合

```bash
REPO="https://github.com/aiomni/omni-skills"
for skill in writing-spec writing-plan writing-tasks; do
  npx skills add "$REPO" --skill "$skill"
done
```
