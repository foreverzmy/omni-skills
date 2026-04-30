---
name: egui-screenshot
description: Use when asked to add, debug, or review screenshot or snapshot support for an egui or eframe app, add screenshot-driven tests for egui UI, or expose the current UI as an image to an AI or host tool. Covers ViewportCommand::Screenshot, Event::Screenshot, PNG export, test strategy, and AI-callable screenshot pipelines.
---

# egui screenshot

Use this skill when the task is about capturing what egui rendered.

## First decide the scope

Read only the reference file that matches the task:

- App integration: `references/app-integration.md`
- Test integration: `references/testing.md`
- AI-callable capture: `references/ai-callable.md`

## Non-negotiable rules

- First check the target project's `Cargo.toml` or `Cargo.lock` for its `egui` version. In `egui 0.33.x`, call `ctx.send_viewport_cmd(...)` or `ui.ctx().send_viewport_cmd(...)`; do not assume `ui.send_viewport_cmd(...)`.
- The result comes back as `egui::Event::Screenshot` in a later frame. Do not try to read it from `egui::Response`.
- Decide the return format before coding:
  - `Arc<ColorImage>` for in-process consumers
  - saved PNG path for cross-process or AI consumers
  - base64 only when the caller cannot consume files
- Screenshot is viewport-level. If the user wants a single panel or widget, crop after capture or use a render test harness.
- If you save PNG, convert `Color32` to unmultiplied RGBA with `to_srgba_unmultiplied()`. Do not write premultiplied bytes directly.

## Repository integration

If the target repository already has a host bridge, runtime SDK, generated bindings, or permission system, extend that existing path instead of inventing a second integration layer.

Before coding, identify:

- where native host operations or app commands are registered
- where the top-level `eframe::App` or bridge host can request and collect screenshots
- where generated JavaScript, TypeScript, or SDK bindings are maintained
- which capability or permission gate should cover screenshot reads and file writes

Prefer a dedicated screenshot op or capability over overloading existing `view` or `presentation` APIs.

If you edit generated SDK or host-adapter sources, run the repository's documented generation or build command before finishing.

## Validation

- Rust-only controller or helper change: run targeted `cargo test`
- eframe app integration: run the app or example and confirm one request yields one image
- Bridge or SDK change: run Rust tests that cover the new op path and rebuild `esm/`
- Web path: account for at least one extra frame before expecting a ready result
