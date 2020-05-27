# Orders

## Create an order

> Example create an order request

```shell
curl "https://api.zinc.io/v1/orders" \
  -u <client_token>: \
  -d '{
  "retailer": "amazon",
  "products": [
    {
      "product_id": "B0016NHH56",
      "quantity": 1
    }
  ],
  "max_price": 2300,
  "shipping_address": {
    "first_name": "Tim",
    "last_name": "Beaver",
    "address_line1": "77 Massachusetts Avenue",
    "address_line2": "",
    "zip_code": "02139",
    "city": "Cambridge",
    "state": "MA",
    "country": "US",
    "phone_number": "5551230101"
  },
  "is_gift": true,
  "gift_message": "Here is your package, Tim! Enjoy!",
  "shipping": {
    "order_by": "price",
    "max_days": 5,
    "max_price": 1000
  },
  "payment_method": {
    "name_on_card": "Ben Bitdiddle",
    "number": "5555555555554444",
    "security_code": "123",
    "expiration_month": 1,
    "expiration_year": 2020,
    "use_gift": false
  },
  "billing_address": {
    "first_name": "William",
    "last_name": "Rogers",
    "address_line1": "84 Massachusetts Ave",
    "address_line2": "",
    "zip_code": "02139",
    "city": "Cambridge",
    "state": "MA",
    "country": "US",
    "phone_number": "5551234567"
  },
  "retailer_credentials": {
    "email": "timbeaver@gmail.com",
    "password": "myRetailerPassword",
    "totp_2fa_key": "3DE4 3ERE 23WE WIKJ GRSQ VOBG CO3D METM 2NO2 OGUX Z7U4 DP2H UYMA"
  },
  "webhooks": {
    "request_succeeded": "http://mywebsite.com/zinc/request_succeeded",
    "request_failed": "http://mywebsite.com/zinc/requrest_failed",
    "tracking_obtained": "http://mywebsite.com/zinc/tracking_obtained"
  },
  "client_notes": {
    "our_internal_order_id": "abc123",
    "any_other_field": ["any value"]
  }
}'
```

> Example create an order response

```shell
{
  "request_id": "3f1c939065cf58e7b9f0aea70640dffc"
}
```

Zinc offers an API for apps that need real-time order placing capabilities. With a single POST request, you can order an item from one of our supported retailers. Making an order request will start an order. You'll receive a `request_id` in the POST body's response which you'll then use for [retrieving the status of the order](#retrieving-an-order). The following illustration shows the flow for a typical order.

![flow chart for making an order](images/ordering-flow.svg)

### Required attributes

