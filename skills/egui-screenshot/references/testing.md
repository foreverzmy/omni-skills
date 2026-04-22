# Testing

Use this path when the task is about verifying screenshot behavior or adding visual regression tests.

## Pick the test level first

- Controller test: fastest and most stable. Test how your code reacts to `Event::Screenshot`.
- Visual regression test: use a render harness and compare pixels.
- End-to-end app test: only when you need to test the real backend screenshot path.

## Controller tests

Keep the extraction logic separate from `ctx.input(...)` so it can be unit-tested from a plain `&[egui::Event]`.

```rust
use std::sync::Arc;

use eframe::egui::{self, ColorImage};

fn collect_screenshot_events(
    events: &[egui::Event],
) -> Vec<(u64, Arc<ColorImage>)> {
    events
        .iter()
        .filter_map(|event| {
            let egui::Event::Screenshot { user_data, image, .. } = event else {
                return None;
            };

            let request_id = user_data
                .data
                .as_ref()
                .and_then(|value| value.as_ref().downcast_ref::<u64>())
                .copied()?;

            Some((request_id, Arc::clone(image)))
        })
        .collect()
}

#[test]
fn extracts_screenshot_events() {
    let image = Arc::new(egui::ColorImage::filled(
        [2, 2],
        egui::Color32::WHITE,
    ));
    let events = vec![egui::Event::Screenshot {
        viewport_id: egui::ViewportId::ROOT,
        user_data: egui::UserData::new(7_u64),
        image: Arc::clone(&image),
    }];

    let ready = collect_screenshot_events(&events);

    assert_eq!(ready.len(), 1);
    assert_eq!(ready[0].0, 7);
    assert_eq!(ready[0].1.size, [2, 2]);
}
```

This is the right test when the feature is "did we capture and route the image correctly?"

## Visual regression tests

If the feature is "does the UI look right?", use a render harness instead of the runtime screenshot event flow.

`egui_kittest` is the usual choice for egui visual testing. Keep the version-specific API behind one small helper and snapshot the resulting image. The crate exposes image snapshot helpers such as `egui_kittest::image_snapshot(...)`, and stores baselines under `tests/snapshots/`.

Suggested shape:

```rust
#[test]
fn toolbar_matches_snapshot() {
    let image = render_test_ui_to_rgba_image(|ui| {
        // draw deterministic UI here
    });

    egui_kittest::image_snapshot(&image, "toolbar");
}
```

Keep the helper thin. Across egui releases, the harness entrypoints can move more than the PNG comparison helper.

## End-to-end screenshot tests

Use a real app test only when you must verify the backend integration itself:

- fixed window size
- fixed theme and fonts
- no animations
- no wall-clock timestamps
- deterministic data and network stubs
- one extra frame on web before polling for the result

Assert metadata first:

- file exists
- width and height match
- request id is correlated correctly

Only add byte-for-byte image comparison when the backend and font stack are deterministic enough for it.
