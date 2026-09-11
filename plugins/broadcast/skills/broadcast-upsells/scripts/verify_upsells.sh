#!/usr/bin/env bash
# Usage: verify_upsells.sh <store-domain> <product-handle> [preview_theme_id]
set -u
STORE=${1:?store}; HANDLE=${2:?handle}; PREVIEW=${3:-}; Q=""; [ -n "$PREVIEW" ] && Q="?preview_theme_id=$PREVIEW"
JAR=$(mktemp); pdp=$(curl -sL -c "$JAR" -b "$JAR" "https://$STORE/products/$HANDLE$Q")
echo "upsell block present:  $(grep -c 'product__block--upsell\|data-upsell\|upsell__' <<<"$pdp")"
echo "upsell products:       $(grep -oE 'upsell[^>]*href="/products/([^"?#]+)' <<<"$pdp" | sed 's/.*products\///' | sort -u | xargs)"
echo "cart drawer block:     $(grep -c 'upsell-products\|cart__upsell\|data-cart-upsell' <<<"$pdp") match(es) in page markup"
echo "Expect: block present, paired product handles listed. If none: check metafield namespace/key, product published, and the block setting is connected to Template > Product."
rm -f "$JAR"
