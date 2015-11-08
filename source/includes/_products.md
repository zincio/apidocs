# Products

## Get product details

> Example product details request

```shell
curl https://api.zinc.io/v1/products/0923568964?retailer=amazon \
  -u client_token:
```

### Product detail attributes

Attribute | Type | Description
--------- | ---- | -----------
cleaned_product_description | String | The description of the product
product_description | String | Description of the product
product_details | Array | TODO
title | String | Title of the product
variant_specifics | Array | TODO
product_id | String | The retailer's unique identifier for the product

## Get product offers

> Example product offers request

```shell
curl https://api.zinc.io/v1/products/0923568964/offers/retailer=amazon \
  -u client_token:
```

### Product offers attributes
Attribute | Type | Description
--------- | ---- | -----------
offers | Array | TODO
