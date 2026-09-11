# broadcast-skills

Claude Code skills for building on the [Broadcast](https://broadcast.presidiocreative.com) Shopify theme by Presidio Creative. Each skill teaches Claude how to implement one Broadcast feature end to end on a real store: the Admin API calls, the theme edits, the settings, the gotchas, and how to verify the result on the storefront.

The [Broadcast help docs](https://broadcast.presidiocreative.com) stay the source of truth for merchants. These skills add the agent-specific knowledge the docs do not carry, and they fetch the live doc pages at run time through the bundled `broadcast-docs` MCP server rather than copying them.

## Install

In Claude Code:

```
/plugin marketplace add presidiocreative/broadcast-skills
/plugin install broadcast@broadcast-skills
```

Or from a terminal:

```bash
claude plugin marketplace add presidiocreative/broadcast-skills
claude plugin install broadcast@broadcast-skills
```

Installing the plugin also registers the `broadcast-docs` MCP server, which exposes `searchDocumentation`, `getPage` and `askQuestion` over the Broadcast GitBook.

## Skills

| Skill | Use it when |
| --- | --- |
| `broadcast-preorder` | A merchant wants Pre-order buttons and badges on some products or variants, or asks how Broadcast handles pre-orders. |
| `broadcast-siblings` | A merchant wants each colour sold as its own product with linked swatches on the product page. |
| `broadcast-upsells` | Pair products for "Complete the look" promotions on the product page and cart drawer. |
| `broadcast-bundles` | Bundle and Save promotions backed by an automatic discount (Broadcast 7.1+). |
| `broadcast-badges-cutlines` | Custom badges, cutline second-line text, Final Sale messaging. |
| `broadcast-size-charts` | Size chart pages per product and the Fit guide block. |
| `broadcast-swatches` | Variant colour swatches: Shopify native colour taxonomy vs the theme swatch list, grid swatch styles. |

Skills trigger automatically from natural requests ("add pre-order to this product", "set up siblings for the Antigravity colours", "why are my swatches grey"), or explicitly with `/broadcast-<name>`.

## What a skill needs from the session

- Shopify Admin API access to the store: the Shopify MCP connector, Shopify CLI (`shopify store execute`), or an app token. The skills describe the operations as Admin GraphQL so any of those work.
- A clone of the store's theme when template or snippet edits are required. Both skills assume a GitHub-connected theme repo where a branch can be pushed as an unpublished preview theme with `shopify theme push --unpublished`.

## Repo layout

```
.claude-plugin/marketplace.json     marketplace manifest (this repo)
plugins/broadcast/
  .claude-plugin/plugin.json        plugin manifest and version
  .mcp.json                         broadcast-docs MCP server
  skills/<skill>/SKILL.md           the skill
  skills/<skill>/references/        distilled docs, patches, decision notes
  skills/<skill>/scripts/           GraphQL operations and helper scripts
```

## Adding a skill

1. Create `plugins/broadcast/skills/<name>/SKILL.md` with `name` and `description` frontmatter. The description is what makes the skill trigger, so write it as the requests a merchant would actually make.
2. Put anything long in `references/` and anything repeatable in `scripts/`. Keep `SKILL.md` to the workflow, decisions and pitfalls.
3. Bump `version` in both manifests and add a `CHANGELOG.md` entry.
4. Test the install path: `claude plugin marketplace update broadcast-skills` then `claude plugin install broadcast@broadcast-skills`, and run the skill against a sandbox store before merging.

## Versioning

Semantic versions. Skills are tied to Broadcast behaviour, so note the theme version a change was verified against in the changelog.

## License

MIT.
