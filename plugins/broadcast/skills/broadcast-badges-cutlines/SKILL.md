---
name: broadcast-badges-cutlines
description: Set up product badges (stickers), cutline second-line text, and Final Sale messaging on a Shopify store running the Broadcast theme by Presidio Creative. Use when a merchant asks for "New", "Best seller", "Limited" or custom badges on product cards, a tagline under product titles in the grid, a final-sale notice on some or all sale items, or asks why a badge or cutline is not showing. Covers the _badge_ tag, theme.badge, theme.cutline and theme.final_sale metafields, Theme settings → Badges colors, and the product page Badges block.
---

# Broadcast badges, cutlines and Final Sale

Three small merchandising features that share the same pattern: a product metafield (or tag) plus a theme setting that must be switched on.

Live docs (fetch with `broadcast-docs` `getPage`):

- https://broadcast.presidiocreative.com/collections/collection-pages/product-badges (tag)
- https://broadcast.presidiocreative.com/collections/collection-pages/product-badges-with-metafields (metafield, Broadcast 3.2+)
- https://broadcast.presidiocreative.com/collections/collection-pages/cutline (Broadcast 3.2+)
- https://broadcast.presidiocreative.com/products/product-pages/final-sale
- https://broadcast.presidiocreative.com/theme-settings/theme-settings/badges

Distilled copy in `references/broadcast-docs.md`.

## Reference

| Feature | Data | Theme setting that must be on | Where it shows |
| --- | --- | --- | --- |
| Custom badge | tag `_badge_<text>` (underscores become spaces, e.g. `_badge_Black_Friday`) **or** metafield `theme.badge` (single line text). Metafield wins if both. | `show_custom_badge`; colors `badge_bg_color`, `badge_text_color`; position `badge_alignment`, size `badge_font_size` | Every product grid (collections, search, recommendations); product page if the **Badges** block has `product_badges` on |
| Cutline | metafield `theme.cutline` (single line text) | `show_cutline` (Product grid), `cutline_color` | Second line under the title in product grids; also used for siblings |
| Final sale | global `final_sale` (Product form) for **all** sale items, or metafield `theme.final_sale` (boolean) per product with the global off | `final_sale_tooltip` rich text is the hover detail | Product page price and product grid price |

Built-in badges (Sale / saving, Sold out, New, Pre-order) are theme settings only and need no data; New is automatic from `badge_new_date_limit` days since creation. Pre-order is covered by the `broadcast-preorder` skill.

## Workflow

1. **Definitions once**: `scripts/metafield-definitions.graphql` + `.variables.json` creates `theme.badge`, `theme.cutline` and `theme.final_sale`. Skip any the merchant will not use. Namespace `theme`, not `custom`.
2. **Settings**: in `config/settings_data.json` `current` set `show_custom_badge: true`, `show_cutline: true` as needed, badge colors, and decide `final_sale` (global) vs per product. Keep `show_automatic_new_badge` in mind: after a bulk product import every product is "new".
3. **Data**: tags via `tagsAdd`; metafields via `scripts/set-labels.graphql`. Badge text is rendered verbatim, so match the store's casing.
4. **Product page badges**: the `badges` block in the product template has `product_badges` (shows custom, pre-order and tag badges), `sale_badge`, and three static `custom_badge_N` text fields that apply to every product using that template. Use the static fields only for template-wide labels.
5. **Verify** on a preview theme: `scripts/verify_labels.sh <store> <collection-handle> [preview_theme_id]` counts `custom-box` badges, cutlines and final-sale markers in the grid.

## Pitfalls

- A `_badge_` tag with a space works but is easy to duplicate ("Best Seller" vs "Best seller"); prefer the metafield for consistency.
- Only one custom badge renders per card; Sold out overrides it, and Pre-order takes priority over New.
- Cutline needs both the metafield **and** `show_cutline`; the metafield alone does nothing.
- Final sale global toggle on plus per-product metafields means every sale item shows it; turn the global off for per-product control.
- Badge colors can be bound to Shopify brand colors via dynamic source in the editor; in JSON that is a `shopify://` brand reference and rarely worth scripting.
