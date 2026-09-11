# Bundle and Save

Promote product bundles on product pages with automatic discounts and precise product matching with metafields

> Introducted in Broadcast version 7.1

### Overview

Use bundles to make upselling more attractive for your customers. Broadcast helps you promote bundles in the product form for the Product Default Page (PDP). Customers can easily add a bundled item to their card with a 'Bundle and Save' promotion:

After adding the bundled items, the cart shows their discounted savings:

Broadcast makes it easy to customize product bundles with two custom metafield types:

* Single product: Bundle a unique product as an upsell for a discount.
* List of products: Suggest multiple products for bundle and save promotions.

These can be custom-chosen products for each of your products, eliminating the need to use multiple product templates. 

***

## How to use

### Step 1 - Create an automatic discount

Bundles are first created in the Shopify Admin under **Discounts**. Here, you can customize the items and savings. Use an **Automatic** discount type that automatically applies the discount when the bundled items are added to the cart.

Here is an example of an automatic discount created for our demo store called "Bundle example":

Once an automatic discount has been created, you can test it by adding the bundled items to the cart on your store. 

The next step is to create the promotions. These are done in two steps:

1. Create a custom metafield for your bundles. This is done once only. After a metafield has been created, Broadcast will display a promotion on your product pages based on the pairing you set up in the next step.
2. Pairing products. This step is done at the product level in the Shopify Admin. Simply, choose which promotion/pairing product(s)  is/are displayed for any of your products. 

### Step 2 - Create a product metafield

This one-time step allows you to customize which product promotions appear on individual product pages. After creating the metafield, you can easily tailor your products to use unique pairings. 

#### Create the custom metafield

Broadcast provides you with two custom metafield options: 

* Single product - Displays a single promotion on the product form. 
* Product list - Can display up to three bundle promotions on the product form. 

### Video walkthrough for all steps

This video covers all the key steps for using the Bundle and Save feature in Broadcast, including how to create the custom metafields:

See: https://www.loom.com/share/ee04a886186d459b98a1d1c5d8f69246?sid=1e21971d-d3c3-4476-9fe7-14d22abe8888

Metafields are easy to create. Here's a quick reference from the video above, and also for experienced users.

### Metafield reference

#### Reference for <mark style="background-color:yellow;">single product</mark> metafield

| Metafield details |                                                |             |
| ----------------- | ---------------------------------------------- | ----------- |
| Metafield type    | Product                                        |             |
| Name              | Bundle                                         |             |
| Namespace and Key | <mark style="color:red;">`theme.bundle`</mark> | (important) |
| Description       | Bundle and save single                         |             |
| Type              | **One product**                                |             |

#### Reference for <mark style="background-color:yellow;">product list</mark> metafield

| Metafield details |                                                     |             |
| ----------------- | --------------------------------------------------- | ----------- |
| Metafield type    | Product                                             |             |
| Name              | Bundle list                                         |             |
| Namespace and Key | <mark style="color:red;">`theme.bundle_list`</mark> | (important) |
| Description       | Bundle List                                         |             |
| Type              | **List of products**                                |             |

> ***Tip***: Both are easy to create. For more flexibility, consider using the product list option, which allows you to display **one** to **three** bundles. 

### Bundle title

The video also shows how to use a custom Bundle title for each promotion. Here's a quick reference for the bundle\_title metafield:

| Metafield details |                       |   |
| ----------------- | --------------------- | - |
| Metafield type    | Product               |   |
| Name              | Bundle title          |   |
| Namespace and key | `custom.bundle_title` |   |
| Description       | Bundle title          |   |
| Type              | **Single line text**  |   |

### Step 3 - Setting up your products

After creating the one-time step for 'Bundle and save' metafields, we can set up products to display custom promotions. This step is covered in the above video as well. 

* In the **Shopify Admin** > **Products**, find a product that is included in your **Automatic Discount** from **Step 1**. 
* Scroll to the bottom of the product page to the Metafields section and add a value to the Bundle or Bundle list metafield. If you've created a Bundle title metafield, add that information as well. 

#### Example

* Watch the video in Step 2 for details on this process. 

### Step 4 - Add the Bundle and Save block to Product pages

The final required step is to add the 'Bundle and save' block to the 'Product pages' section of your Default Product Page (PDP) or sometimes referred to as the 'Default product template', and to configure the block settings. These steps are also covered in the above [video](#video-walkthrough-for-all-steps) from Step 2. 

{% stepper %}
{% step %}

### Add the 'Bundle and save' block

Add the 'Bundle and save' block to the 'Product pages' section under the Template group. 
{% endstep %}

{% step %}

### Connect the Bundle or Bundle list metafield

Add the metafield you created for either a single product or a product list. 

⚠️ The key step here is to ensure the connection is under **Template > Product**. This might default to Current block > Single product. Be sure to make this change. 
{% endstep %}

{% step %}

### Connect the Bundle title metafield 

For custom promotion titles, use a bundle title metafield. 

⚠️ The key step here is to ensure the connection is under **Template > Product**. This might default to Current block > Single product. Be sure to make this change. 
{% endstep %}
{% endstepper %}

***

### Final notes

* Ensure you've created an Automatic Discount that matches the products for each of your bundles. 
* The bundle and bundle\_list metafields have a custom key and namespace; be sure you change these to match the required namespace and key for Broadcast. 
* Watch the [video](#video-walkthrough-for-all-steps) in Step 2 for a complete walkthrough on using the Bundle and Save feature in Broadcast. 

***

## Cart drawer promotion

To display a 'Bundle and save' promotion in the Cart drawer, add the 'Bundle products' block in the **Overlay** group:

* In the Overlay group, under 'Cart drawer', add the 'Bundle products' block. 
* The bundle promotion will be displayed based on the automatic discount, metafield, and product setup covered in previous steps.
