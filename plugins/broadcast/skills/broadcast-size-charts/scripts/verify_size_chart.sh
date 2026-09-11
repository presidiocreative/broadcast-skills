#!/usr/bin/env bash
# Usage: verify_size_chart.sh <store-domain> <product-handle> [preview_theme_id]
set -u
STORE=${1:?store}; HANDLE=${2:?handle}; PREVIEW=${3:-}; Q=""; [ -n "$PREVIEW" ] && Q="?preview_theme_id=$PREVIEW"
JAR=$(mktemp); pdp=$(curl -sL -c "$JAR" -b "$JAR" "https://$STORE/products/$HANDLE$Q")
echo "size option present:   $(grep -c -iE 'radio__legend__label[^>]*>\s*Size|data-option-name="Size"|>Size<' <<<"$pdp")"
echo "size chart trigger:    $(grep -c -iE 'size-chart|size_chart|data-popup-open[^>]*size' <<<"$pdp")"
echo "size chart page link:  $(grep -oE 'href="/pages/[^"]*size[^"]*"' <<<"$pdp" | sort -u | xargs)"
echo "fit guide block:       $(grep -c -iE 'fit-guide|fit__guide|product__block--fit' <<<"$pdp")"
echo "If trigger is 0: the product needs an option literally named as the 'Size' translation, and the Variant picker block needs info_page or the size_chart metafield connected."
rm -f "$JAR"
