# Get product details

Get up to date information on the title, description, manufacturer details, item specifics, and more for any product on our supported retailers.

> Example product details request

```shell
curl https://api.zinc.io/v1/products/0923568964?retailer=amazon \
  -u client_token:
```

> Example product details response

```shell
{
  "product_description": "This is a great book!",
  "retailer": "amazon",
  "epids":[
    {
      "type": "EAN",
      "value": "9780923568962"
    },
    {
      "type": "ISBN",
      "value": "0923568964"
    }
  ],
  "product_details": [
    "Series: The Easy Way!",
    "Paperback: 60 pages",
    "Publisher: XanEdu Publishing Inc; 2nd Edition edition (September 28, 2009)",
    "Language: English",
    "ISBN-10: 0923568964",
    "ISBN-13: 978-0923568962",
    "Product Dimensions: 8.3 x 5.3 x 0.2 inches",
    "Shipping Weight: 3.5 ounces"
  ],
  "title": "APA: The Easy Way! [Updated for APA 6th Edition]",
  "variant_specifics": [
    {
      "dimension": "Color",
      "value": "Gray"
    },
    {
      "dimension": "Size",
      "value": "Small/Medium"
    }
  ],
  "product_id": "0923568964"
}
```

### Product detail attributes

Attribute | Type | Description
--------- | ---- | -----------
product_description | String | The description of the product
retailer | String | The retailer for the product
epids | Array | Array of objects containing external product identifier (epid) objects. An epid object contains a `type` field describing the name of the external product identifier and a `value` field for the identifier's value.
product_details | Array | An array of strings providing details about the product
title | String | Title of the product
variant_specifics | Array | Array of objects containing information about the types and values of product variants available. A variant specifics object contains a `dimension` field describing the type of the variant (e.g. "Color") and a `value` field describing the specific value available.
product_id | String | The retailer's unique identifier for the product

# Get product prices

Get information about all the offers for a particular product, including seller name, item price, shipping price, condition, seller reputation, and more.

> Example product offers request

```shell
curl https://api.zinc.io/v1/products/0923568964/offers/retailer=amazon \
  -u client_token:
```

> Example product offers response

```shell
{
  "retailer": "amazon",
  "offers":[
    {
      "addon": false,
      "condition": "New",
      "handling_days_max": 0,
      "handling_days_min": 0,
      "international": false,
      "merchant_id": "ATVPDKIKX0DER",
      "offerlisting_id": "lUai8vEbhC%2F2vYZDwaePlc4baWiHzAy9XJncUR%2FpQ9l4VOrs%2FfpYt4ZtreQaB%2BPL1xJwz5OpIc%2BJjyymHg3iv4YkZvWy5z7flil7n7lUDWNPY76YUhMNdw%3D%3D",
      "price": 9.79,
      "ship_price": 0
      "prime": true,
      "prime_only": false,
      "seller_name": "Amazon.com",
      "seller_num_ratings": 1000000,
      "seller_percent_positive": 100,
    }
  ]
}
```

### Product offers attributes

Attribute | Type | Description
--------- | ---- | -----------
retailer | String | The retailer for the product offers
offers | Array | An array of [product offer objects](#product-offer-object) for a particular product on a retailer
