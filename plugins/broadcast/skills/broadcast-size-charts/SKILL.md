---
name: broadcast-size-charts
description: Set up size charts and the Fit guide block on a Shopify store running the Broadcast theme by Presidio Creative. Use when a merchant asks for a size guide link next to the size option, different size charts for different products, a fit scale (runs small / true to size / runs large), mentions the custom.size_chart metafield or _size_ tags, or asks why the size chart link is missing. Covers size chart pages, the page-reference metafield, connecting the Variant picker block, the _size_<page-handle> tag alternative, and per-product Fit guide values.
---

# Broadcast size charts and fit guide

Broadcast opens a **size chart** (a Shopify page) from a link beside the Size option in the Variant picker block. One chart can serve every product, or each product can point at its own chart through a metafield. The **Fit guide** block adds a 1–5 scale under the picker.

Live docs (fetch with `broadcast-docs` `getPage`):

- https://broadcast.presidiocreative.com/products/product-pages/size-charts
- https://broadcast.presidiocreative.com/product-theme-blocks/fit-guide

Distilled copy in `references/broadcast-docs.md`.

## How the theme reads it (Broadcast 8.x)

`snippets/product-variant-picker.liquid`: the `variants` block setting `info_page` (type `page`) names the chart. The link only renders when the product has an option whose name matches the `general.size_chart.size` translation ("Size" by default). `size_chart_style` picks the link presentation (text / question icon). The snippet also accepts a product tag `_size_<page-handle>`, which overrides the block setting for that product; this is undocumented but present in 8.1.0.

## Workflow

1. **Create the chart pages** (`pageCreate`; rich text table or an uploaded image). One page per chart, e.g. `size-chart-mens`, `size-chart-womens`. `scripts/page-create.graphql` has a table template.
2. **One chart for everything?** Set `info_page` on the `variants` block to the page handle in `templates/product.json` and stop. Multiple product templates can each carry a different chart.
3. **Per-product charts**: create the definition once with `scripts/metafield-definitions.graphql` (`custom.size_chart`, type `page_reference`; the docs use the `custom` namespace here). Set each product's value with `scripts/set-size-chart.graphql` (value is the page gid). Then connect the block: `scripts/connect_metafield.py templates/product.json --block variants --setting info_page --metafield custom.size_chart`. In the editor: Variant picker → dynamic source → Size Chart.
4. **Option name must be "Size"** (or the translated equivalent). For "Shoe size" or "US Size", either rename the option or change the `general.size_chart.size` string under *Edit default theme content*; the match is exact.
5. **Fit guide** (optional): add a `fit-guide` block; `segment_selected` is 1–5. For per-product fit, create a product metafield (e.g. `custom.fit_segment`, single line text, values 1–5) and connect it: `scripts/connect_metafield.py templates/product.json --block fit-guide --setting segment_selected --metafield custom.fit_segment --value`. Labels default to Small / True to size / Large.
6. **Verify** on a preview theme: `scripts/verify_size_chart.sh <store> <handle> [preview_theme_id]` checks for the size chart trigger and the fit guide markup. The docs note the editor sometimes needs closing and reopening before the link appears.

## Pitfalls

- No "Size" option, no link. This is the usual cause.
- The metafield type must be **page reference** (one page), not text.
- Products without a metafield value show nothing unless the block also has a static `info_page` fallback; when the block is connected to the metafield there is no fallback, so decide which behaviour the merchant wants.
- Size chart pages inherit the default `page` template; a bare table with no padding looks unfinished inside Broadcast's modal. Keep the page content to the table or image.
