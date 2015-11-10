# Orders

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
products | List | A list of [product objects](#product-object) that should be ordered
shipping_address | Object | An [address object](#address-object) to which the order will be delivered
shipping_method | String | The desired shipping method for the object. Available methods are `cheapest` (always select the cheapest method available), `fastest` (always select the fastest method available), or `free` (which will fail for items without some sort of free shipping).
billing_address | Object | An [address object](#address-object) for the person associated with the credit card
payment_method | Object |A [payment method](#payment-method-object) object containing payment information for the order
retailer_credentials | Object | A [retailer credentials](#retailer-credentials-object) object for logging into the retailer with a preexisting account


### Optional Attributes

Attribute | Type | Description
--------- | ---- | -----------
gift_message | String | A message to include on the packing slip for the recipient. Must be no more than 240 characters, or 9 lines.
is_gift | Boolean | Whether or not this order should be placed as a gift. Typically, retailers will exclude the price of the items on the receipt if this is set.
max_price | Number | The maximum price in cents for the order. If the final price exceeds this number, the order will not go through and will return a `max_price_exceeded` error.
webhooks | Object | A [webhooks object](#webhooks-object) including URLs that will receive POST requests after particular events have finished
client_notes | Object | Any metadata to store on the request for future use. This object will be passed back in the response.
promo_codes | Array | (`nordstrom` only). A list of promotion codes to use at checkout.
ignore_invalid_promo_code | Boolean | (`nordstrom` only). Continue with checkout even if promotion codes are invalid. Default is `false`.
po_number | Number | (`amazon` business accounts only). Adds a purchase order number to the order.

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

Once the request completes, the retrieve an order response should either return a response of type `order_response` or `error_response`. An error response body will contain a `code` and a `message`. The code indicates the error that occurred, while the message provides a more detailed description of the error. Any extra details about the error will be provided in the `data` object. For a full list of errors, see the [Errors section](#errors).

### Order response attributes

Attribute | Type | Description
--------- | ---- | -----------
price_components | Object | A [price components object](#price-components-object) which contains details about the price of the final order
merchant_order_ids | Array | A [merchant order ids object](#merchant-order-ids-object) which contains details about the retailer's order identifiers
tracking | Array | An array of [tracking objects](#tracking-object) that contain the order's tracking information. In most cases, this field will not be populated immediately after the order is placed and will only be available later after tracking is updated by the retailer. Once tracking has been obtained, a POST request will be sent to the `tracking_obtained` field of the [webhooks object](#webhooks-object) from the request if set.
request | Object | The original request that was sent to the Zinc API

## Product object

Attribute | Type | Description
--------- | ---- | -----------
product_id | String | The retailer's unique identifier for the product.
quantity | Number | The number of products to purchase.

## Address object

Attribute | Type | Description
--------- | ---- | -----------
first_name | String | The first name of the addressee
last_name | String | The last name of the addressee
address_line1 | String | The house number and street name
address_line2 | String | The suite, post office box, or apartment number (optional)
zip_code | String | The zip code of the address
city | String | The city of the address
state | String | The USPS abbreviation for the state of the address (e.g. AK)
country | String | The ISO abbreviation for the country of the address (e.g. US)
phone_number | String | The phone number associated with the address

## Payment method object

Attribute | Type | Description
--------- | ---- | -----------
name_on_card | String | The full name on the credit/debit card
number | String | The credit/debit card number
security_code | String | The card verification value on the back of the credit/debit card
expiration_month | Number | The month of the expiration of the card (e.g. January is 1, February is 2)
expiration_year | Number | The year of the expiration of the card (e.g. 2016)
use_gift | Boolean | Whether or not to use the gift balance on the retailer account. If true, then the gift balance will first be used up completely before the card will be charged. Only works for retailers which support gift balance (`amazon` and `amazon_uk`).

## Webhooks object

Attribute | Type | Description
--------- | ---- | -----------
order_placed | String | The webhook URL to send data to when an order is placed
order_failed | String | The webhook URL to send data to when an order fails
tracking_obtained | String | The webhook URL to send data to when tracking for an order is retrieved

## Retailer credentials object

Attribute | Type | Description
--------- | ---- | -----------
email | String | The email for the retailer account
password | String | The password for the retailer account

## Price components object

Attribute | Type | Description
--------- | ---- | -----------
shipping | Number | The price for shipping
gift_certificate | Number | The amount of value used on a gift certificate placed on the account
subtotal | Number | The total price of the order before tax and other price adjustments
tax | Number | The tax collected on the order
total | Number | The total price paid for the order

## Merchant order ids object

Attribute | Type | Description
--------- | ---- | -----------
merchant_order_id | String | The identifier provided by the retailer for the order that was placed
merchant | String | The retailer on which the order was placed
account | String | The account on which the order was placed
placed_at | Date | The date and time at which the order was placed
