#!/usr/bin/env bash
# Verify Broadcast sibling swatches render on a product page (optionally a preview theme).
# Usage: verify_siblings.sh <store-domain> <sibling-product-handle> [preview_theme_id]
set -u
STORE=${1:?store domain}; HANDLE=${2:?product handle}; PREVIEW=${3:-}
Q=""; [ -n "$PREVIEW" ] && Q="?preview_theme_id=$PREVIEW"
JAR=$(mktemp)
pdp=$(curl -sL -c "$JAR" -b "$JAR" "https://$STORE/products/$HANDLE$Q")
echo "swatch buttons:   $(grep -c 'swatch__button' <<<"$pdp")"
echo "siblings linked:  $(python3 - "$pdp" <<'PY'
import re,sys
h=sys.argv[1]
print(" ".join(sorted(set(re.findall(r'swatch__button[^>]*?href="/products/([^"?#]+)', h)))) or "(no links found)")
PY
)"
echo "swatch classes:   $(grep -oE 'swatch-[a-z0-9-]+' <<<"$pdp" | grep -v swatch-input | sort -u | xargs)"
echo "current label:    $(grep -oE 'radio__legend__value[^>]*>[^<]+' <<<"$pdp" | head -1 | sed 's/.*>//')"
echo "Expect: one swatch per sibling (including this product), and the label equal to this product's theme.sibling_color."
echo "If 0 swatches: check the grouping collection is published and its handle equals theme.siblings, siblings are active+published, and the block settings end with .value."
rm -f "$JAR"
