---
name: broadcast-bundles
description: Set up "Bundle and Save" promotions on a Shopify store running the Broadcast theme by Presidio Creative (Broadcast 7.1+). Use when a merchant wants to promote a discounted bundle on the product page or cart drawer, mentions theme.bundle, theme.bundle_list or custom.bundle_title metafields, automatic bundle discounts, or asks why the bundle promotion or savings are not showing. Covers the automatic discount, metafield definitions, per-product pairing, connecting the Bundle and save block, and the cart drawer Bundle products block.
---

# Broadcast Bundle and Save

A **Bundle and save** block on the product page offers one to three companion products; adding them applies a Shopify **automatic discount** and the cart shows the savings. Introduced in Broadcast 7.1. The theme does no pricing itself: the discount lives in Shopify, the theme only promotes the pairing, so the two must describe the same products.

Live doc: https://broadcast.presidiocreative.com/promotions/bundle-and-save (fetch with `broadcast-docs` `getPage`). Distilled copy in `references/broadcast-docs.md`.

## How the theme reads it (Broadcast 8.x)

- Product page `bundle-save` block: `snippets/product.liquid` reads `product.metafields.theme.bundle.value` and `product.metafields.theme.bundle_list.value`; the block's `bundle_title` text setting supplies the heading and the docs connect it to `custom.bundle_title` so each product can have its own title.
- Cart drawer: `snippets/cart-line-items.liquid` reads the same metafields per line item; requires the **Bundle products** block in the cart drawer section, which has its own `bundle_title` default ("Bundle and save 10%").

## Workflow

1. **Create the automatic discount first** (Shopify Admin → Discounts → Automatic, or `discountAutomaticBasicCreate` / `discountAutomaticBxgyCreate`). Products in the discount must be exactly the products you will pair. Test it by adding the items to the cart before touching the theme; if the discount does not apply here, the theme cannot fix it.
2. **Create the metafield definitions once**: `scripts/metafield-definitions.graphql` + `.variables.json` creates `theme.bundle_list` (list of products), `theme.bundle` (single product) and `custom.bundle_title` (single line text). Note the title lives in the `custom` namespace per the docs, not `theme`.
3. **Pair products**: `metafieldsSet` with `scripts/set-bundle.graphql` on the *main* product: the list value is a JSON array string of product gids (max 3 rendered), and `custom.bundle_title` something like "Bundle and save 15%". Do this on every product that is part of the bundle if the promotion should appear from each of them.
4. **Add and connect the block**: ensure the product template has a `bundle-save` block, then run `scripts/connect_metafield.py templates/product.json --block bundle-save --setting bundle_product_list --metafield theme.bundle_list` and `... --setting bundle_title --metafield custom.bundle_title --value`. In the editor the source must be **Template → Product**, not *Current block*; the docs flag this as the step people miss.
5. **Cart drawer**: add the `bundle-products` block to the cart drawer section (Overlay group) and set its `bundle_title`.
6. **Verify** on a preview theme: `scripts/verify_bundles.sh <store> <handle> [preview_theme_id]`, then add the bundle from the product page and confirm the cart shows the discounted line total and savings.

## Pitfalls

- Discount and metafield out of sync is the top failure: the promotion shows but no saving appears, or the saving applies without a promotion.
- `show_available_bundle_only` hides out-of-stock companions; with it off a sold-out companion renders with no add button.
- Keep bundles and upsells distinct; the same product in `theme.upsell_list` and `theme.bundle_list` shows twice.
- Percentage in the title is copy, not logic. Change the discount and the title together.
