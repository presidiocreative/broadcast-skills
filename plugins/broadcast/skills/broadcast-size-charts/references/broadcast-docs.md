# Size charts

Display different size charts on product pages

Broadcast includes a feature to display a custom size chart for any product you sell or a single size chart for all products when using the default product template:

### Adding size charts to your store

For stores that <mark style="background-color:yellow;">require multiple size charts</mark>, Broadcast offers the ability to associate each product with a unique and specific size chart. For example, an apparel shop can have separate size charts for women's and men's products. Each product can be linked to help the customer find the right size chart. 

Other stores might only need one size chart for all their products. The setup for this kind of situation is very straightforward.

For multiple size charts, Broadcast uses product metafields to assign each product to a specific size chart. We'll walk you through the necessary setup steps below. 

## How to set up

To start, you'll need to create your size chart pages. Broadcast will utilize Shopify's built-in Pages feature to display the size charts. If you already have an image of your size charts, you can simply upload it to a Shopify page. 

### Step 1: Create your size chart pages

Begin outside of the Theme Customizer, in the main Shopify Admin. Navigate to:

Sales channels > Online store > Pages

* Choose the "Add page" button to create a new page. 
* If you have an image already created for your size chart, add that to the content section of the page, or build a size chart page using the Shopify Rich Editor:

### Step 2: Create a reference metafield

(Easy) The next step is to define a Product metafield using Page as the reference type. Here's a quick video on how to create the Size Chart metafield:

See: https://www.loom.com/share/bae6b0096c74480fa79fb858945b8e32?sid=c6d58c0a-f92c-47f6-8fe7-d6e87c0932a7

#### Metafield reference from video

| Metafield details |                     |              |
| ----------------- | ------------------- | ------------ |
| Metafield type    | Product             |              |
| Name              | Size Chart          |              |
| Namespace and key | `custom.size_chart` |              |
| Description       | Size Chart          |              |
| Type              | **Page**            | **One page** |

#### Screenshot

### Step 3: Set up products

Your products will now have a Metafields section at the bottom. Use this to select which size chart page should be displayed when a customer is viewing this product. 

* Choose the size chart page from Step 1 to associate with this product:

### Step 4: Theme Customizer, connect the metafield

Next, we can use the Theme Customizer to activate the Size Chart metafield. There's one quick step to tell Broadcast to use the metafield you created in Step 2. 

* Select your Product template, such as "Default product", in the Theme Customizer.
* On the left sidebar, under Template, expand "Product pages" and then choose "<mark style="background-color:yellow;">**Variant picker**</mark>"
* Use the dynamic data icon  to select your Size Chart metafield. 

#### Video for Step 4

Here's a short video on the above steps:

See: https://www.loom.com/share/019f7fb87c6e4c4cbd78d75e0778578e?sid=a4c6950c-7edd-48b0-86b1-652921ee1590

Your theme will now use unique size charts that you created in Step 1 and mapped to individual products in Step 3. 

### Final notes

If you're not seeing the link for a size chart, make sure that the product you're viewing has a size chart page linked under the Metafields section. See Step 3. 

If all steps are correct and you're still not seeing the link, exit the Theme Customizer and re-enter. Sometimes, the Shopify platform requires that step to force a refresh. 

***

## How to use one chart for all products

If your store requires only **one** size chart for all product pages, you can skip steps 2 and 3 and simply choose the page in the Theme Customizer under Product pages > Variant picker. 

**Tip**: You can use multiple product templates and assign one chart to each template. Then assign groups of products to each of the product templates.

---

# Fit guide

The **Fit Guide** block provides a visual scale to help shoppers understand how a product fits from small to large, with labels and a highlighted active segment. It’s ideal for reducing return rates by setting proper expectations for sizing, especially for apparel or footwear.

<table><thead><tr><th width="145.68408203125">Settings</th><th width="88.8992919921875" align="center">Type</th><th>Description</th></tr></thead><tbody><tr><td>Heading</td><td align="center"><code>text</code></td><td>Title of the fit guide block. Typically something like 'Fit' or 'Sizing'.</td></tr><tr><td>Active segment</td><td align="center"><code>text</code></td><td>Indicates which of the 5 segments is highlighted to represent fit. Enter a number from 1 to 5. Supports dynamic values via product metafield for product-specific fit.</td></tr><tr><td>Left label</td><td align="center"><code>text</code></td><td>Label shown on the left side of the fit scale.</td></tr><tr><td>Middle label</td><td align="center"><code>text</code></td><td>Label shown in the center of the scale.</td></tr><tr><td>Right label</td><td align="center"><code>text</code></td><td>Label shown on the right side of the scale.</td></tr><tr><td><strong>Colors</strong></td><td align="center"></td><td></td></tr><tr><td>Color</td><td align="center"><code>color</code></td><td>Custom color for the fit indicator and active segment.</td></tr><tr><td><strong>Padding</strong></td><td align="center"></td><td></td></tr><tr><td>Bottom</td><td align="center"><code>range</code></td><td>Adds vertical spacing below the block.</td></tr></tbody></table>

## Notes

* **Fit** range is always shown on a 1-5 scale.
* The active segment visually communicates how the product fits relative to size expectations.
* This block helps boost buyer confidence and minimize size-related returns.
* To support **per-product fit**, use a metafield for `selected_segment`.
