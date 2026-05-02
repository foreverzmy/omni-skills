# omni-skills

English | [中文](./README.zh-CN.md)

User-focused skills for reusable AI/Codex workflows.

## Skill Groups

### Spec Coding

Spec Coding is the workflow for using AI agents to continuously develop large projects by separating source of truth, feature discovery, implementation strategy, and executable work:

```text
writing-spec  ->  writing-plan  ->  writing-tasks
Spec              Plan              Task
```

Use it when a project is too large to rely on chat history alone, and AI needs recoverable context, stable truth, draft-based feature discovery, strategy-level planning, and task-level execution state.

See [`SPEC-CODING.md`](./SPEC-CODING.md) for the dedicated Spec Coding guide, including the `writing-spec`, `writing-plan`, and `writing-tasks` skills.

### `egui-screenshot`

Add, debug, or review screenshot workflows for `egui` and `eframe` applications.

Best for:

- viewport screenshot capture with `ViewportCommand::Screenshot`
- receiving screenshot results from `Event::Screenshot`
- exporting `ColorImage` data to PNG correctly
- adding screenshot-driven tests and visual regression coverage
- exposing screenshots to AI tools or host integrations

## Install with `skills.sh`

Install a single skill:

```bash
npx skills add https://github.com/aiomni/omni-skills --skill egui-screenshot
```

Available skill names:

- `writing-spec`
- `writing-plan`
- `writing-tasks`
- `egui-screenshot`

> [!NOTE]
> You need `npx` in your shell to run the installation commands.

## Quick Install

If you cloned this repository, install every skill with:

```bash
bash scripts/install-skills.sh
```

If you prefer a one-liner instead of the script:

```bash
REPO="https://github.com/aiomni/omni-skills"
for skill in writing-plan writing-tasks egui-screenshot writing-spec; do
  npx skills add "$REPO" --skill "$skill"
done
```

## Quick Index

| Need | Skill |
| --- | --- |
| Draft and maintain AI Coding source of truth | `writing-spec` |
| Define implementation strategy and orchestration | `writing-plan` |
| Create tracked, reviewable execution units | `writing-tasks` |
| Add screenshot workflows for `egui` / `eframe` | `egui-screenshot` |

## Repository Contents

```text
SPEC-CODING.md
principles.md
skills/
├── writing-spec/
├── writing-plan/
├── writing-tasks/
└── egui-screenshot/
```

`principles.md` is a long-form Chinese reference for programming principles, design patterns, architecture patterns, and concurrency patterns. The `writing-spec` skill keeps smaller Spec-oriented principle references under `skills/writing-spec/references/principles/` for targeted context loading.
