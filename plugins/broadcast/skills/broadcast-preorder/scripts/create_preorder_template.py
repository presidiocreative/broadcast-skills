#!/usr/bin/env python3
"""Create templates/product.preorder.json from templates/product.json for Broadcast.

Usage: create_preorder_template.py templates/product.json templates/product.preorder.json [--note "custom copy"]

- Turns off dynamic checkout (Buy it now) in the Buy buttons block, per the Broadcast docs.
- Adds a "Pre-order details" text block directly under the buy button.
- Disables the Inventory countdown block (zero-stock pre-orders would read as out of stock).
- Preserves Shopify's auto-generated /* ... */ header if the source has one.
"""
import json, re, sys, copy

DEFAULT_NOTE = ("<p>This item is available for pre-order and will ship as soon as it arrives. "
                "We will email you when it is on the way. You can cancel any time before it ships.</p>")

def main():
    if len(sys.argv) < 3:
        sys.exit(__doc__)
    src, dst = sys.argv[1], sys.argv[2]
    note = DEFAULT_NOTE
    if "--note" in sys.argv:
        note = sys.argv[sys.argv.index("--note") + 1]
    raw = open(src).read()
    m = re.match(r"^(\s*/\*.*?\*/\s*)", raw, re.S)
    header = m.group(1) if m else ""
    tpl = json.loads(raw[len(header):])
    main_id = next((sid for sid, s in tpl["sections"].items() if s.get("type") == "product"), None)
    if not main_id:
        sys.exit("No section of type 'product' found in the template")
    main = tpl["sections"][main_id]
    blocks, order = main["blocks"], main["block_order"]
    buttons = next((bid for bid in order if blocks[bid]["type"] == "buttons"), None)
    if not buttons:
        sys.exit("No 'buttons' block found in the product section")
    blocks[buttons]["settings"]["show_dynamic_checkout"] = False
    blocks["preorder_note"] = {"type": "text", "settings": {
        "title": "Pre-order details", "heading_font_size": "body-medium", "text": note,
        "text_font_size": "body-small", "text_alignment": "text-left", "layout": "left", "padding_bottom": 24}}
    order.insert(order.index(buttons) + 1, "preorder_note")
    for bid in order:
        if blocks[bid]["type"] == "inventory_countdown":
            blocks[bid]["disabled"] = True
    out = json.dumps(tpl, indent=2, ensure_ascii=False)
    open(dst, "w").write(header + out)
    print(f"wrote {dst}: dynamic checkout off, pre-order note added, inventory countdown disabled")

if __name__ == "__main__":
    main()
