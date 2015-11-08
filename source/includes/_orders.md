# Orders

## Product object

Attribute | Type | Description
--------- | ---- | -----------
product_id | String | The retailer's unique identifier for the product.
quantity | Number | The number of products to purchase.


## Create an order

> Example create an order request

```shell
curl "https://api.zinc.io/v1/orders" \
  -u client_token: \
  -d '{
  "retailer": "amazon",
  "products": [
    {
      "product_id": "0923568964", 
      "quantity": 1,
      "seller_selection_criteria": [
        {
          "condition_in": ["New"],
          "international": false,
          "max_shipping_days": 5
        }
      ]
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
  "shipping_method": "cheapest",
  "payment_method": {
    "name_on_card": "Ben Bitdiddle",
    "number": "5555555555554444",
    "security_code": "123",
    "expiration_month": 1,
    "expiration_year": 2015,
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
    "password": "myRetailerPassword"
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

### Required Attributes

Attribute | Type | Description
--------- | ---- | -----------
retailer | String | The retailer code of the supported retailer
products | List | A list of [product objects](#product-object) that should be ordered.
shipping_address | Object | TODO
shipping_method | String | The desired shipping method for the object.
billing_address | Object | TODO
payment_method | Object | TODO
retailer_credentials | Object | TODO


### Optional Attributes

Attribute | Type | Description
--------- | ---- | -----------
gift_message | String | A message to include on the packing slip for the recipient. Must be no more than 240 characters, or 9 lines.
is_gift | Boolean | Whether or not this order should be placed as a gift. Typically, retailers will exclude the price of the items on the receipt if this is set.
max_price | Number | The maximum price in cents for the order. If the final price exceeds this number, the order will not go through and will return a `max_price_exceeded` error.
webhooks | Object | TODO
client_notes | Object | TODO
promo_codes | Array | TODO
ignore_invalid_promo_code | Boolean | TODO
po_number | Number | TODO

## Retrieving an order

> Example retrieve an order request

```shell
curl "https://api.zinc.io/v1/orders/3f1c939065cf58e7b9f0aea70640dffc" \
  -u client_token:
```

To see the status of an order, you can retrieve it using the request id you obtained from your order request, and placing it in a GET request URL. Orders usually take a while to process. While your order is processing, the response will return an error with code type `request_processing`.

> Example retrieve an order response (request processing)

```shell
{
  "_type": "error",
  "code": "request_processing",
  "message": "Request is currently processing and will complete soon.",
  "data": {}
}
```

Once the request completes, the retrieve an order response should either return a response of type `order_response` or `error_response`. An error response body will contain a `code` and a `message`. The code indicates the error that occurred, while the message provides a more detailed description of the error. Any extra details about the error will be provided in the `data` object. For a full list of errors, see the [Errors section](#errors).

### Order response attributes

Attribute | Type | Description
--------- | ---- | -----------
price_componets | Object | TODO
merchant_order_ids | Array | TODO
tracking | Array | TODO
request | Object | TODO

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
      "product_id" : "B000000123",
      "merchant_order_id" : "112-1234567-7272727",
      "merchant" : "amazon",
      "account" : "timbeaver@gmail.com",
      "placed_at" : ISODate("2014-07-02T23:51:08.366Z")
    }
  ],
  "tracking" : [
    {
      "product_id" : "0923568964",
      "merchant_order_id" : "112-1234567-7272727",
      "carrier" : "Fedex",
      "tracking_number" : "9261290100129790891234",
      "obtained_at" : ISODate("2014-07-03T23:22:48.165Z")
    }
  ],
  "request" : {
    ...
  }
}
```
