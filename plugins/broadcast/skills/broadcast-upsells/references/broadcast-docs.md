# Upselling with metafields

Promote products on product pages and the cart with custom metafields for precise product matching

### Overview

Broadcast makes it easy to customize upsell products with two custom metafield types:

* Single product: Pair a unique product as an upsell. 
* List of products: Suggest multiple product promotions for any product.

These can be custom-chosen products for each of your products, eliminating the need to use multiple product templates. 

### Cart promotions

A second chance is available to the customer in the Cart drawer. If the customer doesn't use the Product page upsell promotion, they will have another opportunity in the Cart drawer:

### How to use

To use the metafield feature in Broadcast, you'll first need to create a custom metafield. Once the metafield has been created, you can easily customize any of your products to use unique pairings. 

### Create the custom metafield

Create the custom metafield. There are two options: a single product or a list of products. We'll use the product list version in our examples. The product list version is flexible; you can use one or up to three products as upsell promotions. 

### Video Overview

Watch this video to learn how to correctly create the custom required metafield and set up your products:

See: https://www.loom.com/share/eb1b823dbed94e5d96911ec49cbd8e8c?sid=733a6e41-3458-4a0d-b9b1-b381f19b7227

### Key points from the video

Create the custom metafield that's designed for Broadcast:

* Be sure to change the default namespace of "custom" to "`theme`" and the key must be "`upsell_list`"

### Set up the upsell block

Once you've created the metafield, the next step is to choose the metafield in the Theme Customizer's block settings:

### Pair products in the Product setup

Use the Shopify Product Admin to pair your products with those of others. Repeat for other products in your store. 

Each product will automatically generate an upsell promotion on its product page and in the cart. Select one product for a single pairing or up to three products for a list of recommended products. 

## Earlier versions

If you're using an older version of Broadcast that only supports **single product** upsell promotions, the metafield you will need to create is:

`theme.upsell`

This metafield allows you to choose one product pairing. Newer versions of Broadcast can use both metafields, a single product, and a product list.

---

# Upselling with tags

Broadcast includes a 'Goes with' feature to help upsell products on individual product pages

> This article is for **Broadcast v3.0 to v3.3.1 only**. Tags are not supported as of v3.4

With Broadcast, you can suggest a pairing product on any of your Product pages. This allows the customer to purchase two separate products within one product page.

### Two upsell opportunities

> **One** - Broadcast can suggest a product to pair with. The customer can choose the upsell product from the Cart after adding the primary product.

> **Two** - Customer can add the upsell product to the Cart directly from the main product page and also add the primary product to Cart.

## How to:

There are two steps involved with setting up upselling:

### 1. Add the Upsell theme block to the default product template

#### Position the upsell promotion

Use drag-and-drop to position the upsell theme block on your product page:

### 2. Tag your product with a custom upsell tag to pair with another product

To pair a product with another, you simply add a tag to the main product with a custom tag. The tag links to the upsell product or links directly to a variant of the upsell product.

Here's an example of a primary product called 'Ilona Signet Ring in Sterling Silver'. We'll add the custom upsell tag here. This tells Broadcast that when a customer is viewing the 'Ilona Signet Ring in Sterling Silver' product page, a separate product can be suggested as an upsell. The upsell product is the custom tag (Ilona ring in gold):

We simply add a tag called '\_upsell\_ilona-ring-in-gold' to 'Ilona Signet Ring in Sterling Silver', which implies that 'Ilona ring in gold' is the product we want to promote on the 'Ilona Signet Ring in Sterling Silver' page.

## Creating upsell tags

There are three parts to creating your custom upsell tags:

1. The first part of the tag must start with `_upsell_`
2. The second part of the tag must match the product handle of the upsell item
3. The last part is the variant ID. This is only required for products with variants.

Example of a completed tag without variants: `_upsell_ilona-ring-in-gold`

#### Variants

Broadcast can suggest more than just an upsell product. Broadcast can suggest an exact variant of a product to upsell. This can be helpful if you're trying to upsell a certain color or size of the product.

Example of a completed tag for a product that has variants: `_upsell_ilona-ring-in-sterling-silver_40854006726691`

### Finding the product handle

All Shopify products have a unique product handle. You can easily find the product handle in the main Shopify Admin under Products. Choose any product in your Shopify Admin for Products, then simply use the 'Edit' link to view details about that product, including the handle:

### Finding the product variant ID

All Shopify products with variants have a unique ID number associated with the product.

To find the variant ID, browse the product in your Shopify Product Admin, choose the Edit button next to the desired variant, and find the variant ID at the end of your browser URL address:

## Changing the 'Complete the look' heading

The main heading for this block uses a translatable string:

To change this heading you can go into your Online Store -> Edit default theme content:

In the Products tab edit the 'Upsell title' field:

Save the changes and check your Product pages:
