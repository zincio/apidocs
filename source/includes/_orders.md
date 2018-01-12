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
    "order_placed": "http://mywebsite.com/zinc/order_placed",
    "order_failed": "http://mywebsite.com/zinc/order_failed",
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

Zinc offers an API for apps that need real-time order placing capabilities. With a single POST request, you can order an item from one of our supported retailers. Making an order request will start an order. You'll receive a `request_id` in the POST body's response which you'll then use for [retrieving the status of the order](#retrieving-an-order).

### Required attributes

Attribute | Type | Description
--------- | ---- | -----------
retailer | String | The retailer code of the supported retailer
products | List | A list of [product objects](#product-object) that should be ordered
shipping_address | Object | An [address object](#address-object) to which the order will be delivered
shipping_method | String | The desired shipping method for the object. Available methods are `cheapest` (always select the cheapest method available), `fastest` (always select the fastest method available), or `free` (which will fail for items without some sort of free shipping). You must provide either this or the `shipping` attribute, but not both.
shipping | Object | A [shipping object](#shipping-object) with information as to which shipping method to use. You must provide either this or the `shipping_method` attribute, but not both.
billing_address | Object | An [address object](#address-object) for the person associated with the credit card
payment_method | Object |A [payment method](#payment-method-object) object containing payment information for the order
retailer_credentials | Object | A [retailer credentials](#retailer-credentials-object) object for logging into the retailer with a preexisting account


### Optional attributes

Attribute | Type | Description
--------- | ---- | -----------
gift_message | String | A message to include on the packing slip for the recipient. Must be no more than 240 characters, or 9 lines.
is_gift | Boolean | Whether or not this order should be placed as a gift. Typically, retailers will exclude the price of the items on the receipt if this is set.
max_price | Number | The maximum price in cents for the order. If the final price exceeds this number, the order will not go through and will return a `max_price_exceeded` error.
webhooks | Object | A [webhooks object](#webhooks-object) including URLs that will receive POST requests after particular events have finished
client_notes | Object | Any metadata to store on the request for future use. This object will be passed back in the response.
promo_codes | Array | A list of promotion codes to use at checkout.
ignore_invalid_promo_code | Boolean | Continue with checkout even if promotion codes are invalid. Default is `false`.
po_number | Number | (Amazon business accounts only). Adds a purchase order number to the order.
bundled | Boolean | (Amazon only). If enabled, orders will be grouped together into batches and placed together. See the [order bundling](#order-bundling) section for more details.

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

## Selecting shipping

Zinc provides a number of options to customize your shipping speed and cost formulas from the various options available from our supported retailers.

Since different items will have different shipping options, you can use a product's [seller selection criteria](#seller-selection-criteria-object) to specify `handling_days_max`. This will filter the list of potential offers down to those that will arrive within a certain number of days. The Zinc API will then select the cheapest offer that matched all of your seller selection criteria to make a purchase. For example, if you specified `"handling_days_max": 6`, then any offer whose latest delivery date is greater than 6 days from now would be excluded from your buying selection. Thus, if two sellers are offering the same product, but one has a guaranteed delivery date 10 days away and the other seller has a guaranteed delivery date 5 days away, the second seller's offer would be selected.

You may also use the [shipping parameter](#shipping-object) on an order to select a shipping option once a product has been selected. Instead of filtering by the different offers, like the seller selection criteria, the `shipping` parameter will choose the shipping speed on the selected offer. For example, if you set `"max_days": 5` on the `shipping` parameter, the Zinc API would attempt to select the cheapest shipping method that took less than 5 days. Thus, if there was a shipping method that took 3 days and cost $10 and another shipping method that took 7 days but cost $2, the first shipping option would be selected.

## Order bundling

The bundling feature groups orders together before placing them. This is often advantageous on retailers where larger orders are given free shipping. To use bundling, you only need to specify `bundled: true` when placing an order request. Bundling currently only works on the following retailers: `amazon`, `amazon_uk`.

The bundling feature allows you to take advantage of free shipping over $50 (on Amazon) without having to change your Zinc integration. Bundling will take the shipping addresses, products, and quantities from separate orders and will group them together into a single order, making sure that each product is routed correctly. The order requests and responses remain exactly the same. The only difference is when the order is placed. The order bundling feature will wait for enough orders in the queue before launching a bundled order. The exact dynamics are as follows:

1. The order bundler will wait until $55 in products have been purchased. As soon as more than $55 of products have been queued with `bundled: true`, the bundler will launch a new order.
2. If the order bundler has waited for longer than 6 hours and has not yet obtained $55 in products, it will launch an order with whatever products are currently in the queue.

Note that the order bundler will not group together two orders which have the same product ids.

## Amazon Email Verification

Amazon occasionally requires additional verification of account ownership by
emailing you a code to enter during login. If this happens during an order, you
will receive an `account_locked_verification_required` error. In this case,
please check the email associated with the account and obtain the verification
code. Then resubmit your order and supply the code as `verification_code` under
the `retailer_credentials` object. Another option is to enable Two Factor Authentication on your account and supply the 'totp_2fa_key' with every order, which will skip Amazon email verification, for more detail review the info on ['retailer_credentials'](#retailer-credentials-object) 

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

> Example request processing order abort response

```shell
{
  "_type": "error",
  "code": "request_processing",
  "message": "Request is currently processing and will complete soon.",
  "data": {}
  "request_id": "3f1c939065cf58e7b9f0aea70640dffc",
}

```

The Zinc API allows you to abort uncompleted orders that are still
in the `request_processing` stage. This functionality allows you to stop an
order from going through if a mistake was made on the order, or if the order
is taking too long to process.

The response to this request will be a standard GET response for an order, which is
either a `request_processing` response, an error response, or a successful order
response. If we are able to successfully abort the order, an `aborted_request` error
code will be returned for the order in question. If you receive back a
`request_processing` response, you will need to continue to wait before the API is
able to abort a request on an already running process.

If you are using the `request_succeeded` and `request_failed` webhooks, you won't
need to do anything with the order abort response. The API will hit the
`request_failed` webhook if an order is aborted correctly, and will have normal
behavior if the order abort fails.

Note that abortion is best effort, so we cannot guaranteed that you will be
able to abort a request.

## Adding and Amazon Affiliate Tag

> Example Affiliate Tag Snippet

```shell
curl "https://api.zinc.io/v1/orders" \
  -u <client_token>: \
  -d '{
  "retailer": "amazon",
  "affiliate_info": {"tag": "yourtag-20"},
  ...
  }
  ```
The API allows you to add an Amazon Affiliate tag if you so desire. However, Zinc doesn't recommend using the affiliate tag due to the high risk of your affiliate account being closed when a large number of orders are coming from a particular purchasing account.
