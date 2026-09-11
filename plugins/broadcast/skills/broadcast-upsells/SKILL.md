---
name: broadcast-upsells
description: Set up product upsells ("Goes with", "Complete the look", cross-sells) on a Shopify store running the Broadcast theme by Presidio Creative. Use when a merchant asks to recommend or pair products on the product page or in the cart drawer, mentions upsell blocks, theme.upsell or theme.upsell_list metafields, or asks why an upsell is not showing. Covers metafield definitions, per-product pairing, connecting the Upsell block, the cart drawer Upsell products block, and the legacy _upsell_ tag method for Broadcast 3.0–3.3.
---

# Broadcast upsells

Broadcast shows a paired product (or up to three) in an **Upsell** block on the product page, and again in the cart drawer after the main product is added. Pairings are per product and come from two product metafields, so one product template serves the whole catalogue.

Live docs (fetch with the `broadcast-docs` MCP `getPage` tool):

- https://broadcast.presidiocreative.com/promotions/upselling/upselling (metafields, current method)
- https://broadcast.presidiocreative.com/promotions/upselling/upselling-with-tags (Broadcast 3.0–3.3.1 only; tags are **not supported from 3.4**)

Distilled copy in `references/broadcast-docs.md`.

## How the theme reads it (Broadcast 8.x)

- Product page: `snippets/product.liquid` reads `product.metafields.theme.upsell.value` (single product) and `product.metafields.theme.upsell_list.value` (list of products) when rendering the `upsell` block. The block also has `upsell_product` / `upsell_product_list` settings that the docs say to connect to the metafields as dynamic sources; do both so behaviour matches the editor.
- Cart drawer: `snippets/cart-line-items.liquid` reads the same two metafields on each line item's product; the **Upsell products** block in the Cart drawer section must be present for it to render.
- The heading comes from `products.product.upsell_title` ("Complete the look") in the locale file; merchants change it under *Edit default theme content*.

## Workflow

1. **Confirm the version.** `grep -n "theme.upsell" snippets/product.liquid`. If absent and the theme is 3.0–3.3, use the tag method in the docs (`_upsell_<handle>` or `_upsell_<handle>_<variantId>`); otherwise use metafields.
2. **Create the definitions once**: run `scripts/metafield-definitions.graphql` with `scripts/metafield-definitions.variables.json`. `theme.upsell_list` is `list.product_reference` (up to 3 used), `theme.upsell` is `product_reference`. Create the list one at minimum. Pin them.
3. **Pair products**: `metafieldsSet` with `scripts/set-upsells.graphql`. The value for a list is a JSON array string of product gids: `"[\"gid://shopify/Product/1\",\"gid://shopify/Product/2\"]"`. Only active, published products render; the block setting *Show available upsell only* hides sold-out pairings.
4. **Add and connect the block**: the product template needs an `upsell` block in the product section. Run `scripts/connect_metafield.py templates/product.json --block upsell --setting upsell_product_list --metafield theme.upsell_list` (and the same for `upsell_product` → `theme.upsell` if single pairings are used). In the editor this is the dynamic-source icon on the block setting; the source must be **Template → Product**, not the block's own product picker.
5. **Cart drawer**: make sure `sections/group-overlay.json` (or the cart drawer section) has an `upsell-products` block. `upsell_auto_open` opens the drawer promotion automatically.
6. **Verify** on a preview theme: `scripts/verify_upsells.sh <store> <handle> [preview_theme_id]` checks that the product page renders the upsell product handles, then add to cart and confirm the drawer shows the promotion.

## Pitfalls

- Namespace must be `theme`, not the default `custom`; the key names are exact.
- A paired product that is draft, archived, or not published to the Online Store silently disappears.
- Upsells and bundles use the same block layout; do not put the same product in both `theme.upsell_list` and `theme.bundle_list`, the promotion will show twice.
- Tags are ignored from 3.4 onward; if a store migrated from v3 with `_upsell_` tags, convert them to metafields.
