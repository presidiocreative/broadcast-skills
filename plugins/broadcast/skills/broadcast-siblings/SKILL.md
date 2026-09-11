---
name: broadcast-siblings
description: Set up Broadcast product siblings on a Shopify store: sell each colour as its own product and show linked colour swatches on the product page and product grid. Use when a merchant on the Broadcast theme by Presidio Creative asks for siblings, linked products, colour swatches that jump between products, "one product per colour", or reports sibling swatches not appearing. Covers the theme.sibling_color and theme.siblings metafield definitions, product and collection setup, wiring the Siblings block with dynamic sources, image vs colour swatches, and the troubleshooting checklist.
---

# Broadcast product siblings

Siblings split colours into separate products (each with its own photos, inventory, price and size variants) and link them with swatches on the product page. Broadcast reads two product metafields and a collection that groups the set. Feature introduced in Broadcast 3.5.

Live docs (fetch with the `broadcast-docs` MCP `getPage` tool):

- https://broadcast.presidiocreative.com/siblings/product-siblings/how-to-setup-siblings
- https://broadcast.presidiocreative.com/siblings/product-siblings/siblings-metafields
- https://broadcast.presidiocreative.com/siblings/product-siblings/siblings-block
- https://broadcast.presidiocreative.com/siblings/product-siblings/siblings-setup-troubleshooting-checklist

`references/broadcast-docs.md` has a distilled copy.

## How the theme resolves siblings

`snippets/product-siblings.liquid` reads the Siblings block settings. `siblings_collection` is a text setting that should be **connected to the metafield** `theme.siblings` (a collection handle); `sibling_color` should be connected to `theme.sibling_color` (the swatch label). It then iterates `collections[handle].products`, and for each sibling reads its own `theme.sibling_color`. Theme settings → Swatches → *Sibling style* chooses `image` (the sibling's featured image as the swatch) or `swatch` (a colour chip named after the label). Older key names (`siblings_color`, `sibling_colour`, ...) are accepted as fallbacks; use `sibling_color`.

## Workflow

1. **Confirm the theme** has `snippets/product-siblings.liquid` and a `siblings` block in the product section schema (`grep -n '"type": "siblings"' sections/product.liquid`).
2. **Create the two metafield definitions** (Products): run `scripts/metafield-definitions.graphql` with `scripts/metafield-definitions.variables.json`. Both are `single_line_text_field`, namespace `theme`, keys `sibling_color` and `siblings`. Pin them. Storefront read access (`access.storefront: PUBLIC_READ`) is accepted on this namespace; admin access control is not, so leave `access.admin` out.
3. **Create one product per colour.** Same base title with the colour appended ("Antigravity – Storm Grey"), **no Colour option**: sizes or other real options only. Each product gets `theme.sibling_color` = the colour name and `theme.siblings` = the group's collection handle. `productSet` can create product, variants, media and metafields in one call; see `scripts/product-set.example.json`. Converting an existing product that has a Colour option means replacing its variant set (productSet with `identifier`), so confirm with the merchant first and never do it on a product with order history without checking.
4. **Create the grouping collection.** A manual collection whose handle matches `theme.siblings`, containing every sibling. Run `scripts/collection-create.graphql`. It must be **active and published to the Online Store**, otherwise Liquid cannot see it and the swatches disappear. It does not need to be in any menu; the docs suggest hiding it from navigation.
5. **Publish the products** to the Online Store (`publishablePublish`) if they were created through the API; they are not published automatically.
6. **Wire the Siblings block.** Run `scripts/wire_siblings_block.py templates/product.json [templates/product.*.json ...]`. It sets the block's `siblings_collection` to `{{ product.metafields.theme.siblings.value }}` and `sibling_color` to `{{ product.metafields.theme.sibling_color.value }}`, preserving Shopify's comment header. The `.value` suffix is mandatory: Shopify rejects the template with "Metafield ... must end with '.value' when not using a metafield filter". Merchants can do the same in the theme editor by clicking the dynamic-source icon on those two settings.
7. **Choose the swatch style.** For photographed colourways set `sibling_style` to `image` in `config/settings_data.json` `current` (or Theme settings → Swatches). `swatch` style needs the colour label to map to a defined swatch colour, otherwise the chip renders grey.
8. **Verify on a preview theme**: `scripts/verify_siblings.sh <store> <sibling-handle> <preview_theme_id>` counts `swatch__button` elements, lists the `data-swap-target` siblings and prints the current colour label. Then click a swatch in a browser: it should swap to the sibling product and update the URL.

## Troubleshooting

Work through the docs checklist (`references/broadcast-docs.md`, last section). The usual causes, in order: the collection is unpublished or the handle in `theme.siblings` does not match; a sibling product is draft or unpublished; the block settings are not connected to the metafields (or connected without `.value`); the Siblings block is missing from the product template; a sibling still has a Colour variant option so the theme shows both.

## Adding a colour later

Duplicate one sibling, replace photos and title, set `theme.sibling_color` and `theme.siblings`, add it to the grouping collection, publish it.
