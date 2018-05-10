# Product details

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
    "question_count": 26,
    "stars": 4.5,
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
price | Number | (Amazon only) The price in cents of the buy box price of the item
review_count | Number | (Amazon only) The number of reviews of the product
stars | Double | (Amazon only) The review score of the product
question_count | Number | (Amazon only) The number of questions on the Amazon question section
asin | String | (Amazon only) The ASIN of the product
item_number | String | (Costco only) The Costco item number of the product (may not contain variant details)

# Product prices

> Example product offers request

```shell
curl https://api.zinc.io/v1/products/0923568964/offers?retailer=amazon \
  -u <client_token>:
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

> Example product offers response

```shell
{
  "retailer": "amazon",
  "status": "completed",
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
      "seller_percent_positive": 100
    }
  ]
}
```

### Response attributes

Attribute | Type | Description
--------- | ---- | -----------
status | String | Possible values are `processing`, `failed`, or `completed`. You will only see `processing` if `async: true` was set on the request.
retailer | String | The retailer for the product offers
offers | Array | An array of [product offer objects](#product-offer-object) for a particular product on a retailer

# Product search

> Example product search request

```shell
curl https://api.zinc.io/v1/search?query=fish%20oil&page=1&retailer=amazon \
  -u <client_token>:
```

Get search results from Amazon based on a query term, including ASIN, title, image url, number of reviews, star rating, and price.

To retrieve product offers and prices, make a GET request to the following URL, replacing :query with a url-encoded query string and specifying the request attributes as query parameters in the URL.

`https://api.zinc.io/v1/search?query=:query&page=1&retailer=amazon`

### Required request attributes

Attribute | Type | Description
--------- | ---- | -----------
query | String | The query string you want to search for. Must be URL encoded.
page | Number | The page number of the results page (starts at 1)
retailer | String | The retailer you are searching on. Currently, only amazon is supported.

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
results.product_id | String | The ASIN of a search result
results.title | String | The title of a search result
results.image | String | A link to an image of the search result
results.num_reviews | Number | The number of reviews the product has
results.stars | String | The star rating of the item (e.g. '4.1 out of 5 stars')
results.fresh | Bool | Whether or not the product is an Amazon Fresh item
results.price | Number | The price of the item
