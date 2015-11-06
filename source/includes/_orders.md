# Orders

## Create an order

> Example Request

```shell
curl -X POST "https://api.zinc.io/v1/orders" \
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

> Example Response

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

### Required Attributes

Attribute | Type | Description
--------- | ---- | -----------
retailer | String |The retailer code of the supported retailer
products | List | TODO
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

