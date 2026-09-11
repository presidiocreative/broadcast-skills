# Swatches (NEW)

Product variant swatches for versions above 8.0.0

### Shopify Native Swatches

Using category metafields for color swatches makes product management more consistent, scalable, and automated. Instead of manually defining variant values for each product, you create color definitions (names, visuals, and metadata) in one place and reuse them across your store.

This approach ensures that:

* **Consistency is maintained** - updating a color (e.g., “Black” to “Graphite”) automatically updates it everywhere.
* **Setup is faster** - variant options are auto-filled from predefined entries.
* **Swatches work out-of-the-box** - compatible themes can display visual color swatches without custom code.
* **Filtering improves** - colors can be used as standardized filters in search and navigation.
* **Discoverability increases** - structured data aligns with Shopify’s taxonomy, improving SEO and marketplace compatibility.

Overall, category metafields turn color swatches into a **single source of truth**, reducing manual work and making your storefront more dynamic and user-friendly.

See: https://www.loom.com/share/6371b9752afe4619b1a4633f21da85ed

---

# Swatches

Control how product variant options (such as colors or materials) are displayed across product and collection pages. They enhance visual product selection and improve customer browsing experiences.

> To use swatches on variants other than color, edit the corresponding labels in your [language files](https://admin.shopify.com/store/broadcast-theme-main/settings/languages).

**Swatches type**: Choose how variant swatches are displayed:

* **`Theme`:** Uses the theme’s custom-designed swatches for a polished look.
* **`Native`:** Uses Shopify’s default swatch behavior.
* **`None`:** Disables swatches entirely.

**Show sale indicator**: Adds a red dot below color swatches when a variant is on sale, helping customers identify discounted products at a glance.

**Swatch size**: Controls the display size of variant swatches to maintain consistent spacing and alignment within product grids.

**Swatch style**:  Select between `Circle` or `Square` swatches to match your store’s visual style and product presentation. Learn more: [Swatch collection styles](https://broadcast.presidiocreative.com/collections/collection-pages/swatch-collection-styles)

**Collection style**: Options: `Text only`, `Slider`, `Slider on hover`, `Swatch with text`, or `Grid`

> Note: Some styles only apply when the mobile layout is set to 2 items per row.

**HEX codes and files**: Customize swatch appearances for specific variant names using HEX color codes or uploaded image files.\
Each rule should appear on its own line.

* Accepts both color values and file names.
* Upload image files under [Content -> Files](https://admin.shopify.com/store/broadcast-theme-main/content/files?selectedView=all\&media_type=IMAGE)
* [Learn more for swatches](https://broadcast.presidiocreative.com/products/product-pages/swatches)

---

# Swatch collection styles

Customize the swatch and siblings display style on collection pages and all product grid listings

> Introduced in Broadcast 5.6

Broadcast includes flexible swatch and sibling display options, including:

* Circle or Square shaped swatches and siblings
* Regular or large-sized swatches and siblings

In addition to the size and shape, Broadcast includes swatch and sibling collection styles for all your collection pages and product grid listings:

#### Examples of collection style options:

### Slider on hover

Clean text is displayed on the Product grid. Upon hover, the text is replaced with swatches or siblings. The slider feature keeps all swatch options aligned horizontally on a single line:

### Text only

A clean text version that displays the number of swatches or siblings that are available:

### Swatches with text

Displays a sample of swatches or siblings on a single line and indicates how many additional options are available with text:

### Slider

Displays the swatch or siblings slider on one line at all times:

### Grid

Displays all possible swatches or sibling options that are available to choose from:

### How to configure

Use the global **Theme Settings** -> **Swatches** -> **Collection style**

Choose your collection style in the drop-down:

**Save** your changes. 

### Speed and performance

The load time for collections and the product grid increases significantly when many swatches are loaded. Stores looking to improve the load times can use:

* Text only
* Swatches with text

These two require the fewest queries to be sent to Shopify's backend when loading a collection page or product grid section. Text-only is the fastest, as it doesn't need to load any images. Swatches-with-text only loads five swatches, which is a good, balanced option. 

The slider and grid styles will load all swatches, making them the slower options. To help reduce the number of queries, decrease the number of items displayed per page. This method will help optimize load times regardless of which swatch style you choose.
