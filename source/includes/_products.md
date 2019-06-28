# Product Data

Zinc can get product details, product offers and search supported retailers. In general, these calls are tuned for throughput rather than latency. If you need responses quickly, we have [realtime versions](#realtime-product-data) of each call. Also, proper use of the optional `max_age` or `newer_than` query parameters will improve response times.

## Product Details

> Example product details request

```shell
curl https://api.zinc.io/v1/products/0923568964?retailer=amazon \
  -u <client_token>:
```

Get up to date information on the title, description, manufacturer details, item specifics, and more for any product on our supported retailers.

To retrieve product details, make a GET request to the following URL, replacing `<product_id>` with the retailer's unique identifier for a particular product and specifying the request attributes as query parameters in the URL.

`https://api.zinc.io/v1/products/<product_id>?retailer=<retailer_name>`

### Required request attributes

Attribute | Type | Description
--------- | ---- | -----------
retailer | String | The retailer for the product

#### Optional request attributes

Attribute | Type | Description
--------- | ---- | -----------
max_age | Number | A number in seconds setting the maximum age of the response. The data returned in the response will be at most this many seconds old. Cannot specify with `newer_than`.
newer_than | Number | A timestamp setting the minimum time the response should be retrieved from. The data returned in the response will be newer this timestamp. Cannot specify with `max_age`.
async | Boolean | Determines whether the resulting response will be asynchronous. If set to `true`, then the API will not block waiting for a result. Instead, it will immediately return `status: "processing"` and you will be responsible for resending the request until the response is no longer `status: "processing"`. Defaults to `false`.

> Example product details response

```shell
{
    "status": "completed",
    "original_retail_price": 899,
    "timestamp": 1515775557,
    "all_variants": [
        {
            "variant_specifics": [
                {
                    "dimension": "Size",
                    "value": "2"
                }
            ],
            "product_id": "B00Q3H18EQ"
        },
        {
            "variant_specifics": [
                {
                    "dimension": "Size",
                    "value": "1"
                }
            ],
            "product_id": "B00KFP6NHO"
        }
    ],
    "retailer": "amazon",
    "feature_bullets": [
        "Includes four freeze-and-feed popsicle molds with handles shaped perfectly for little hands",
        "Perfect for fresh homemade puree popsicles - turn fresh fruit/veggie puree or juice into 1 fl. oz popsicles",
        "Wide popsicle-holder base catches drips as the popsicle melts to reduce the risk of messes",
        "Great for teething babies to help soothe sore gums",
        "6 Months + / BPA Free"
    ],
    "variant_specifics": [
        {
            "dimension": "Size",
            "value": "1"
        }
    ],
    "main_image": "https://images-na.ssl-images-amazon.com/images/I/61K0YbuLi-L.jpg",
    "images": [
        "https://images-na.ssl-images-amazon.com/images/I/61K0YbuLi-L.jpg",
        "https://images-na.ssl-images-amazon.com/images/I/81KtOn8ddTL.jpg",
        "https://images-na.ssl-images-amazon.com/images/I/71%2BruDKMSoL.jpg",
        "https://images-na.ssl-images-amazon.com/images/I/91AE6dpp5EL.jpg",
        "https://images-na.ssl-images-amazon.com/images/I/61FQEQJR2HL.jpg",
        "https://images-na.ssl-images-amazon.com/images/I/511agWyBf3L.jpg",
        "https://images-na.ssl-images-amazon.com/images/I/31cC6K6y%2ByL.jpg",
        "https://images-na.ssl-images-amazon.com/images/I/31ocdUye0ML.jpg"
    ],
    "package_dimensions": {
        "weight": {
            "amount": 8.5,
            "unit": "ounces"
        },
        "size": {
            "width": {
                "amount": 4,
                "unit": "inches"
            },
            "depth": {
                "amount": 5.8,
                "unit": "inches"
            },
            "length": {
                "amount": 5.8,
                "unit": "inches"
            }
        }
    },
    "epids": [
        {
            "type": "MPN",
            "value": "5438"
        },
        {
            "type": "UPC",
            "value": "048526054381"
        },
        {
            "type": "EAN",
            "value": "0048526054381"
        }
    ],
    "product_id": "B00KFP6NHO",
    "asin": "B00KFP6NHO",
    "ship_price": 0,
    "categories": [
        "Home & Kitchen",
        "Kitchen & Dining",
        "Kitchen Utensils & Gadgets",
        "Specialty Tools & Gadgets",
        "Ice Pop Molds"
    ],
    "review_count": 829,
    "epids_map": {
        "MPN": "5438",
        "UPC": "048526054381",
        "EAN": "0048526054381"
    },
    "title": "Nuby Garden Fresh Fruitsicle Frozen Pop Tray",
    "brand": "Nuby",
    "product_description": "Size:1  Nuby's Garden Fresh Fruitsicle Frozen Popsicle Tray\nis specially designed for making fresh puree popsicles at home. Nuby’s\nFruitsicles are the perfect size for baby’s small hands and are designed to\ncatch drips as the pop melts. Fruitsicles are perfect for teething babies with\nsore gums. This set includes four fruitsicle handles and a tray to mold the\npops while keeping them in place while in your freezer. To use: fill\ncompartments with fresh puree, breast milk, or juice. Snap handles into mold\nand freeze until solid. BPA Free. By Nuby",
    "product_details": [
        "Product Dimensions: 5.8 x 5.8 x 4 inches ; 7.8 ounces",
        "Shipping Weight: 8.5 ounces",
        "Domestic Shipping: Item can be shipped within U.S.",
        "UPC: 048526054381 013513034066",
        "Item model number: 5438"
    ],
    "question_count": 44,
    "stars": 4.4,
    "fresh": false,
    "pantry": false,
    "handmade": false,
    "digital": false,
    "buyapi_hint": true,
    "price": 799
}
```

### Response attributes

Attribute | Type | Description
--------- | ---- | -----------
status | String | Possible values are `processing`, `failed`, or `completed`. You will only see `processing` if `async: true` was set on the request
retailer | String | The retailer for the product
product_id | String | The retailer's unique identifier for the product
timestamp | String | The timestamp that the resource was accessed
title | String | Title of the product
product_details | Array | An array of strings providing details about the product
feature_bullets | String | An array of strings providing highlights of the product
brand | String | The brand of the product (if available)
main_image | String | The URL of the primary image associated with the product
images | Array | An array of image URLs associated with the product
variant_specifics | Array | Array of objects containing information about the types and values of a particular product variant. A variant specifics object contains a `dimension` field describing the type of the variant (e.g. "Color") and a `value` field describing the specific value available. At the top level, this contains information on the selected variant
all_variants | Array | An array of variant_specifics objects detailing all variants of the product as well as their product IDs
categories | Array | Array of different categories that the product belongs in
authors | Array | Array of author names (only available for products that are books)
product_description | String | The description of the product
epids | Array | Array of objects containing external product identifier (epid) objects. An epid object contains a `type` field describing the name of the external product identifier and a `value` field for the identifier's value
epids_map | Array | An array of the epids with the epid type as the the field and the epid value as the value
package_dimensions | Array | An array detailing the packaging details if available. Each dimension contains a 'amount' and 'unit'
item_location | String | (AliExpress only) The originating location of the product
original_retail_price | Number | (Amazon only) The "List Price" in cents of the product (present if the retailer is presenting a crossed out list price)
price | Number | (Amazon only) The price in cents of the buy box price of the item. <br>**This is not always returned and is often not the cheapest option. If you want a product's price you should use [product offers](https://zinc.io/#product-prices).**
review_count | Number | (Amazon only) The number of reviews of the product
stars | Double | (Amazon only) The review score of the product
question_count | Number | (Amazon only) The number of questions on the Amazon question section
asin | String | (Amazon only) The ASIN of the product
fresh | Boolean | (Amazon only) True if the item is an Amazon Fresh item
pantry | Boolean | (Amazon only) True if the item is an Amazon Pantry item
handmade | Boolean | (Amazon only) True if the item is an Amazon Handmade item
digital | Boolean | (Amazon only) True if the item is a digital-only item (software subscription, downloadable software, digital video, game codes, etc.)
buyapi_hint | Boolean | (Amazon only) False if the item cannot be ordered via the buyapi, True if it might be orderable
item_number | String | (Costco only) The Costco item number of the product (may not contain variant details)

## Product Offers

> Example product offers request

```shell
curl https://api.zinc.io/v1/products/0923568964/offers?retailer=amazon \
  -u <client_token>:
```

> Example product offers response

```shell
{
  "status": "completed",
  "asin": "B007JR5304",
  "offers": [
    {
      "seller": {
        "num_ratings": null,
        "percent_positive": null,
        "first_party": false,
        "name": "Amazon Warehouse",
        "id": "A2L77EE7U53NWQ"
      },
      "marketplace_fulfilled": true,
      "international": false,
      "offer_id": "eMLzuculxk",
      "available": true,
      "handling_days": {
        "max": 0,
        "min": 0
      },
      "price": 928,
      "prime_only": false,
      "condition": "Used - Very Good",
      "addon": false,
      "shipping_options": [
        {
          "price": 0,
          "delivery_days": {
            "max": 4,
            "min": 4
          },
          "name": "one-day"
        }
      ],
      "minimum_quantity": null,
    }
  ],
  "timestamp": 1543523165,
  "retailer": "amazon"
}
```

Get information about all the offers for a particular product, including seller name, item price, shipping price, condition, seller reputation, and more.

To retrieve product offers and prices, make a GET request to the following URL, replacing `:product_id` with the retailer's unique identifier for a particular product and specifying the request attributes as query parameters in the URL.

`https://api.zinc.io/v1/products/:product_id/offers`

### Required request attributes

Attribute | Type | Description
--------- | ---- | -----------
retailer | String | The retailer for the product

### Optional request attributes

Attribute | Type | Description
--------- | ---- | -----------
max_age | Number | A number in seconds setting the maximum age of the response. The data returned in the response will be at most this many seconds old. Cannot specify with `newer_than`.
newer_than | Number | A timestamp setting the minimum time the response should be retrieved from. The data returned in the response will be newer this timestamp. Cannot specify with `max_age`.
async | Boolean | Determines whether the resulting response will be asynchronous. If set to `true`, then the API will not block waiting for a result. Instead, it will immediately return `status: "processing"` and you will be responsible for resending the request until the response is no longer `status: "processing"`. Defaults to `false`.

### Response attributes

Attribute | Type | Description
--------- | ---- | -----------
status | String | Possible values are `processing`, `failed`, or `completed`. You will only see `processing` if `async: true` was set on the request.
retailer | String | The retailer for the product offers
offers | Array | An array of [product offer objects](#product-offer-object) for a particular product on a retailer

## Product Search

> Example product search request

```shell
curl https://api.zinc.io/v1/search?query=fish%20oil&page=1&retailer=amazon \
  -u <client_token>:
```

Get search results from a retailer based on a query term. Results include product id, title, image url, number of reviews, star rating, and price.

To retrieve search results, make a GET request to the following URL, replacing :query with a url-encoded query string and specifying the request attributes as query parameters in the URL.

`https://api.zinc.io/v1/search?query=:query&page=1&retailer=:retailer`

### Required request attributes

Attribute | Type | Description
--------- | ---- | -----------
query | String | The query string you want to search for. Must be URL encoded.
page | Number | The page number of the results page (starts at 1)
retailer | String | The retailer you are searching on.

> Example product offers response

```shell
{
  "status": "completed",
  "timestamp": 1522268852,
  "retailer": "amazon",
  "results": [
    {
      "product_id": "B000NPYY04",
      "title": "Nature's Bounty Fish Oil, 1200 mg Omega-3, 200 Rapid Release Softgels, Dietary Supplement for Supporting Cardiovascular Health(1)",
      "image": "https://images-na.ssl-images-amazon.com/images/I/51KGjV22PWL._AC_US218_.jpg",
      "num_reviews": 395,
      "stars": "4.5 out of 5 stars",
      "fresh": false,
      "price": 1248
    },
    {
      "product_id": "B004U3Y9FU",
      "title": "Nature Made Burpless Fish Oil 1000 mg w. Omega-3 300 mg Softgels 150 Ct",
      "image": "https://images-na.ssl-images-amazon.com/images/I/516F1UWawAL._AC_US218_.jpg",
      "num_reviews": 0,
      "stars": "4.4 out of 5 stars",
      "fresh": false,
      "price": 1299
    },
    {
      "product_id": "B002VLZHLS",
      "title": "Kirkland Signature Fish Oil Concentrate with Omega-3 Fatty Acids, 400 Softgels, 1000mg",
      "image": "https://images-na.ssl-images-amazon.com/images/I/41bpqnspd1L._AC_US218_.jpg",
      "num_reviews": 0,
      "stars": "4.6 out of 5 stars",
      "fresh": false,
      "price": 1642
    }
  ]
}
```

### Response attributes

Attribute | Type | Description
--------- | ---- | -----------
status | String | Possible values are `processing`, `failed`, or `completed`. You will only see `processing` if `async: true` was set on the request.
retailer | String | The retailer for the search results
results | Array | An array of results for a particular query on a retailer
results.product_id | String | The product id of a search result
results.title | String | The title of a search result
results.image | String | A link to an image of the search result
results.num_reviews | Number | The number of reviews the product has
results.stars | String | The star rating of the item (e.g. '4.1 out of 5 stars')
results.fresh | Bool | Whether or not the product is an Amazon Fresh item
results.price | Number | The price of the item

# Realtime Product Data

The calls documented above are tuned for throughput rather than latency, and for most use cases they work well. There are some use cases (for example, catalog expansion) that have strict latency requirements. To satisfy those use cases we have developed a realtime version of our data APIs. To ensure we meet our latency guarantees, we limit access to the realtime api. To get access to our realtime API, contact <sales@zinc.io>.

## Realtime Search

> Example realtime search request

```shell
curl'https://api.zinc.io/v1/realtime/search?query=vitamin&retailer=amazon' \
-u <client_token>:
```

> Example realtime search response

```shell
{
  "status": "completed",
  "timestamp": 1537653337,
  "nextPage": "https://api.zinc.io/v1/realtime/search?nextToken=eyJzZWVuIjpbMjY4NDM1NDU2LDAsMTA0ODU3NiwwLDAsNDIxMDY4OCwwLDAsMTYzODQsMCwwLDAsMTMxMDcyLDAsMjU2LDAsMzI3NjgsMjU2LDAsNDA5NiwxMDQ4NTc2LDAsMCwyMzA0LDQsMjA2MDgsMjY4NDM1NDU2LDAsMCwwLC0yMTQ3NDgzNjQ4LDAsMCwwLDY3MTE3MDU2LDAsMTMxMDcyLDUzNjg3MDkxMiwwLDAsMCwyNTYsMCw1MTIwLDAsNTI0MjkyLDAsMzI3NjgsNjU1MzYsMCwxNiwwLDIwODAsMCwwLDAsMCw2NTUzNiwwLDEwNTYsMCwxMDI0LDAsMCwxNjc3NzIxNiwwLDAsMCwwLDI2ODQzNTQ1Niw1NzYsODE5Miw2NCwxMDczNzQxODI0LDEwNDg1NzYsMCwwLDQsMCwxMDQ4NTc2LDI3MiwwLDI4NTIxMjY3MiwwLDAsMCwwLDAsMCwwLDAsMTY3NzcyMTYsMCwwLC0yMTQ3NDgyNjI0LDI2NDE5MiwwLDAsMCw0MDk2LDAsMCw1MTIsMCwwLDAsMCwwLDIzMDQsMjYyMTQ0LDAsMCwyNjg0MzU0NTYsMCwxLDAsMCw2NTUzNywwLDUyOCwwLDAsMCwtMjE0NzQ2NzI2NCwwLDE2Mzg0LDAsMF0sInBhZ2UiOjIsImNvdW50cnkiOiJ1cyIsInF1ZXJ5Ijoidml0YW1pbiJ9",
  "nextToken": "eyJzZWVuIjpbMjY4NDM1NDU2LDAsMTA0ODU3NiwwLDAsNDIxMDY4OCwwLDAsMTYzODQsMCwwLDAsMTMxMDcyLDAsMjU2LDAsMzI3NjgsMjU2LDAsNDA5NiwxMDQ4NTc2LDAsMCwyMzA0LDQsMjA2MDgsMjY4NDM1NDU2LDAsMCwwLC0yMTQ3NDgzNjQ4LDAsMCwwLDY3MTE3MDU2LDAsMTMxMDcyLDUzNjg3MDkxMiwwLDAsMCwyNTYsMCw1MTIwLDAsNTI0MjkyLDAsMzI3NjgsNjU1MzYsMCwxNiwwLDIwODAsMCwwLDAsMCw2NTUzNiwwLDEwNTYsMCwxMDI0LDAsMCwxNjc3NzIxNiwwLDAsMCwwLDI2ODQzNTQ1Niw1NzYsODE5Miw2NCwxMDczNzQxODI0LDEwNDg1NzYsMCwwLDQsMCwxMDQ4NTc2LDI3MiwwLDI4NTIxMjY3MiwwLDAsMCwwLDAsMCwwLDAsMTY3NzcyMTYsMCwwLC0yMTQ3NDgyNjI0LDI2NDE5MiwwLDAsMCw0MDk2LDAsMCw1MTIsMCwwLDAsMCwwLDIzMDQsMjYyMTQ0LDAsMCwyNjg0MzU0NTYsMCwxLDAsMCw2NTUzNywwLDUyOCwwLDAsMCwtMjE0NzQ2NzI2NCwwLDE2Mzg0LDAsMF0sInBhZ2UiOjIsImNvdW50cnkiOiJ1cyIsInF1ZXJ5Ijoidml0YW1pbiJ9",
  "retailer": "amazon",
  "results": [
    {
      "product_id": "B00K2RJAR0",
      "title": "OPTIMUM NUTRITION Opti-Men, Mens Daily Multivitamin Supplement with Vitamins C, D, E, B12, 150 Count",
      "price": 2278,
      "image": "https://images-na.ssl-images-amazon.com/images/I/41raAjeCEwL._AC_US218_.jpg",
      "brand": "Optimum Nutrition",
      "prime": true,
      "product_details": []
    },
    {
      "product_id": "B007L0DPE0",
      "title": "Vitafusion Women's Gummy Vitamins, 150 Count (Packaging May Vary)",
      "price": 979,
      "image": "https://images-na.ssl-images-amazon.com/images/I/51eGHGb0zqL._AC_US218_.jpg",
      "brand": "Vitafusion",
      "prime": true,
      "product_details": []
    },
    {
      "product_id": "B002H0KZ9M",
      "title": "Vitafusion Multi-vite, Gummy Vitamins For Adults, 150 Count (Packaging May Vary)",
      "price": 979,
      "image": "https://images-na.ssl-images-amazon.com/images/I/515YezxBrlL._AC_US218_.jpg",
      "brand": "Vitafusion",
      "prime": true,
      "product_details": []
    },
    {
      "product_id": "B003G4BP5G",
      "title": "Centrum Adult (200 Count) Multivitamin / Multimineral Supplement Tablet, Vitamin D3",
      "price": 949,
      "image": "https://images-na.ssl-images-amazon.com/images/I/41IpifEYOpL._AC_US218_.jpg",
      "brand": "Centrum",
      "prime": false,
      "product_details": []
    },
    {
      "product_id": "B00GB85JR4",
      "title": "NatureWise Vitamin D3 5,000 IU for Healthy Muscle Function, Bone Health and Immune Support, Non-GMO in Cold-Pressed Organic Olive Oil,Gluten-Free, 1-year supply, 360 count",
      "price": 1105,
      "image": "https://images-na.ssl-images-amazon.com/images/I/61X2dIACG9L._AC_US218_.jpg",
      "brand": "NatureWise",
      "prime": true,
      "product_details": []
    },
    {
      "product_id": "B00WR6JGD2",
      "title": "Dr. Tobias Multivitamin for Women and for Men - Enhanced Bioavailability - With Whole Food & Herbal Ingredients, Minerals and Enzymes - Rich in Vitamin B & C - Womens And Mens Daily Vitamins - Non-GMO",
      "price": 2277,
      "image": "https://images-na.ssl-images-amazon.com/images/I/61GaW6R4iuL._AC_US218_.jpg",
      "brand": "Dr. Tobias",
      "prime": true,
      "product_details": []
    },
    {
      "product_id": "B007L0DONW",
      "title": "Vitafusion Men's Gummy Vitamins, 150 Count (Packaging May Vary)",
      "price": 1174,
      "image": "https://images-na.ssl-images-amazon.com/images/I/519q4FPn5eL._AC_US218_.jpg",
      "brand": "Vitafusion",
      "prime": false,
      "product_details": []
    },
    {
      "product_id": "B071ZH84QG",
      "title": "Centrum Men (250 Count) Multivitamin / Multimineral Supplement Tablet, Vitamin D3",
      "price": 1977,
      "image": "https://images-na.ssl-images-amazon.com/images/I/51MR+UHdh8L._AC_US218_.jpg",
      "brand": "Centrum",
      "prime": true,
      "product_details": []
    },
    {
      "product_id": "B0771X1HTZ",
      "title": "One A Day Men's Health Formula Multivitamin, 250 Count",
      "price": 1424,
      "image": "https://images-na.ssl-images-amazon.com/images/I/41-X+7wZ1DL._AC_US218_.jpg",
      "brand": "ONE A DAY",
      "prime": true,
      "product_details": []
    },
    {
      "product_id": "B01KE592JU",
      "title": "Men's Daily Multimineral/Multivitamin Supplement - Vitamins A C E D B1 B2 B3 B5 B6 B12. Magnesium, Biotin, Spirulina, Zinc. Antioxidant For Heart & Immune Health. 60 Daily Gluten Free Multivitamins.",
      "price": 1897,
      "image": "https://images-na.ssl-images-amazon.com/images/I/51T72DkubeL._AC_US218_.jpg",
      "brand": "Vimerson Health",
      "prime": true,
      "product_details": []
    }
  ]
}
```

Expand your product catalog with realtime results from Amazon based on a query term. Results include product id, title, image url, and price.


To retrieve search results, make a GET request to the following URL, replacing `<query>` with a url-encoded query string and specifying the request attributes as query parameters in the URL.

`https://api.zinc.io/v1/realtime/search?query=<query>&retailer=<retailer_name>&nextToken=<token>`

The first page should always return within 4 seconds and will contain 10 results. If you want to show more than 10 results, you should use AJAX to load additional pages for the best user experience. A demo of this can be found at <http://amazonsearchdemo.surge.sh/> ([source code](https://github.com/zincio/zinc-realtime-search-demo)). Note that you must contact <sales@zinc.io> first so we can enable this feature for you.

### Required request attributes

Attribute | Type | Description
--------- | ---- | -----------
query | String | The query string you want to search for. Must be URL encoded.
retailer | String | The retailer you are searching on. Currently, only amazon is supported.
nextToken | Number | Not included for the initial request. For subsequent requests, provide the token returned by previous request.

#### Optional request attributes
Attribute | Type | Description
--------- | ---- | -----------
includeAddons | Boolean | If `false` addons will not be returned in search results.

### Response attributes

Attribute | Type | Description
--------- | ---- | -----------
status | String | Possible values are `failed`, or `completed`.
retailer | String | The retailer for the search results
results | Array | An array of results for a particular query on a retailer
results.product_id | String | The ASIN of a search result
results.title | String | The title of a search result
results.image | String | A link to an image of the search result
results.price | Number | The price of the item.
results.product_details | Number | Additional data about product if any was found.
results.addon | Boolean | Will be true if the best offer (aka BuyBox) is an addon. Rarely, this field will not be returned which simply means we were unable to determine addon status in timely manner.
## Realtime Details

> Example realtime details request

```shell
curl https://api.zinc.io/v1/realtime/details/0923568964?retailer=amazon \
  -u <client_token>:
```

To retrieve product details, make a GET request to the following URL, replacing `<product_id>` with the retailer's unique identifier for a particular product.

`https://api.zinc.io/v1/realtime/details/<product_id>?retailer=<retailer_name>`

Using the realtime details call is identical to our [normal details call](#product-details) with the exception that `max_age` is ignored.

If a realtime details call hits our cache, the call does not count against your real-time rate limit.

## Realtime Offers

> Example realtime offers request

```shell
curl https://api.zinc.io/v1/realtime/offers/B00K4F45CA?retailer=amazon \
  -u <client_token>:
```

To retrieve product offers and prices, make a GET request to the following URL, replacing `:product_id` with the retailer's unique identifier for a particular product.

`https://api.zinc.io/v1/realtime/offers/:product_id?retailer=<retailer_name>`

Usage and returned data is identical to our [normal offers call](#product-prices).
