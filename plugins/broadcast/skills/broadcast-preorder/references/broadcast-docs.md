# Pre-order products using tags

Replace the add-to-cart button with a pre-order button using tags

If you have a product that is not yet ready to be shipped to customers, you can set it up as a pre-order product. Broadcast can replace the add-to-cart button with a pre-order button by using a `_preorder` tag.

### How to use

* From your Shopify admin, choose 'Products'
* Choose the product you want to change into a preorder
* Add the tag `_preorder`
* Save the product

When Broadcast sees a product with this tag, the 'Add to cart' button will automatically be changed to 'Pre-order'.

### Customize the button text

Use the language editor to customize the button text for pre-order.

Search for `pre-order` in the Filter bar:

### Manually capture payment

Pre-orders require that you set up payment options to manually capture payments instead of automatically. 

From your Shopify admin, click Settings (bottom left), and then click Payments:

Scroll down to find the Payment capture section, and choose Manage for Payment capture set to Manual:

Choose Manually capture payment for orders:

Learn more about Capturing payments from Shopify:

See: https://help.shopify.com/en/manual/orders/get-paid

---

# Pre-order using metafields

Replace the add-to-cart button with a pre-order button using metafields

Broadcast supports metafields for creating pre-order products.

When you define a preorder metafield, you can easily toggle on or off the preorder feature which converts the Add to Cart button to a Pre-order button. 

On the main product page, the Add to Cart button is replaced with a Pre-order button:

When viewing a collection page or any product grid-style section, a Pre-order badge is added to the product:

Quick Add button is changed to Pre-Order:

In the cart drawer and cart page, a message is included to indicate that the item is a preorder:

## How to setup

Setting up a preorder metafield is very simple and can be done right in your Shopify Admin.

This video covers all the steps needed for creating a preorder metafield plus additional customization options:

See: https://www.loom.com/share/43958bdd812d43d7843cdc5ae25f83be

## Reference

You can use the following reference information to help with the steps covered in the video.

### Metafield definition

Create a product metafield with the namespace and key set to `theme.preorder` . Set the content type to 'True or false'.

### Product setup

In the Metafields section of any product that you'd like to use the feature, change the preorder value to True:

### Preorder template

To remove the Buy it now button as shown in the video, you can create a preorder product template and uncheck *Show dynamic checkout buttons* inside the Form block:

## Additional information

When selling pre-order products on your store, you may want to manually capture payments:

### Manually capture payments

See: https://broadcast.invisiblethemes.com/products/pre-order-products#manually-capture-payment

You can customize the button text for pre-orders to match your language or simply use different wording:

### Customize the button text

See: https://broadcast.invisiblethemes.com/products/pre-order-products#customize-the-button-text

---

# Pre-order variants with metafields

Replace the add-to-cart button with a pre-order button using metafields at the variant level

> Introducted in Broadcast version 7.1

Let your customers pre-order items at the variant level. Broadcast now lets you configure any product variant to be a pre-order option:

A variant-level metafield is used to trigger a pre-order button on the product page. 

### Variant metafield reference

Create a one-time variant metafield and toggle your product variants to display the pre-order button. 

| Metafield details |                                                      |             |
| ----------------- | ---------------------------------------------------- | ----------- |
| Metafield type    | **Variant**                                          | (important) |
| Name              | Preorder                                             |             |
| Namespace and key | <mark style="color:$danger;">`theme.preorder`</mark> | (important) |
| Description       | Pre-order variants                                   |             |
| Type              | **True or false**                                    |             |

***

### Video walkthrough

Learn how to create and configure the custom variant metafield for pre-orders:

See: https://www.loom.com/share/2db81b9361e64d3fa792b750142e72c3?sid=b511a317-0012-4a98-a770-5c37741e6db6

This video will show how to create the variant metafield, apply it to a product, and view the pre-order feature on a product page and collection list.
