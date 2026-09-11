#!/usr/bin/env python3
"""Connect the Broadcast Siblings block to the theme.siblings / theme.sibling_color metafields.

Usage: wire_siblings_block.py templates/product.json [templates/product.preorder.json ...]

Sets, on every block of type "siblings" in the product section:
  siblings_collection = "{{ product.metafields.theme.siblings.value }}"
  sibling_color       = "{{ product.metafields.theme.sibling_color.value }}"
The ".value" suffix is required by Shopify for dynamic sources on text settings.
Preserves Shopify's auto-generated /* ... */ header when present.
"""
import json, re, sys

def wire(path):
    raw = open(path).read()
    m = re.match(r"^(\s*/\*.*?\*/\s*)", raw, re.S)
    header = m.group(1) if m else ""
    tpl = json.loads(raw[len(header):])
    hits = 0
    for sid, sec in tpl.get("sections", {}).items():
        for bid, blk in sec.get("blocks", {}).items():
            if blk.get("type") == "siblings":
                blk.setdefault("settings", {})
                blk["settings"]["siblings_collection"] = "{{ product.metafields.theme.siblings.value }}"
                blk["settings"]["sibling_color"] = "{{ product.metafields.theme.sibling_color.value }}"
                hits += 1
    if not hits:
        print(f"{path}: no siblings block found — add one to the product section in the theme editor first")
        return
    open(path, "w").write(header + json.dumps(tpl, indent=2, ensure_ascii=False))
    print(f"{path}: wired {hits} siblings block(s)")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    for p in sys.argv[1:]:
        wire(p)
