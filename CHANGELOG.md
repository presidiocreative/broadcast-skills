# Changelog

## 0.2.0 — 2026-09-11

Five new skills, verified against Broadcast 8.1.0:

- `broadcast-upsells`: `theme.upsell` / `theme.upsell_list` metafields, Upsell block and cart drawer block, legacy `_upsell_` tags (3.0–3.3 only).
- `broadcast-bundles`: automatic discount + `theme.bundle` / `theme.bundle_list` / `custom.bundle_title`, Bundle and save block, cart drawer Bundle products block.
- `broadcast-badges-cutlines`: `_badge_` tag, `theme.badge`, `theme.cutline`, `theme.final_sale`, badge theme settings.
- `broadcast-size-charts`: size chart pages, `custom.size_chart` page reference, Variant picker connection, `_size_<handle>` tag, Fit guide per-product segment.
- `broadcast-swatches`: Shopify native `shopify--color-pattern` swatches vs the theme `swatch_color_list`, collection swatch styles and performance, grey-swatch audit.
- Shared `connect_metafield.py` for wiring block settings to metafields as dynamic sources (resource settings without `.value`, text settings with `.value`).

## 0.1.0 — 2026-09-11

- Initial release.
- `broadcast-preorder`: set up Broadcast's native pre-order (tag, product metafield, variant metafield), badge setting, `product.preorder` template, inventory and payment caveats, Broadcast 8.1.0 quick-add and cart-bar fixes, verification script.
- `broadcast-siblings`: metafield definitions, one-product-per-color setup, grouping collection, Siblings block dynamic-source wiring, image swatches, verification script.
- Bundles the `broadcast-docs` MCP server (GitBook) so skills can read the live documentation.
