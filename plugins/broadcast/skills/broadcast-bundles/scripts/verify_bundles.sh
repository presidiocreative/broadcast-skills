#!/usr/bin/env bash
# Usage: verify_bundles.sh <store-domain> <product-handle> [preview_theme_id]
set -u
STORE=${1:?store}; HANDLE=${2:?handle}; PREVIEW=${3:-}; Q=""; [ -n "$PREVIEW" ] && Q="?preview_theme_id=$PREVIEW"
JAR=$(mktemp); pdp=$(curl -sL -c "$JAR" -b "$JAR" "https://$STORE/products/$HANDLE$Q")
echo "bundle block present:  $(grep -c 'bundle-save\|product__block--bundle\|data-bundle' <<<"$pdp")"
echo "bundle title:          $(grep -oE 'Bundle and save[^<]*' <<<"$pdp" | head -1)"
echo "companion products:    $(grep -oE 'bundle[^>]*href="/products/([^"?#]+)' <<<"$pdp" | sed 's/.*products\///' | sort -u | xargs)"
echo "Then: add the bundle to cart and confirm the cart shows the automatic discount. If the promotion shows but no saving: the automatic discount does not match these products."
rm -f "$JAR"
