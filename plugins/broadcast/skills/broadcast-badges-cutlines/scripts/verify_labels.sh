#!/usr/bin/env bash
# Usage: verify_labels.sh <store-domain> <collection-handle> [preview_theme_id]
set -u
STORE=${1:?store}; COLL=${2:-all}; PREVIEW=${3:-}; Q=""; [ -n "$PREVIEW" ] && Q="?preview_theme_id=$PREVIEW"
JAR=$(mktemp); grid=$(curl -sL -c "$JAR" -b "$JAR" "https://$STORE/collections/$COLL$Q")
python3 - "$grid" <<'PY'
import re,sys,collections
h=sys.argv[1]
def texts(cls):
    return [re.sub(r"\s+"," ",t).strip() for t in re.findall(r'<span[^>]*class="[^"]*\b%s\b[^"]*"[^>]*>(.*?)</span>' % cls, h, re.S)]
badges=collections.Counter(texts("custom-box"))
print("custom badges:  ", dict(badges) or "none")
print("sale badges:    ", len(texts("sale-box")), "  sold out:", len(texts("sold-box")), "  new:", len(texts("new-box")), "  pre-order:", len(texts("preorder-box")))
cut=[re.sub(r"\s+"," ",t).strip() for t in re.findall(r'class="[^"]*cutline[^"]*"[^>]*>(.*?)<', h, re.S)]
print("cutlines:       ", [c for c in cut if c][:6] or "none")
print("final sale:     ", len(re.findall(r'final[-_ ]sale', h, re.I)), "match(es)")
PY
echo "If a custom badge is missing: check show_custom_badge, the theme.badge value or _badge_ tag, and that the product is not sold out (Sold out overrides)."
rm -f "$JAR"
