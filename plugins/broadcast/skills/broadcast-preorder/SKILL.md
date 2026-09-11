---
name: broadcast-preorder
description: Set up pre-order on a Shopify store running the Broadcast theme by Presidio Creative. Use when a merchant asks to add pre-order, "coming soon", or backorder buttons or badges to products or specific variants, asks how Broadcast handles pre-orders, wants a pre-order product template, or reports that Pre-order is not showing on quick add, the cart bar or the collection grid. Covers the _preorder tag, the theme.preorder product and variant metafields, badge settings, the product.preorder template, inventory and payment-capture caveats, and known Broadcast 8.1.0 fixes.
---

# Broadcast pre-order

Broadcast has pre-order built in. Nothing is installed; a product or variant is flagged and the theme swaps **Add to cart** for **Pre-order**, shows a Pre-order badge on grids and the product page, and stamps the cart line with a `Sale type: Pre-order` property. Everything else (charging, fulfilment dates, deposits) is Shopify or an app, not the theme.

Live docs (fetch with the `broadcast-docs` MCP `getPage` tool when you need the merchant-facing steps):

- https://broadcast.presidiocreative.com/products/product-pages/pre-order-products (tag method)
- https://broadcast.presidiocreative.com/products/product-pages/pre-order-using-metafields (product metafield)
- https://broadcast.presidiocreative.com/products/product-pages/pre-order-variants-with-metafields (variant metafield, Broadcast 7.1+)
- https://broadcast.presidiocreative.com/theme-settings/theme-settings/badges

A distilled copy is in `references/broadcast-docs.md` if the MCP server is unavailable.

## Decide the method first

| Merchant situation | Use |
| --- | --- |
| A handful of products, whole product is pre-order, no admin setup wanted | Tag `_preorder` |
| Ongoing use, merchandisers toggle it from the product form | Product metafield `theme.preorder` (boolean) |
| Only some colors or sizes are pre-order | Variant metafield `theme.preorder` (boolean) |

Any one method is enough; the theme checks all three. The metafield methods need the definitions created once (step 2). Both live in namespace `theme`, key `preorder`, type `boolean`, exactly as the docs specify. Do not rename them.

## Workflow

1. **Confirm the theme.** Read `config/settings_schema.json` `theme_info` for the version, and grep `snippets/product-buttons.liquid` for `metafields.theme.preorder`. Variant-level support needs 7.1 or later. If the theme is customised, check the same grep in `product-grid-item.liquid`, `quick-add-product.liquid` and `cart-bar.liquid`.
2. **Create the metafield definitions** (skip for the tag-only method). Run `scripts/metafield-definitions.graphql` with `scripts/metafield-definitions.variables.json`. Do **not** pass `access.admin`; Shopify rejects any admin access control on the `theme` namespace with "must be one of public_read_write". Pin them so they show on the product form.
3. **Turn on the badge.** Theme settings → Badges → *Show pre-order badge* is `show_preorder_badge` in `config/settings_data.json` `current`. Set it to `true` and set `preorder_bg_color` / `preorder_text_color` to brand colors. If `current` is a string (a preset name) or a mangled object with keys `"0","1",...`, rebuild it from the preset first or Shopify's editor will complain that color schemes are undefined.
4. **Create a pre-order template (optional, recommended).** Run `scripts/create_preorder_template.py templates/product.json templates/product.preorder.json`. It copies the default product template, turns off dynamic checkout (Buy it now) in the Buy buttons block per the docs, adds a "Pre-order details" text block under the button for ship-date copy, and disables the Inventory countdown block, which would read as out of stock on zero-stock pre-order items. It preserves Shopify's auto-generated comment header if present. Assign it per product with `templateSuffix: "preorder"`.
5. **Flag the products.** Tag method: `tagsAdd` with `_preorder`. Metafield method: `metafieldsSet` with `scripts/set-preorder.graphql` (ownerId is a Product or ProductVariant gid, value `"true"`). Add `templateSuffix` on the same `productUpdate` when using the template.
6. **Make the variant purchasable.** The flag only changes labels. A tracked variant at zero stock is still unavailable and shows *Sold out*. Set `inventoryPolicy: CONTINUE` on pre-order variants or keep stock on hand. Tell the merchant this explicitly; it is the most common "pre-order isn't working" cause.
7. **Payment capture.** The docs recommend Settings → Payments → *Manually capture payment*. It is store-wide, so flag the trade-off. Deposits or split payments need a selling-plan app; Broadcast's pre-order is a label-and-badge feature only.
8. **Apply the 8.1.0 fixes if the theme has them.** In stock Broadcast 8.1.0 the quick-add button never switches to Pre-order (the `preorder` variable is never assigned in `snippets/quick-add-product.liquid`) and the sticky cart bar ignores the variant metafield (`snippets/cart-bar.liquid`). `references/theme-8.1.0-fixes.patch` is the diff; apply it if `grep -n "assign preorder = " snippets/quick-add-product.liquid` returns nothing.
9. **Verify on a preview theme, never on the live theme.** Push the branch with `shopify theme push --unpublished --theme "<branch> preview"` and run `scripts/verify_preorder.sh <store> <product-handle> <preview_theme_id>`. It checks the product page button, the hidden `properties[Sale type]` input, the grid badge and quick-add label, and the sticky bar. Then add to cart and confirm the line shows *Pre-order* in the drawer.

## Button text

`products.product.pre_order` in `locales/en.default.json` ("Pre-order"). Merchants change it under *Edit default theme content*; do not hard-code a different label in Liquid.

## Pitfalls seen in the field

- Setting `access` on a `theme` namespace definition fails. Omit it.
- The theme editor's "color schemes must be defined in settings_data and settings_schema" alert means `current` has no `color_schemes` key. Rebuild `current` from `presets`.
- Pushing settings fails if a range value is off its step (`heading_letter_spacing` step 25, `logo_max_limit` step 5) or a font handle does not exist in Shopify's library.
- On a GitHub-connected theme, `main` is usually the live theme. Branch, preview, PR. A PR whose base is another feature branch merges into that branch, not `main`.
- Archived or unpublished products still carry the metafield; clearing it is optional.
