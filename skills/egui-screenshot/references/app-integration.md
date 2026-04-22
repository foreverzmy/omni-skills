# App integration

Use this path when the app itself needs a screenshot button, hotkey, menu item, internal API, or saved PNG.

## Recommended shape

- Add a small screenshot controller to the top-level `eframe::App` state.
- In `update`, first collect ready screenshot events from `ctx.input(...)`.
- Trigger new captures by calling `ctx.send_viewport_cmd(egui::ViewportCommand::Screenshot(...))`.
- Keep the screenshot controller independent from widget layout code.

## Minimal controller

```rust
use std::sync::Arc;

use eframe::egui::{self, ColorImage};

#[derive(Default)]
pub struct ScreenshotController {
    next_request_id: u64,
    pub latest: Option<(u64, Arc<ColorImage>)>,
}

impl ScreenshotController {
    pub fn request(&mut self, ctx: &egui::Context) -> u64 {
        let request_id = self.next_request_id;
        self.next_request_id += 1;

        ctx.send_viewport_cmd(egui::ViewportCommand::Screenshot(
            egui::UserData::new(request_id),
        ));

        request_id
    }

    pub fn collect(&mut self, ctx: &egui::Context) {
        let ready: Vec<(u64, Arc<ColorImage>)> = ctx.input(|i| {
            i.events
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
        });

        for shot in ready {
            self.latest = Some(shot);
        }
    }
}
```

Use it from the app loop:

```rust
fn update(&mut self, ctx: &egui::Context, _frame: &mut eframe::Frame) {
    self.screenshots.collect(ctx);

    egui::CentralPanel::default().show(ctx, |ui| {
        if ui.button("Capture").clicked() {
            self.screenshots.request(ctx);
        }

        if let Some((request_id, image)) = &self.screenshots.latest {
            ui.label(format!(
                "last screenshot #{request_id}: {}x{}",
                image.size[0],
                image.size[1]
            ));
        }
    });
}
```

## Saving PNG

If the caller needs a file, prefer a PNG on disk over raw RGBA in a JSON payload.

Add a PNG writer dependency only when needed:

```toml
image = { version = "0.25", default-features = false, features = ["png"] }
```

Then convert `ColorImage` to unmultiplied RGBA:

```rust
pub fn save_color_image_png(
    image: &egui::ColorImage,
    path: &std::path::Path,
) -> Result<(), image::ImageError> {
    let rgba: Vec<u8> = image
        .pixels
        .iter()
        .flat_map(|pixel| pixel.to_srgba_unmultiplied())
        .collect();

    let png = image::RgbaImage::from_raw(
        image.size[0] as u32,
        image.size[1] as u32,
        rgba,
    )
    .expect("ColorImage dimensions must match the RGBA buffer");

    png.save(path)
}
```

Do not use `to_array()` for PNG export unless you explicitly want premultiplied bytes.

## Common mistakes

- Requesting and consuming in the same frame, then assuming the image is missing
- Storing screenshot logic inside a leaf widget instead of app state
- Matching only one hard-coded request and dropping the rest
- Saving the full viewport when the user really asked for one panel

## Widget-only capture

`ViewportCommand::Screenshot` captures the whole viewport. If you only need one panel or widget:

- store the target `egui::Rect`
- capture the viewport
- crop the resulting image using the same pixels-per-point used for rendering

Only add cropping code if the user actually asked for a sub-rect screenshot.
