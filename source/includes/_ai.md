# AI Routes

Zinc provides API endpoints optimized for use with LLM tool-calling and
langchain. Responses from these endpoints are intended to be passed directly to
LLMs or intelligent agents. These endpoints are still under development, and their
exact response formats are subject to change. If you need a consistent response
format, consider the traditional API endpoints. These are optimized for AI.

All of these routes can accept a retailer parameter. If retailer is omitted,
these routes assume `amazon` i.e. Amazon.com US.

## Product Search

> Example AI product search request

```shell
curl https://api.zinc.io/v1/ai/search?query=harry+potter&limit=8 \
  -u <client_token>:
```

Returns a simplified JSON list of search results, with up to `limit` results,
at most one page. If further pages are required, make further calls, providing
the `page` query parameter.


## Product Details

> Example AI product details request

```shell
curl https://api.zinc.io/v1/ai/products/0923568964/details \
  -u <client_token>:
```

Returns the same values as the typical product details endpoint, but with some
irrelevant information omitted to decrease token count, saving money and
context length for other uses.


## Product Variants

> Example AI product variants request

```shell
curl https://api.zinc.io/v1/ai/products/B0CF9G946H/variants \
  -u <client_token>:
```

Returns a list of all variants available for a product with their specific
`product_id` values.


## Product Offers

> Example AI product offers request

```shell
curl https://api.zinc.io/v1/ai/products/0923568964/offers \
  -u <client_token>:
```

Returns the same values as the typical product offers endpoint, but with some
irrelevant information omitted to decrease token count, saving money and
context length for other uses.


## Product Ordering

Unlike some of the other AI routes, this one is a progressive enhancement from our
[traditional ordering flow](/#orders). Most parameters of the standard order have been
made optional, with only `products` and `shipping_address` required. Additionally,
`products` has been modified so that URLs can be supplied instead of product_ids.

Orders will use ZMA (aka `addax`) by default. The default `shipping_method` is `cheapest`.
The default `max_price` is $1,000,000 (i.e. functionally unlimited). The default shipping
phone number (if not provided) is 555-555-5555. Any of these values can be overridden by
providing them as shown in the standard order flow documentation.

Three schemas are permitted for `products`:

1. The list of URLs, where retailer is inferred, and quantity is assumed to be 1
```
{
  "products": ["https://www.amazon.com/dp/B07986PWD3"]
}
```

2. The traditional standard, when retailer is explicitly provided
```
{
  "retailer": "amazon",
  "products": [
    {"product_id": "B07986PWD3", "quantity": 1}
  ]
}
```

3. The list of objects with URLs, where retailer is inferred
```
{
  "products": [
    {"url":"https://www.amazon.com/dp/B07986PWD3", "quantity":3}
  ]
}
```

Note that each order can have any number of products from a single retailer, but cannot
mix products between multiple retailers.

Additionally, for US addresses only, the shipping address can be provided as a free-form
string. This will be parsed, normalized, and canonicalized by a proprietary lite geocoding
implementation. This feature is experimental, and for best results, we recommend either
collecting a structured address directly from your customer, or integrating a true
geocoding solution, like [Google's
geocoder](https://developers.google.com/maps/documentation/geocoding/start) or
[Nominatim](https://nominatim.org/).

> Example AI product ordering request

```shell
curl https://api.zinc.io/v1/orders \
  -u <client_token>: \
  -H content-type:application/json \
  -d '{
    "products": ["https://www.amazon.com/dp/B07986PWD3"],
    "shipping_address": {
      "first_name": "Bob",
      "last_name": "Smith",
      "address_line1": "1234 Main St",
      "city": "New York",
      "state": "NY",
      "zip_code": "10001",
      "country": "us"
    }
  }'
```

The response will either have `"_type": "error"` and a corresponding `code`, `message`,
and `data`, or it will have a `request_id` parameter, which allows the
`/v1/orders/:request_id` endpoint to be polled to determine response status. It can take
between 5 and 15 minutes to process an Amazon order, and up to 6 hours to process orders
on other retailers.
