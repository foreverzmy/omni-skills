# omni-skills

English | [中文](./README.zh-CN.md)

User-focused skills for three common workflows:

- turning vague engineering work into executable plans and tracked tasks
- adding screenshot capture and screenshot-driven testing to `egui` and `eframe` apps
- maintaining a Snapshot + Patch Spec System as the source of truth for AI Coding projects

Install any skill in this repository with [`skills.sh`](https://skills.sh/).

## Install with `skills.sh`

Install a single skill:

```bash
npx skills add https://github.com/aiomni/omni-skills --skill egui-screenshot
```

Available skill names:

- `writing-plans`
- `egui-screenshot`
- `writing-spec`

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
for skill in writing-plans egui-screenshot writing-spec; do
  npx skills add "$REPO" --skill "$skill"
done
```

## Included Skills

### `writing-plans`

Turn broad engineering goals into plans and task systems that can actually be executed and reviewed.

Best for:

- breaking work into milestones, dependencies, and a visible critical path
- defining acceptance criteria instead of loose TODO lists
- creating task cards, dashboards, inbox capture, execution logs, and review checkpoints
- keeping task files aligned with the real state of implementation

Install:

```bash
npx skills add https://github.com/aiomni/omni-skills --skill writing-plans
```

### `egui-screenshot`

Add, debug, or review screenshot workflows for `egui` and `eframe` applications.

Best for:

- viewport screenshot capture with `ViewportCommand::Screenshot`
- receiving screenshot results from `Event::Screenshot`
- exporting `ColorImage` data to PNG correctly
- adding screenshot-driven tests and visual regression coverage
- exposing screenshots to AI tools or host integrations

Install:

```bash
npx skills add https://github.com/aiomni/omni-skills --skill egui-screenshot
```

### `writing-spec`

Create and maintain a structured Spec System for AI Coding projects.

Best for:

- making `specs/current/` the only valid Spec source of truth
- separating Current State Snapshot, Patch Log, and Archive
- evolving Specs through Patch + Compiler instead of whole-doc rewrites
- keeping LLM context clean by excluding stale `log/` and `archive/` content
- modeling Capability, System, and Contract Spec Objects as a small Spec Graph

Install:

```bash
npx skills add https://github.com/aiomni/omni-skills --skill writing-spec
```

## Which Skill Should You Choose?

- Choose `writing-plans` when the hard part is planning, sequencing, tracking, or reviewing engineering work.
- Choose `egui-screenshot` when the hard part is capturing UI images, saving screenshots, or testing `egui` output.
- Choose `writing-spec` when the hard part is maintaining a unique current Spec truth for AI Coding.
- Install multiple skills when you need delivery management, UI screenshot workflows, and Spec governance together.

## Repository Contents

```text
principles.md
skills/
├── writing-plans/
├── egui-screenshot/
└── writing-spec/
```

`principles.md` is a long-form Chinese reference for programming principles, design patterns, architecture patterns, and concurrency patterns. The `writing-spec` skill keeps smaller Spec-oriented principle references under `skills/writing-spec/references/principles/` for targeted context loading.
