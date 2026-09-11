#!/usr/bin/env python3
"""Connect a Broadcast product-template block setting to a product metafield (dynamic source).

Usage:
  connect_metafield.py <template.json> --block <block type> --setting <setting id> --metafield <namespace.key> [--value] [--section <section type>]

Examples:
  connect_metafield.py templates/product.json --block upsell   --setting upsell_product_list --metafield theme.upsell_list
  connect_metafield.py templates/product.json --block variants --setting info_page           --metafield custom.size_chart
  connect_metafield.py templates/product.json --block fit-guide --setting segment_selected   --metafield custom.fit_segment --value

Resource settings (product, product_list, page, collection, file) take "{{ product.metafields.ns.key }}".
Text settings must use "{{ product.metafields.ns.key.value }}" — pass --value. Both verified against Broadcast 8.1.0.
Preserves Shopify's auto-generated /* ... */ header when present.
"""
import json, re, sys

def main(argv):
    if len(argv) < 2 or "--block" not in argv or "--setting" not in argv or "--metafield" not in argv:
        sys.exit(__doc__)
    path = argv[1]
    get = lambda flag: argv[argv.index(flag) + 1]
    block, setting, mf = get("--block"), get("--setting"), get("--metafield")
    section = get("--section") if "--section" in argv else "product"
    src = "{{ product.metafields.%s%s }}" % (mf, ".value" if "--value" in argv else "")
    raw = open(path).read()
    m = re.match(r"^(\s*/\*.*?\*/\s*)", raw, re.S)
    header = m.group(1) if m else ""
    tpl = json.loads(raw[len(header):])
    hits = 0
    for sid, sec in tpl["sections"].items():
        if sec.get("type") != section:
            continue
        for bid, blk in sec.get("blocks", {}).items():
            if blk.get("type") == block:
                blk.setdefault("settings", {})[setting] = src
                hits += 1
    if not hits:
        sys.exit(f"{path}: no '{block}' block in a '{section}' section — add the block in the theme editor first")
    open(path, "w").write(header + json.dumps(tpl, indent=2, ensure_ascii=False))
    print(f"{path}: set {block}.{setting} = {src} on {hits} block(s)")

if __name__ == "__main__":
    main(sys.argv)
