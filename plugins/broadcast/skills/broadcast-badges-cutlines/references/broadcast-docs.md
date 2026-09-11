# Product badges

Add custom product badges or sometimes known as stickers to individual products

Custom product badges in Broadcast allow you to create any type of badge or sticker for each of your products.

### Badge colors

Use the theme settings to modify the background and foreground colors for Sale badges and Custom product badges:

### How to create custom badges

Custom badges are easy to create and are all done in your Product setup. You simply add a tag to any of your products with a custom prefix.

When Broadcast sees the custom tag, it sticks the badge right onto the product in any grid view, like collections, searches, recommendations, and more.

### Creating custom tags

When Broadcast sees a product that has a tag beginning with `_badge_`It will take the following portion and apply it as the custom badge.

Example: `_badge_Black_Friday` or `_badge_Black Friday`

Displayed as:

---

# Product badges with metafields

Add custom product badges to individual products easily using metafields

Feature introduced in Broadcast 3.2

Broadcast makes adding custom individual product badges or also known as stickers, very easy to implement and manage by using metafields.

When utilizing metafields, you simply create one metafield to activate the functionality. From there, you can add badge text to any of your products, and Broadcast will automatically generate a custom badge for that product on collection pages or any section using a product grid.

## How to set up

If your shop is using Broadcast v3.2 or higher, you can easily use this feature. The following quick video shows you how to set up the custom metafield and how to use it with products:

See: https://www.loom.com/share/38baabf35d8943edb141dd821f5a514a

## Reference

You can use the following reference information to help with the steps covered in the video.

### Metafield definition

Create a product metafield with the namespace and key set to:

`theme.badge`

Set the content type to Single line text, with one value:

### Product setup

In the Metafields section of any product that you'd like to use the feature on. Add a value to the badge field.

This will become your custom badge when displayed in a collection or section that includes a product grid:

### Result

When viewing a collection page or section with a product grid-style list, the custom badge is added to the top left corner if the product exists in that listing:

Each product can have its own custom badge label.

## Badge colors

Colors are managed in the Theme settings tab under '[Badges](/theme-settings/theme-settings/badges)'.

Choose the background color and text color to set for all badges. Sale badges have their own values to help differentiate them from other badges:

### Brand colors

The data-source option for badge colors allows you to choose colors you've already configured in your brand colors configuration:

Brand colors are configured and managed in the **Shopify admin settings ->  General -> Brand**:

### Learn more about managing your brand settings:

See: https://help.shopify.com/en/manual/promoting-marketing/managing-brand-assets

---

# Cutline second line

Add a second line of unique text on collection pages

> Feature introduced in Broadcast v3.2.0

Add a custom tagline to individual products using metafields. The tagline will appear styled in the product grid on collection pages and any section using a product grid view:

## How to set up

The first step is to add or define a new product metafield. This is a custom metafield you'll create in the Settings of your Shopify Admin.

### Add a new product metafield

To set up a Cutline, you need to create a new custom metafield definition that Broadcast can recognize.

The most important part is to use this namespace and key: `theme.cutline`

### How to create the metafield

To start, navigate to your Shopify admin settings and open the **Metafields and metaobjects** tab from the left panel. Next, click on 'Products' *(click images to zoom)*:

<div> </div>

Click the 'Add definition' button to begin. Choose a name, we'll use '`cutline`'. Next, we'll use a custom namespace.

A crucial step here is to change the default namespace (usually called '*custom*') to **`theme`.**

Add a description *(optional),* then select 'Single line text' as the content type.

### Product setup

Now that our custom metafield has been defined, the final step is to edit any of your products in the Shopify Admin > Products and update the new `cutline` metafield.

All you need to do is scroll to the bottom of the product setup page and fill them in:

After adding the cutline metafield value, don't forget to save the product changes.

Now you're ready to preview the cutline text. View on a collection page or any section that uses the product grid layout:

Your cutline text will only appear for this product. You can now add unique cutline text to any product in your store.

If a product does not have the cutline metafield text information added, nothing will appear.

Only products with a value for the cutline metafield will display that information on the product grid or collection page.

---

# Final Sale

Display a final sale message with details on all sale items or select products

Broadcast includes a Final sale message feature, which allows shoppers to easily identify products on final sale and view details about the sale. 

The message can be triggered to appear on all sale items or individual products only. 

***

### All products

To display the Final Sale message on **all** your products that are **on sale**, Broadcast has a global setting. 

Use the **Theme settings** -> **Product form** -> **Final sale** to toggle the feature for **all sale items** and also configure the details displayed on hover:

* When this toggle is checked, all sale items will display the 'Final sale' message and details on hover.

***

### Individual products

Broadcast can display the final sale message only on certain products if desired.  Broadcast uses a custom metafield that can be added to individual products. Each product in your store can be individually toggled to display the final sale message. 

#### How to video

This short video demonstrates creating a required custom metafield to display the final sale message on only individual items:

See: https://www.loom.com/share/2101b58fc56d4093a8032c5779b223bf?sid=46dec141-6703-4062-b69a-b3852392b056

#### Required custom metafield

| Metafield details |                                                    |             |
| ----------------- | -------------------------------------------------- | ----------- |
| Metafield type    | Product                                            |             |
| Name              | Final Sale                                         |             |
| Namespace and key | <mark style="color:red;">`theme.final_sale`</mark> | (important) |
| Description       | Final Sale                                         |             |
| Type              | **True or false**                                  |             |

#### Product setup

* Configure any of your products using the new True or False toggle under the Metafields section.

#### Theme Customizer

* In the Theme Customizer, disable the global toggle to display the Final Sale message on all sale items. By turning this off, only individual products from the metafield settings will display the custom message. 

***

### Customize language

The theme will default the main message to '**Final sale**'. You can change the text by modifying the default theme content. 

In the Theme Customizer, click on the **ellipsis icon** on top and choose '**Edit default theme content**':

In the editor, type in '**final sale**' in the search box to find the correct entry to modify:

To manually find the text snippet, use the **Products tab** and under the **Product** section, find **Final sale**
