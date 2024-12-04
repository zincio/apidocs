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
