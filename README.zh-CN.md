# omni-skills

[English](README.md) | 中文

这是一个面向用户的 skills 仓库，用于沉淀可复用的 AI/Codex 工作流。

## Skill 分组

### Spec Coding

Spec Coding 是面向纯 AI 持续开发大型项目的工作流，把 source of truth、新功能调研、实施策略和执行单元分层管理：

```text
writing-spec  ->  writing-plan  ->  writing-tasks
Spec              Plan              Task
```

当项目大到不能依赖聊天记录推进，而 AI 需要可恢复上下文、稳定真相、Draft 化的新功能调研、策略层规划和任务层执行状态时，使用这一组 skills。

详见独立文档 [`SPEC-CODING.md`](./SPEC-CODING.md)，其中说明了 `writing-spec`、`writing-plan` 和 `writing-tasks` 的职责边界与使用顺序。

### `egui-screenshot`

为 `egui` / `eframe` 应用添加、排查或评审截图工作流。

适合这些场景：

- 用 `ViewportCommand::Screenshot` 触发视口截图
- 从 `Event::Screenshot` 获取异步返回的截图结果
- 正确把 `ColorImage` 导出成 PNG
- 增加截图驱动测试或视觉回归测试
- 把截图能力暴露给 AI 工具或宿主桥接层

## 使用 `skills.sh` 安装

安装单个 skill：

```bash
npx skills add https://github.com/aiomni/omni-skills --skill egui-screenshot
```

本仓库当前提供的 skill 名称：

- `writing-spec`
- `writing-plan`
- `writing-tasks`
- `egui-screenshot`

> [!NOTE]
> 运行安装命令前，请确保你的环境中可以使用 `npx`。

## 快速安装

如果你已经克隆了这个仓库，可以用下面的脚本一次安装全部 skills：

```bash
bash scripts/install-skills.sh
```

如果你更喜欢直接运行一段命令，而不是使用脚本：

```bash
REPO="https://github.com/aiomni/omni-skills"
for skill in writing-plan writing-tasks egui-screenshot writing-spec; do
  npx skills add "$REPO" --skill "$skill"
done
```

## 快速索引

| 需求 | Skill |
| --- | --- |
| Draft 并维护 AI Coding source of truth | `writing-spec` |
| 定义实施策略和 orchestration | `writing-plan` |
| 创建可追踪、可 review 的执行单元 | `writing-tasks` |
| 为 `egui` / `eframe` 增加截图工作流 | `egui-screenshot` |

## 仓库内容

```text
SPEC-CODING.md
principles.md
skills/
├── writing-spec/
├── writing-plan/
├── writing-tasks/
└── egui-screenshot/
```

`principles.md` 是一份中文长文参考，覆盖程序设计原则、设计模式、架构模式和并发模式。`writing-spec` skill 仍然把面向 Spec 边界判断的小型原则文件放在 `skills/writing-spec/references/principles/`，方便按需加载。
