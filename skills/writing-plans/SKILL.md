---
name: writing-plans
description: Use when asked to write, break down, or execute engineering plans, create implementation plans, define milestones, dependencies, critical paths, acceptance criteria, task cards, dashboards, execution logs, reviews, or inbox capture, or turn a vague engineering goal into an executable plan system. Also use when updating existing plan or task files, syncing real progress, or deciding whether follow-up work should become a tracked task, even if the user does not explicitly ask to create a tasks directory.
---

# Writing Plans

把模糊的研发目标收敛成可执行任务，并在执行过程中持续回写。重点不是“列 TODO”，而是把下面四件事始终写清楚：
- 为什么现在做。
- 做到什么算完成。
- 依赖什么。
- 完成后解锁什么。

如果仓库已经有自己的任务系统，先遵循现有约定，再决定是否迁移到这套模板。不要直接覆盖用户已有结构。

## Language Policy

- If the user's request is in English, respond in English and write specs, plans, task cards, reviews, and other generated artifacts in English.
- If the user's request is in Chinese or another language, respond in that same language and write specs, plans, task cards, reviews, and other generated artifacts in that language.
- If the user explicitly requests a language, or the surrounding context specifies a language, use that language instead of inferring the language from the request.

## 什么时候用

在以下场景使用：
- 用户要求拆解复杂研发工作、建立实施计划或关键路径。
- 用户要求创建或维护任务卡、dashboard、milestone、project page。
- 用户要求给某个需求补依赖、优先级、验收标准、执行日志或 Review。
- 需要把实际代码进展回写为可追踪任务，而不是停留在聊天记录里。
- 需要判断某个 follow-up 是正式拆卡，还是先记到 inbox。

如果只是一次单文件、小范围、无依赖的简单改动，不要机械创建整套任务目录；只应用本 skill 的拆解、验收和同步原则即可。

## 资源结构

这个 skill 自带一套可直接拷贝的模板，位于：
- `assets/templates/tasks/README.md`
- `assets/templates/tasks/index.md`
- `assets/templates/tasks/inbox.md`
- `assets/templates/tasks/projects/project.md`
- `assets/templates/tasks/templates/task.md`

这些模板是经过验证的成熟结构，适合在项目中直接落地后再按实际项目改写。

## 默认工作流

### 1. 先定范围，不要急着建卡

先回答：
1. 这是项目级、里程碑级，还是单任务级问题？
2. 最终验收锚点是什么？
3. 当前 repo 是缺少任务系统，还是已有系统但内容失真？
4. 这项工作是否值得持久化到文件，而不是只在聊天里回答？

如果用户要的是一次性建议，不需要持久化，给出短计划即可。

### 2. 需要持久化时，先建立最小任务系统

当工作满足以下任一条件时，建议落地任务系统：
- 横跨多个步骤或多个文件。
- 存在明确依赖链、关键路径或里程碑。
- 需要后续多次同步进展。
- 有多人协作或后续 handoff 风险。

优先建立以下结构：
- `tasks/README.md`
- `tasks/index.md`
- `tasks/inbox.md`
- `tasks/projects/<project>.md`
- `tasks/templates/task.md`
- `tasks/tasks/task-xxx.md`

使用模板时不要保留占位符。拷贝后立刻替换项目名、验收目标、状态、日期和依赖。

### 3. 任务设计规则

每张任务卡必须回答：
- 为什么现在做。
- 做到什么算完成。
- 依赖什么任务。
- 完成后解锁什么任务。

任务卡正文至少包含：
- `背景`
- `目标`
- `执行步骤`
- `验收标准`
- `执行中发现与动态调整`
- `执行日志`
- `Review`
- `备注`

写法要求：
- `目标` 只写结果，不写过程。
- `执行步骤` 必须可观察、可勾选、可验收。
- `验收标准` 必须分成 `步骤验收标准` 和 `任务完成验收标准`。
- 依赖只写硬依赖，阻塞只写完成后会直接解锁的下游项。

不要写这类无效步骤：
- 研究一下
- 看看能不能做
- 优化整体架构
- 处理一些边界情况

把它们改成有输出的动作，例如：
- 定义 API 数据结构与校验规则
- 补一个最小复现测试并让它通过
- 把旧入口迁移到新 SDK 并删除 raw 调用

### 4. 执行中的同步规则

实施过程中，至少同步三类信息：

1. `执行日志`
   记录事实：做了什么、发现了什么、做了什么决策、下一步是什么。

2. `执行中发现与动态调整`
   只要发现失效假设、隐藏风险、更优方案、返工风险或依赖链变化，就必须写进去。

3. `dashboard / project page`
   只要状态、关键路径、里程碑或最终验收口径变化，就必须同步。

不要让聊天记录成为唯一事实源。

### 5. Review 和 done 判定

任务只能在以下条件同时满足时标记为 `done`：
- 执行步骤完成，或未完成步骤已明确证明不再需要。
- `步骤验收标准` 已满足。
- `任务完成验收标准` 已满足。
- 关键偏差、新方案和风险已写入 `执行中发现与动态调整`。
- `Review` 已完成。
- `index.md` 已同步。
- 如有需要，项目页和受影响任务卡也已同步。
- 没有遗留会立即阻断下游任务的关键缺口。

`Review` 至少回答：
- 当前任务是否真的允许标记为 `done`。
- 后续任务、依赖、优先级、验收是否需要调整。
- 如果需要调整，具体改了什么、为什么改。
- 如果不需要，也要明确写“无需调整”。

## 状态和优先级

推荐状态：
- `todo`
- `doing`
- `done`
- `blocked`

推荐优先级：
- `P0`
- `P1`
- `P2`

默认语义：
- `todo`：已定义但未开始。
- `doing`：已开始实质推进，应出现在 dashboard 的 `Doing`。
- `blocked`：因外部依赖或前置任务无法继续。
- `done`：已满足全部验收和同步要求。

如果目标项目已经有自己的状态机，沿用原系统，但保留本 skill 的验收与同步原则。

## 何时拆卡，何时放 Inbox

需要正式拆卡：
- 有独立目标、独立验收标准、独立依赖链。
- 当前任务太大，无法在单一稳定目标下推进。
- 某风险已经升级为需要正式跟踪的工作项。

先放 `inbox`：
- 只是临时风险、想法或疑问。
- 归属还不清楚。
- 还不能判断是否值得正式拆卡。

不需要拆卡：
- 只是当前任务里的一个子步骤。
- 只是一次局部修正，不会形成新的依赖链。
- 只是日志级别的信息更新。

## 创建新任务系统时怎么用模板

如果目标 repo 还没有任务系统，按这个顺序使用模板：
1. 复制 `assets/templates/tasks/README.md` 到目标 repo 的 `tasks/README.md`
2. 复制 `assets/templates/tasks/index.md` 到 `tasks/index.md`
3. 复制 `assets/templates/tasks/inbox.md` 到 `tasks/inbox.md`
4. 复制 `assets/templates/tasks/projects/project.md` 到 `tasks/projects/<project>.md`
5. 复制 `assets/templates/tasks/templates/task.md` 到 `tasks/templates/task.md`
6. 再基于任务模板创建实际的 `tasks/tasks/task-xxx.md`

不要一次性生成大量空任务。先围绕关键路径建最小闭环，再扩展。

## 完成后的输出

完成一次任务系统相关操作后，输出时至少说明：
- 改了哪些任务文件。
- 状态是否变化。
- 依赖、关键路径或验收口径是否变化。
- 是否同步了 `index.md`、项目页或 `inbox.md`。

如果你没有把这些同步动作做完，就不要把工作描述成“已经完成”。
