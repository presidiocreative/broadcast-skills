# About product siblings

Display product images as swatches

Broadcast includes the ability to link directly to other products as product swatches. The result is rich product detail pages that include swatches with images that represent each variant option. 

This feature is called Siblings. When you view a sibling product, only the images associated with that 'variant' option, plus product details, and prices are shown:

### Swatch images

Each product sibling appears automatically as a swatch:

### Unique product images

Only product images for that color style are shown:

### Individual products

Each sibling is an individual product. Using custom metafields, Broadcast will connect these products together and auto-generate the swatch images.

Example of individual products in product admin:

---

# How to setup siblings

Outline of steps required to set up the siblings feature

> Feature introduced in Broadcast v3.5

There are five main components to setting up product siblings:

1. Creating individual products. Each product can have variants like sizes.
2. Group the sibling products into a collection.
3. Define two custom metafields to link each product together which will automatically create linked product swatches.
4. Update the metafield information for each product.
5. Add the Siblings block to the Product template in the Theme Editor.

Let's begin with the product setup:

### Individual products

Create individual products that are similar. Begin with the same name for each product to help maintain naming consistency for each sibling:

Once connected as siblings, they will appear with linked swatches:

### Product details

Each product can have its images, inventory, prices, description, and variants like Size:

### Exclude a color variant

A Color variant isn't required as that will be replaced by image swatches and a metafield is used to display the color.

### Collection for siblings

After creating the products, place them all in one collection. The collection does not need to be used for any other purpose. You can also hide it from the storefront view:

### Metafields

The next step is to create two product metafields which are used to connect all the products and information together:

[Siblings metafields](/siblings/product-siblings/siblings-metafields)

---

# Siblings metafields

> Feature introduced in Broadcast v3.5

There are two product metafields definitions required to connect each of the products together and generate linked swatches.

Use the **Metafields and metaobjects** editor under **Settings** in the **Shopify Admin**:

Both metafields will be defined under the category of Products:

Next, create these two metafields:

See: https://broadcast.presidiocreative.com/siblings/product-siblings/siblings-color

See: https://broadcast.presidiocreative.com/siblings/product-siblings/siblings-collection

---

# Siblings color

Metafield editor

> Feature introduced in Broadcast 3.5

The first required metafield is **`theme.sibling_color`**. 

```
theme.sibling_color
```

For the content type, select 'Single line text' and choose the 'One value' option.

The metafield is also used for the swatch label. This will help with identifying the color version of the current product:

Start by defining a Product metafield. You can name it 'Sibling Color' so that you can more easily find it later.

Adding a description is optional, but be sure to select the correct content type. Choose 'Single line tex&#x74;**'** and set it to 'One valu&#x65;**'**:

### Check the saved metafield

Your final metafield should look like this:

### Next step

We require a second metafield to be defined:

See: https://broadcast.presidiocreative.com/siblings/product-siblings/siblings-collection

---

# Siblings collection

Metafield editor

> Feature introduced in Broadcast 3.5

The second required metafield is **`theme.siblings`** 

```
theme.siblings
```

For the content type, select 'Single line text' and choose the 'One value' option.

This metafield maps each product to the correct collection handle for the siblings.

Start by defining a new Product metafield. You can name it 'Siblings' so that you can more easily find it later.

Adding a description is optional, but be sure to select the correct content type. Choose 'Single line tex&#x74;**'** and set it to 'One valu&#x65;**'**:

**Save** the definition. 

### Check the saved metafield

Your second metafield should look like this:

### Product setup

Next, we will use these newly defined metafields in the Product Setup for each product:

See: https://broadcast.presidiocreative.com/siblings/product-siblings/siblings-product-setup

---

# Siblings product setup

Product admin

> Feature introduced in Broadcast 3.5

After creating the metafields in the previous steps, we complete the setup in the Product Admin. Add the associated information to each of the newly created metafields for each product.

### Siblings color

This value is to identify the swatch (color) and label name of the swatch.

A nice advantage when using Siblings is the ability to create descriptive names for each swatch.

You're not limited to basic color names:

### Siblings collection

This metafield is used to map each product to the correct collection it belongs to. Each group of products should have already been added to a collection.

For example, each product sibling for the product 'Amphora Necklace' belongs to a collection with the handle of `siblings-amphora-necklace`:

### Collection handle

Be sure to obtain the correct collection handle. Start choosing the collection you created:

Next, click on the **Edit** button for the 'Search engine listing' block:

Select and copy the entire handle at the **end** of the URL:

Use this collection handle as the value in your 'Siblings collection' metafield:

### Complete for all products

Update the values for each of the products in your Siblings Collection with:

1. Siblings color
2. Siblings

Once completed, the final step is to add the Siblings block to the Product pages section in the Theme Editor:

See: https://broadcast.presidiocreative.com/siblings/product-siblings/siblings-block

---

# Siblings block

Theme Editor

> Feature introduced in Broadcast 3.5

After creating the metafields and adding values to each of your products, the final step is to add the Siblings block to your Product template under the Product pages section:

**Video demonstration**: How to add and configure the Siblings block in the Theme Editor: 

See: https://www.loom.com/share/16b180b90f2b4e839fca680769de5b7f

---

# Siblings Setup - Troubleshooting Checklist

### Metafields Setup

Ensure the metafields use the mandatory **namespace and key** we’ve shown in the setup:

* <mark style="color:$warning;">theme.siblings</mark> - mandatory - links sibling products
* <mark style="color:$warning;">theme.sibling\_color</mark> - required to display correct color within the swatch, otherwise the sibling swatches default to gray

***

⚠ Any metafield **namespace and key** different from <mark style="color:$warning;">theme.siblings</mark> or <mark style="color:$warning;">theme.sibling\_color</mark> will **not** work. 

The namespace and key is greyed out at first so you will need to click on it in order to be able to edit it:

***

***

### Product Status

\- All sibling products must be **active**, make sure they are **not** set to draft.\
\- All sibling products must be **published** on the **Online Store** sales channel.

***

### Siblings Block Assignment

\- **The siblings metafields** must be connected to the **siblings block** in the product template.\
\- If you have multiple product templates, then ensure that **each template** has the siblings block and correct metafields applied, as custom templates have their own individual setup.

***

### Correct Collection Handle

\- Each sibling product must have the **same collection handle** applied in its <mark style="color:$warning;">theme.siblings</mark> metafield.

***

### Color Display

\- If color swatches default to a gray color, then ensure <mark style="color:$warning;">theme.sibling\_color</mark> is filled for **every** sibling product with your custom color.

***

### Collection Status

\- The collection containing your sibling products must be **published** on the **Online Store** sales channel.\
Without this, the theme cannot find the data and siblings will not display.

***

### Storefront API Access

\- Ensure the metafield has "**Storefront API access**" enabled, otherwise the metafield data cannot be read. This option can be found on the page where you create your metafield, or if you have already created it, click on the metafield and scroll to the very bottom.

<br>
