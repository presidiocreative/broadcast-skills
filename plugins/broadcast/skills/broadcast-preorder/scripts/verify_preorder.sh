#!/usr/bin/env bash
# Verify Broadcast pre-order rendering on a storefront (optionally a preview theme).
# Usage: verify_preorder.sh <store-domain> <product-handle> [preview_theme_id] [collection-handle]
set -u
STORE=${1:?store domain, e.g. presidio-sandbox.myshopify.com}
HANDLE=${2:?product handle}
PREVIEW=${3:-}
COLL=${4:-all}
Q=""; [ -n "$PREVIEW" ] && Q="?preview_theme_id=$PREVIEW"
JAR=$(mktemp)
pdp=$(curl -sL -c "$JAR" -b "$JAR" "https://$STORE/products/$HANDLE$Q")
grid=$(curl -sL -c "$JAR" -b "$JAR" "https://$STORE/collections/$COLL$Q")
echo "Product page:"
echo "  data-preorder:      $(grep -oE 'data-preorder="[a-z]+"' <<<"$pdp" | head -1)"
echo "  button text:        $(grep -oE 'data-add-to-cart-text>[^<]*' <<<"$pdp" | head -1 | sed 's/.*>//' | xargs)"
echo "  line property:      $(grep -c 'data-product-preorder' <<<"$pdp") hidden input(s)"
echo "  badge:              $(grep -oE 'preorder-box[^>]*>[^<]*' <<<"$pdp" | head -1 | sed 's/.*>//' | xargs)"
echo "  sticky bar label:   $(sed -n 's/.*class="cart-bar__submit[^"]*".*//p' <<<"$pdp" >/dev/null; python3 - "$pdp" <<'PY'
import re,sys
h=sys.argv[1]; i=h.find('class="cart-bar__submit')
m=re.search(r'class="btn__text"[^>]*>\s*([^<{]+?)\s*<', h[i:i+3000]) if i>=0 else None
print(m.group(1) if m else "(no cart bar)")
PY
)"
echo "Collection grid ($COLL):"
echo "  pre-order badges:   $(grep -c 'preorder-box' <<<"$grid")"
echo "  quick-add labels:   $(grep -oE 'class="btn__text">\s*[A-Za-z -]+' <<<"$grid" | sed 's/.*>//' | sort | uniq -c | xargs)"
echo "Expect: data-preorder=\"true\", button 'Pre-order', 1+ hidden input, badge 'Pre-order', quick-add 'Pre-order' on flagged cards."
echo "Note: a sticky bar label of 'Configure' is normal for multi-variant products until a variant is chosen; test with ?variant=<id> to see the Pre-order label."
rm -f "$JAR"
