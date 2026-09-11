#!/usr/bin/env python3
"""Cross-check variant colour values against the theme's swatch_color_list and native swatches.

Usage: audit_swatch_values.py <settings_data.json> <swatch-values.json>
  swatch-values.json is the output of scripts/swatch-values.graphql (the data.products.nodes array or the full response).
Prints every option value that will render grey: no native swatch and no matching line in swatch_color_list.
"""
import json, re, sys

def handle(s):
    s = s.lower().strip(); s = re.sub(r"[^a-z0-9]+", "-", s); return s.strip("-")

def main():
    if len(sys.argv) < 3: sys.exit(__doc__)
    raw = open(sys.argv[1]).read(); raw = re.sub(r"^\s*/\*.*?\*/\s*", "", raw, flags=re.S)
    settings = json.loads(raw); cur = settings.get("current", {})
    if isinstance(cur, str): cur = settings["presets"][cur]
    listed = set()
    for line in (cur.get("swatch_color_list") or "").splitlines():
        if ":" in line: listed.add(handle(line.split(":", 1)[0]))
    data = json.load(open(sys.argv[2]))
    nodes = data.get("data", {}).get("products", {}).get("nodes") if isinstance(data, dict) and "data" in data else data
    if isinstance(nodes, dict): nodes = nodes.get("nodes", [])
    grey = {}
    for p in nodes:
        for opt in p.get("options", []):
            if "colo" not in opt["name"].lower(): continue
            for v in opt.get("optionValues", []):
                sw = v.get("swatch") or {}
                native = bool(sw.get("color") or sw.get("image"))
                if not native and handle(v["name"]) not in listed:
                    grey.setdefault(v["name"], []).append(p["handle"])
    if not grey:
        print("every colour value resolves to a native swatch or a swatch_color_list entry"); return
    print("values that will render as grey chips:")
    for name, handles in sorted(grey.items()):
        print(f"  {name!r} (handle {handle(name)}) on {len(handles)} product(s): {', '.join(handles[:4])}{'…' if len(handles)>4 else ''}")
    print("\nFix: link the option to shopify--color-pattern, or add lines to Theme settings → Swatches → HEX codes and files, e.g.")
    for name in sorted(grey): print(f"  {name}: #cccccc")

if __name__ == "__main__":
    main()
