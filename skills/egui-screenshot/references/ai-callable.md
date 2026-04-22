# AI-callable capture

Use this path when a host tool, assistant, or AI workflow needs to request a screenshot and receive an image back.

## Default recommendation

Return a saved PNG path, not raw RGBA bytes.

That is the best default when:

- the bridge currently speaks JSON or strings
- the consumer is another process
- the consumer is an AI toolchain that can ingest files
- you want to avoid large base64 payloads

Use base64 only when the caller cannot read files.

## Do not make this synchronous

`ViewportCommand::Screenshot` produces its result in a later frame. A single blocking op is the wrong shape.

Use a split-phase API:

1. request capture
2. pump the next frame
3. poll or receive a ready result

## Suggested contract

Request:

```json
{
  "instanceId": "instance-weather",
  "format": "png"
}
```

Pending result:

```json
{
  "status": "pending",
  "requestId": "shot-42"
}
```

Ready result:

```json
{
  "status": "ready",
  "requestId": "shot-42",
  "path": "/absolute/path/to/shot-42.png",
  "width": 1280,
  "height": 800,
  "mimeType": "image/png"
}
```

## Repository-specific integration path

In this repository, follow the existing host op pattern.

Rust side:

- Add a screenshot controller or service next to the top-level app or bridge host.
- Request captures from `eframe::App::update`.
- Collect `Event::Screenshot` in the same app loop.
- Persist the image to a file when it becomes ready.
- Expose two ops such as `op_host_screenshot_request` and `op_host_screenshot_poll`.
- Register them in `crates/ruact-deno/ops.rs` and `crates/ruact-deno/lib.rs`.

JS runtime side:

- Wire the new ops in `esm/ruact_init.js`.
- Add a typed surface in `js/runtime-sdk/contracts.ts` and `js/runtime-sdk/bridge-types.ts`.
- Expose a small wrapper in `js/runtime-sdk/api.ts`, for example `runtime.ui.screenshot()`.

Keep the app-facing API simple:

```ts
const request = await runtime.ui.screenshot.request();

for (;;) {
  const result = await runtime.ui.screenshot.poll(request.requestId);
  if (result.status === "ready") {
    return result.path;
  }
  await new Promise((resolve) => setTimeout(resolve, 16));
}
```

The exact wrapper names can vary. The important part is that request and poll are separate.

## Capability and permission notes

If widget JavaScript can trigger screenshots, treat that as a sensitive read of rendered UI.

In this repository, the least invasive choice is usually one of:

- gate it behind the existing `ui` capability when the image stays inside the app workflow
- gate it behind `ui` plus `storage` when the host writes a PNG to disk
- add a dedicated capability only if product requirements need separate prompting or audit

Do not hide screenshot capture behind an unrelated permission.

## Common mistakes

- returning raw RGBA through a string-only op
- trying to block until the screenshot arrives in the same call
- putting screenshot transport inside `view` requests because it "sounds related"
- returning a relative path that the caller cannot resolve
- forgetting to rebuild `esm/` after changing `js/runtime-sdk/*`
