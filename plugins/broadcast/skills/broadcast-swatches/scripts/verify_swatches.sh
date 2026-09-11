#!/usr/bin/env bash
# Usage: verify_swatches.sh <store-domain> <product-handle> [preview_theme_id]
set -u
STORE=${1:?store}; HANDLE=${2:?handle}; PREVIEW=${3:-}; Q=""; [ -n "$PREVIEW" ] && Q="?preview_theme_id=$PREVIEW"
JAR=$(mktemp); pdp=$(curl -sL -c "$JAR" -b "$JAR" "https://$STORE/products/$HANDLE$Q")
echo "swatch buttons:      $(grep -c 'swatch__button' <<<"$pdp")"
echo "text option buttons: $(grep -c 'radio__button' <<<"$pdp")   (Broadcast 8.x renders an option as text buttons when none of its values has a swatch source)"
python3 - "$pdp" <<'PY'
import re,sys
h=sys.argv[1]
for m in re.finditer(r'<tooltip-component[^>]*swatch__button[^>]*data-tooltip="([^"]*)"[^>]*style="--swatch: ([^;"]*)', h):
    val=m.group(2).strip(); status="ok" if (val.startswith("rgb") or val.startswith("url") or val.startswith("#")) else ("theme list var, grey unless defined" if val.startswith("var(") else "EMPTY -> grey")
    print(f"  {m.group(1):20s} {val:45s} {status}")
PY
echo "Native swatches show rgb(...) or url(...). var(--name) needs a matching line in Theme settings → Swatches → HEX codes and files."
rm -f "$JAR"
