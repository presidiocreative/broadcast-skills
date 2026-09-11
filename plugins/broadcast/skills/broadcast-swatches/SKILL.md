---
name: broadcast-swatches
description: Set up variant color swatches on a Shopify store running the Broadcast theme by Presidio Creative, for product pages and collection grids. Use when a merchant asks for color swatches, swatch images or textures, swatches showing grey or wrong colors, swatch shape and size, how many swatches show on product cards, or the difference between theme swatches and Shopify native swatches (Broadcast 8.0+ category metafields). Covers the Swatches theme settings, the HEX/file swatch list, Shopify's color-pattern category metafield, collection swatch styles and their performance cost.
---

# Broadcast variant swatches

Broadcast renders variant option values (usually Color) as swatches on the product page and on product cards. Where the color comes from depends on the theme version and the merchant's setup, and picking the wrong path is the main source of "my swatches are grey" tickets.

Live docs (fetch with `broadcast-docs` `getPage`):

- https://broadcast.presidiocreative.com/products/product-pages/swatches-new (8.0+, Shopify native)
- https://broadcast.presidiocreative.com/theme-settings/theme-settings/swatches
- https://broadcast.presidiocreative.com/collections/collection-pages/swatch-collection-styles

Distilled copy in `references/broadcast-docs.md`. Product **siblings** (one product per color) are a different feature: use the `broadcast-siblings` skill.

## Two sources of color

1. **Shopify native swatches (8.0+, preferred).** The product's Color option is linked to Shopify's `shopify--color-pattern` category metaobject. Each entry has a label, a hex color and/or an image. `snippets/swatch-input.liquid` reads `value.swatch.color` / `value.swatch.image`, so once the option is linked, swatches, filters and the grid all work with no theme configuration, and renaming "Black" to "Graphite" updates everywhere. Set it up in Admin → Products → option → *Link to category metafield*, or via `productOptionUpdate` with `linkedMetafield: { namespace: "shopify", key: "color-pattern" }`; the entry values live in `metaobjects(type: "shopify--color-pattern")` and can be created with `metaobjectCreate`. Confirm field names with `graphql_schema` before writing; the taxonomy definitions are Shopify-managed.
2. **Theme swatch list (all versions, fallback).** Theme settings → Swatches → *HEX codes and files* (`swatch_color_list`, one rule per line, `Name: #hex` or `Name: file.png` where the file is in Content → Files). `snippets/swatch-color-list.liquid` turns each into a CSS variable named after the handleised value, and any option value or sibling color with a matching handle picks it up. Names must match the variant value exactly after handleising ("Storm Grey" → `storm-grey`).

If a variant option has no swatch source at all, Broadcast 8.x falls back to plain text buttons for that option (verified on 8.1.0); a value that maps to a theme-list variable with no definition renders as a grey chip. `scripts/audit_swatch_values.py` lists every color value on the store and flags the ones with no mapping.

## Settings that matter

| Setting (`config/settings_data.json` → `current`) | Purpose |
| --- | --- |
| `enable_swatches` | master switch (older builds); newer 8.x builds expose *Swatches type*: Theme / Native / None |
| `swatch_style` circle/square, `swatch_size` regular/large | shape and size everywhere |
| `variant_on_sale` | red dot on swatches of on-sale variants |
| `collection_swatch_style` text / slider / text-slider / limited / grid | how many swatches load on product cards. `text` is fastest, `limited` (swatches with text) loads five, `slider` and `grid` load all and slow large collections |
| `sibling_style` swatch/image | siblings only |
| Product grid → `show_grid_swatches` | swatches on cards at all |

Swatches for options other than Color: rename the option label in the language file so the theme treats it as a swatch option.

## Workflow

1. Check the theme version and whether `snippets/swatch-input.liquid` uses `value.swatch` (native support present).
2. Run `scripts/audit_swatch_values.py` (needs Admin API read access) or query `products { options { name optionValues { name swatch { color image { url } } linkedMetafieldValue } } }` to see which values already resolve.
3. Prefer linking the Color option to `shopify--color-pattern` for every product; fall back to `swatch_color_list` entries for one-off values or textures, uploading swatch images to Files first.
4. Set `collection_swatch_style` with the catalogue size in mind; suggest `limited` or `text` above roughly 24 products per page.
5. Verify on a preview theme: `scripts/verify_swatches.sh <store> <handle> [preview_theme_id]` prints each swatch's resolved `--swatch` value; `var(--x)` with no matching list entry means grey, and zero swatches with several `radio__button` hits means the option fell back to text buttons because nothing supplies a color.