Attribute | Type | Description
--------- | ---- | -----------
retailer | String | The retailer code of the supported retailer
products | List | A list of [product objects](#product-object) that should be ordered
shipping_address | Object | An [address object](#address-object) to which the order will be delivered
shipping_method | String | The desired shipping method for the object. Available methods are `cheapest` (always select the cheapest method available), `fastest` (always select the fastest method available), `amazon_day` (choose default from Amazon or use amazon_day attribute from order), or `free` (which will fail for items without some sort of free shipping). You must provide either this or the `shipping` attribute, but not both.
shipping | Object | A [shipping object](#shipping-object) with information as to which shipping method to use. You must provide either this or the `shipping_method` attribute, but not both.
billing_address | Object | An [address object](#address-object) for the person associated with the credit card
payment_method | Object |A [payment method](#payment-method-object) object containing payment information for the order
retailer_credentials | Object | A [retailer credentials](#retailer-credentials-object) object for logging into the retailer with a preexisting account
is_gift | Boolean | Whether or not this order should be placed as a gift. Typically, retailers will exclude the price of the items on the receipt if this is set.
max_price | Number | The maximum price in cents for the order. If the final price exceeds this number, the order will not go through and will return a `max_price_exceeded` error.

### Optional attributes

Attribute | Type | Description
--------- | ---- | -----------
gift_message | String | A message to include on the packing slip for the recipient. Must be no more than 240 characters, or 9 lines.
require_gift | Boolean | If is_gift is true, setting require_gift to true will cause the order to fail if any items in the order do not include a gift option.
webhooks | Object | A [webhooks object](#webhooks-object) including URLs that will receive POST requests after particular events have finished
client_notes | Object | Any metadata to store on the request for future use. This object will be passed back in the response.
promo_codes | Array | A list of promotion codes to use at checkout. See [promo code](#promo-code-object) object.
strict_expired_product_id | Boolean | Defaults to false. If true, we will fail orders where the product_id is "expired" or "deprecated". If unset or false, Amazon redirects us to a valid product_id and we buy that one.
po_number | Number | (Amazon business accounts only). Adds a purchase order number to the order.
amazon_day | String | (Amazon only) Specify exact name of Amazon Day shipping selection when ship_method is set to `amazon_day`.
fail_if_taxed | Boolean | Defaults to false. If true, we will fail orders where taxes are included in the total. This is useful for ZMA orders which should not be placed if no tax exempt account is available.
zma_discount | Number | The percent below (or above, if negative) face value that you will be charged for this order. Can range from -50 to 0. Lower discount orders will be processed before higher discount orders. If discount is too high and we are unable to secure ordering at that discount, the order will time out with zma_temporarily_overloaded. Defaults to 0%.


## Retrieving an order

> Example retrieve an order request

```shell
curl "https://api.zinc.io/v1/orders/3f1c939065cf58e7b9f0aea70640dffc" \
  -u <client_token>:
```

To see the status of an order, append the 'request_id' returned from your order query to the order URL and place GET request. Orders usually take a while to process. While your order is processing, the response will return an error with code type `request_processing`.

> Example retrieve an order response (request processing)

```shell
{
  "_type": "error",
  "code": "request_processing",
  "message": "Request is currently processing and will complete soon.",
  "data": {}
}
```

> Example retrieve an order response (order response)

```shell
{
  "_type" : "order_response",
  "price_components" : {
    "shipping" : 0,
    "subtotal" : 1999,
    "tax" : 0,
    "total" : 1999
  },
  "merchant_order_ids" : [
    {
      "merchant_order_id" : "112-1234567-7272727",
      "merchant" : "amazon",
      "account" : "timbeaver@gmail.com",
      "placed_at" : "2014-07-02T23:51:08.366Z"
    }
  ],
  "tracking" : [
    {
      "product_id" : "0923568964",
      "merchant_order_id" : "112-1234567-7272727",
      "carrier" : "Fedex",
      "tracking_number" : "9261290100129790891234",
      "obtained_at" : "2014-07-03T23:22:48.165Z"
    }
  ],
  "request" : {
    ...
  }
}
```

Once the request process completes, the retrieve an order response should either return a response of type `order_response`, with the details of the successfully placed order or `error`. An error response body will contain a `code` and a `message`. The code indicates the error that occurred, while the message provides a more detailed description of the error. Any extra details about the error will be provided in the `data` object. For a full list of errors, see the [Errors section](#errors).

### Order response attributes

Attribute | Type | Description
--------- | ---- | -----------
price_components | Object | A [price components object](#price-components-object) which contains details about the price of the final order
merchant_order_ids | Array | A [merchant order ids object](#merchant-order-ids-object) which contains details about the retailer's order identifiers
tracking | Array | An array of [tracking objects](#tracking-object) that contain the order's tracking information. In most cases, this field will not be populated immediately after the order is placed and will only be available later after tracking is updated by the retailer. Once tracking has been obtained, a POST request will be sent to the `tracking_obtained` field of the [webhooks object](#webhooks-object) from the request if set.
request | Object | The original request that was sent to the Zinc API
delivery_dates | Array | An array of ordered products and their given delivery dates
account_status | Array | (Amazon only) An [account status object](#account-status-object) that gives details about the ordering account

## Retrieving a list of orders

> Example query for all Amazon orders (up to 5000) for June 1, 2019 14:00 - July 1, 2019 14:00

```shell
curl "https://api.zinc.io/v1/orders?limit=5000&starting_after=1559397600000&ending_before=1561989600000&retailer=amazon" \
  -u <client_token>:
```
To get a list of all orders within a specific timestamp range, use the order query and include these additional query parameters.

### Order query parameters

Parameter | Type | Description
--------- | ---- | -----------
limit | Number | Maximum number of orders to return in the results (defaults to 10)
skip | Number | Number of order responses to skip before including up to limit orders in results
starting_after | Number | Timestamp of start of the range (inclusive)
ending_before | Number | Timestamp of end of the range (exclusive)
retailer | String | name of the retailer to include orders from

The timestamps are unix timestamps in milliseconds, which you can read about here [unix timestamps](https://en.wikipedia.org/wiki/Unix_time). To easily convert a human-readable date / time to a unix timestamp, you can use this [converter](https://www.epochconverter.com/).

Sample code that includes an example of a bulk order query can be found in this github [repo](https://github.com/zincio/api-samples).

## Selecting an offer & shipping

When placing an order, each product will have multiple offers from different sellers each with their own shipping options. To address this, use a product's [seller selection criteria](#seller-selection-criteria-object) to filter offers and an order's [shipping parameter](#shipping-object) to specify shipping preferences. Below is an flowchart of the process used to filter offers and select a shipping option.

![flow chart for making an order](images/select-offer.svg)

### Default seller selection criteria

If a seller selection criteria object is not explicitly provided, then the API will use the default:
```
{
  "prime": true,
  "handling_days_max": 6,
  "condition_in": ["New"]
}
```

### Some examples

* If you wanted to send your customer a tracking number within 5 days, you would set `handling_days_max` to 5 in your [seller selection criteria](#seller-selection-criteria-object). The Zinc API would then filter out all offers which would not ship and upload a tracking number within 5 days.
* If you specified `"handling_days_max": 6` in your [seller selection criteria](#seller-selection-criteria-object), then any offer that won't ship in 6 days or less from now would be excluded from your buying selection. Thus, if two sellers are offering the same product, but one has a guaranteed shipping date 10 days away and the other seller has a guaranteed shipping date 5 days away, the second seller's offer would be selected. (Note: when no handling information is available, we use the longest projected arrival date of the product as the `handling_days_max`)
* If you set `"max_days": 5` on the [shipping parameter](#shipping-object), the Zinc API would attempt to select the cheapest shipping method that took less than 5 days to arrive. Thus, if there was a shipping method that took 3 days and cost $10 and another shipping method that took 7 days but cost $2, the first shipping option would be selected.

## Aborting an order

> Example order abort request

```shell
curl "https://api.zinc.io/v1/orders/<request_id>/abort" \
  -X POST \
  -u <client_token>:
```

> Example successful order abort response

```shell
{
  "_type": "error",
  "code": "aborted_request",
  "message": "The request was aborted before it completed.",
  "data": {
    "msg": "Order aborted and dequeued"
  },
  "request_id": "3f1c939065cf58e7b9f0aea70640dffc",
  "request": {
    ...
  }
}
```

> Example abort response that is still pending

```shell
{
  "_type": "error",
  "code": "request_processing",
  "message": "Request is currently processing and will complete soon.",
  "data": {}
  "request_id": "3f1c939065cf58e7b9f0aea70640dffc",
}

```

The Zinc API allows you to abort orders that are still in the `request_processing` stage. This functionality is intended to abort an order if was made by mistake or if it is taking too long to process.

The response will be the same as if you were to [GET the order](#retrieving-an-order). If we were able to immediately abort the order, the order will have an error **code** of `aborted_request`. It can take time for an order to abort and success is not guaranteed. You can either periodically poll the order to check if it was aborted or use webhooks.

## Amazon email verification

Occasionally, Amazon requires verification of account ownership and will email you a code during login.
If this happens during an order, you will receive an `account_locked_verification_required` error.
There are a few options for resolving this issue.

* Check the email associated with the account and obtain the verification code. Then resubmit your order and supply the code as `verification_code` under the [`retailer_credentials`](#retailer-credentials-object) object.
* Enable Two Factor Authentication on your account and supply the `totp_2fa_key` with every order under the [`retailer_credentials`](#retailer-credentials-object) object.
* Use [Zinc Managed Accounts](#zinc-managed-accounts) where we manage keeping accounts open and unlocked.
* Forward all emails from your Amazon account's email to <email@quail.zinc.io>. AutoOrdering will automatically parse the incoming email and fill in the code. For instructions on how to forward from a Gmail account, [see this article](https://support.google.com/mail/answer/10957?hl=en).

## Retrying an order

Sometimes an order will fail for reasons that are temporary. In these situations, orders can be retried after the temporary conditions are resolved. A successful order retry response contains the request_id of the new order.

> Example order retry request

```shell
curl "https://api.zinc.io/v1/orders/<request_id>/retry" \
  -X POST \
  -u <client_token>:
```

> Example successful order retry response

```shell
{
  "request_id": "3f1c939065cf58e7b9f0aea70640dffc"
}
```
