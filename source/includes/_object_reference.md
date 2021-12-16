# Object reference

## Product object

> Example product object

```shell
{
  "product_id": "B06XGHJ5H3",
  "quantity": 1,
  "seller_selection_criteria": {
    "prime": true,
    "handling_days_max": 6,
    "condition_in": ["New"],
  }
}
```

Attribute | Type | Description
--------- | ---- | -----------
product_id | String | The retailer's unique identifier for the product. Note that Zinc does not support digital purchases or Amazon prime pantry items.
quantity | Number | The number of products to purchase.
seller_selection_criteria | Object | A [seller selection criteria](#seller-selection-criteria-object) object containing information about which offers to choose when there are multiple offers available. If the seller selection criteria object is not included for a product, the seller selection criteria will default to `"prime": true`, `"handling_days_max": 6`, and `"condition_in": ["New"]`.

## Seller selection criteria object

> Example seller selection criteria object

```shell
{
  "addon": false,
  "condition_in": ["New"],
  "handling_days_max": 6,
  "max_item_price": 5350
  "min_seller_num_ratings": 100,
  "prime": true,
}
```

Seller selection criteria allow you to filter multiple offers for a product from a retailer. They give you fine grained control when a retailer has multiple offers for a single product. This happens frequently when third party or affiliated merchants are selling on a platform, such as o Amazon.

The seller selection criteria serve as a series of optional filters to narrow down the potential set of offers to something reasonable. After all the filters have been applied, Zinc will select the cheapest offer that is still available. For example, if `"handling_days_max": 6` is applied, then the Zinc API will order the cheapest offer where the shipping will arrive in 6 days or less.

Attribute | Type | Description
--------- | ---- | -----------
addon | Boolean | (Amazon only) Specifies whether the selected offer should be an addon item
buy_box | Boolean | (Amazon only) Specifies whether the selected offer should be Amazon's default buy box offer
condition_in | Array | An array of item conditions that the Zinc API must order from
condition_not_in | Array | An array of item conditions that the Zinc API must not order from
first_party_seller | Boolean | Is the seller first-party? e.g. sold by Walmart.com on walmart
handling_days_max | Number | The maximum number of allowable days for shipping and handling
international | Boolean | Specifies whether the item should come from an international supplier
max_item_price | Number | The maximum allowable price in cents for an item
merchant_id_in | Array | (Amazon only) An array of merchant ids that the Zinc API must order from
merchant_id_not_in | Array | (Amazon only) An array of merchant ids that the Zinc API must not order from
min_seller_num_ratings | Number | (Amazon only) The minimum number of ratings required for an Amazon seller's offer to be selected
min_seller_percent_positive_feedback | Number | (Amazon only) The minimum percentage of positive ratings of an Amazon seller for their offer to be selected
prime | Boolean | (Amazon only) Specifies whether the selected offer should be an Amazon Prime offer
allow_oos | Boolean | (Amazon only) Specifies whether we should still attempt to complete ordering with the cheapest offer if all offers appear unavailable

## Shipping object

> Example shipping object

```shell
{
  "order_by": "price",
  "max_days": 5,
  "max_price": 1000
}
```

The shipping object gives you fine grained control over shipping speeds on your orders. Typically, there is a tradeoff between how fast your order arrives and the cost of shipping. The shipping object gives you a way to make sure that you don't go over budget and that your order still arrives on time.

Attribute | Type | Description
--------- | ---- | -----------
order_by | String | The ordering of available shipping methods that meet the desired criteria. Available values are `price` or `speed`. If ordering by price, then the Zinc API will choose the cheapest shipping method that meets the desired criteria, while `speed` will choose the fastest shipping method meeting the criteria.
max_days | Number | The maximum number of days allowed for shipping on the order.
max_price | Number | The maximum price in cents allowed for the shipping cost of the order.

## Address object

> Example address object

```shell
{
  "first_name": "Tim",
  "last_name": "Beaver",
  "address_line1": "77 Massachusetts Avenue",
  "address_line2": "",
  "zip_code": "02139",
  "city": "Cambridge",
  "state": "MA",
  "country": "US",
  "phone_number": "5551230101",
  "instructions": "Place packages inside blue garage door."
}
```

Attribute | Type | Description
--------- | ---- | -----------
first_name | String | The first name of the addressee
last_name | String | The last name of the addressee
address_line1 | String | The house number and street name
address_line2 | String | The suite, post office box, or apartment number (optional)
zip_code | String | The zip code of the address
city | String | The city of the address
state | String | The USPS abbreviation for the state of the address (e.g. AK)
country | String | The ISO abbreviation for the country of the address (e.g. US). A list of all available two-letter country codes can be found [here](http://www.theodora.com/country_digraphs.html).
phone_number | String | The phone number associated with the address
instructions | String | Optional instructions to include with the shipping addresses

## Payment method object

> Example payment object

```shell
{
  "name_on_card": "Ben Bitdiddle",
  "number": "5555555555554444",
  "security_code": "123",
  "expiration_month": 1,
  "expiration_year": 2015,
  "use_gift": false
}
```

The recommended way to pay for purchases on a retailer is by using gift card balance already applied to an account. Gift cards are supported on `amazon`, `amazon_uk`, `amazon_ca`, and `walmart`. To use the existing gift balance on the account, simply pass `{"use_gift": true}` as the payment method object.

To use a credit card, you must include the `name_on_card`, `number`, `security_code`, `expiration_month`, and `expiration_year` fields. For Amazon, you should only have a single credit card associated with an account which should be the same as the card passed in the payment method object. This allows the system to correctly answer any payment-related security questions.

Attribute | Type | Description
--------- | ---- | -----------
name_on_card | String | The full name on the credit/debit card
number | String | The credit/debit card number
security_code | String | The card verification value on the back of the credit/debit card
expiration_month | Number | The month of the expiration of the card (e.g. January is 1, February is 2)
expiration_year | Number | The year of the expiration of the card (e.g. 2016)
use_gift | Boolean | Whether or not to use the gift balance on the retailer account. If true, then the gift balance will be used for payment. Only works for retailers which support gift balance (Amazon and Walmart).
use_account_payment_defaults | Boolean | Overrides all other payment_method options and uses the default payment configuration on the account. Only applies to Amazon orders.
is_virtual_card | Boolean | Whether or not to check the "Virtual or one-time-use" checkbox when adding the card. Only applies to Amazon orders.

## Webhooks object

Webhooks let you register a URL that the Zinc API notifies whenever an event happens pertaining to your account. When an event occurs, we will send a `POST` request to the URL specified in the webhooks object. If no URL was specified, then a webhook will not be sent. The body of the `POST` request is the standard raw JSON response for that object.

As an example, let's say you have just created an order via the Zinc API. Every time the order status changes, a `POST` request will be sent to the URL that you passed in the `status_updated` parameter of the webhooks object. The body will mimic the response received from the standard `GET https://api.zinc.io/v1/orders/<request_id>` request. A webhook will also be sent if order fails, gets placed, or if tracking gets updated.

Note that the `case_updated` webhook is specifically for ZMA order cases.

> Example webhooks object

```shell
{
  "request_succeeded": "http://mywebsite.com/zinc/request_placed",
  "request_failed": "http://mywebsite.com/zinc/request_failed",
  "tracking_obtained": "http://mywebsite.com/zinc/tracking_obtained",
  "status_updated": "http://mywebsite.com/zinc/status_updated",
  "case_updated": "http://mywebsite.com/zinc/case_updated"
}
```

Attribute | Type | Description
--------- | ---- | -----------
request_succeeded | String | The webhook URL to send data to when a request succeeds
order_placed | String | (deprecated) Synonym for request_succeeded (placing orders call only)
request_failed | String | The webhook URL to send data to when a request fails
order_failed | String | (deprecated) Synonym for request_failed (placing orders call only)
tracking_obtained | String | The webhook URL to send data to when tracking for an order is retrieved (placing orders call only)
status_updated | String | The webhook URL to send data to when the status of a request is updated

You can optionally pass an Array of webhooks instead of a String, and Zinc will hit all of the webhooks.

## Retailer credentials object

> Example retailer credentials object

```shell
{
  "email": "timbeaver@gmail.com",
  "password": "myRetailerPassword"
}
```

Attribute | Type | Description
--------- | ---- | -----------
email | String | The email for the retailer account
password | String | The password for the retailer account
verification_code | String | (Optional) The verification code required by the retailer for logging in. Only required in cases where the retailer prevents a login with an `account_locked_verification_required` error code.
totp_2fa_key | String | (Optional) The secret key used for two factor authentication. If you have two factor authentication enabled, you must provide this key. You can find the 64 digit Amazon key by enabling two factor authentication and <a href="images/amazon2fa.png" target="_blank">clicking on the "Can't scan the barcode?"</a> link. **Note: This is not the 6 digit time based code.**

## Promo code object

> Example promo code object

```json
{
  "code": "FIVEBUCKSOFF",
  "optional": false,
  "merchant_id": "A3GH440E2AFGH4",
  "discount_amount": 500
}
```

Attribute | Type | Description
--------- | ---- | -----------
code | String | The promo code to apply (required)
optional | Boolean | (Optional) Should we continue placing the order if this code fails to apply? Defaults to false.
merchant_id | String | (Optional) If supplied, only try this code if we selected an offer from the given merchant.
discount_amount | Number | (Optional) Fixed amount in cents by which we should discount the matching merchant's offers during offer selection. Only makes sense if merchant_id is also supplied. Defaults to 0.
discount_percentage | Number | (Optional) Percentage amount (between 0 and 100) by which we should discount the matching merchant's offers during offer selection. Only makes sense if merchant_id is also supplied. Defaults to 0.
cost_override | Number | (Optional) If supplied, we will assume all offers by this merchant cost exactly this many cents. Only makes sense if merchant_id is also supplied. Overrides other discount methods.


## Price components object

> Example price components object

```shell
{
  "converted_payment_total": 1999,
  "currency": "USD",
  "payment_currency": "USD",
  "shipping" : 0,
  "subtotal" : 1999,
  "tax" : 0,
  "total" : 1999
}
```

Attribute | Type | Description
--------- | ---- | -----------
shipping | Number | The price for shipping
products | Array | A list of the price, quantity, and seller_id for each product_id in the order
subtotal | Number | The total price of the order before tax and other price adjustments
tax | Number | The tax collected on the order
total | Number | The total price paid for the order in the currency specify by the currency attribute
gift_certificate | Number | (Optional) The amount of value used on a gift certificate placed on the account
currency | String | Currency of all attributes except converted_payment_total
payment_currency | String | Currency used in the payment transaction
converted_payment_total | Number | Total payment in payment_currency currency

## Merchant order ids object

> Example merchant order ids object

```shell
{
  "merchant_order_id" : "112-1234567-7272727",
  "merchant" : "amazon",
  "account" : "timbeaver@gmail.com",
  "placed_at" : "2018-01-02T23:51:08.366Z",
  "tracking_url": "https://www.amazon.com/progress-tracker/package/ref=oh_aui_hz_st_btn?_encoding=UTF8&itemId=jnlnooqppopuun&orderId=112-1234567-7272727",
  "delivery_date": "Jan. 7, 2018"
}
```

Attribute | Type | Description
--------- | ---- | -----------
merchant_order_id | String | The identifier provided by the retailer for the order that was placed
merchant | String | The retailer on which the order was placed
account | String | The account on which the order was placed
placed_at | Date | The date and time at which the order was placed
tracking | Array | A list of the tracking numbers associated with the order
product_ids | Array | A list of product_ids in the order
tracking_url | String | The tracking url provided by the merchant (if available)
delivery_date | String | The projected delivery date given by the retailer

## Account status object
> Example account status object

```shell
{
  "prime": true,
  "fresh": false,
  "business": false,
  "charity": null
}
```

Attribute | Type | Description
--------- | ---- | -----------
prime | boolean | Indicates if the account has Prime enabled
fresh| boolean | Indicates if the account has Fresh enabled
business | boolean | Indicates if the account has Business enabled
charity | string | Indicates if the account has a Charity associated

## Product offer object

> Example product offer object

```shell
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
  "offer_id": "eMLzuculxk%2",
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
}
```

Attribute | Type | Description
--------- | ---- | -----------
addon | Boolean | Whether or not the product is an addon item that can only be purchased in a bundle
condition | String | The condition of the product. Possible values are `New`, `Refurbished`, `Used - Like New`, `Used - Very Good`, `Used - Good`, `Used - Acceptable`, `Unacceptable`.
handling_days.max | Number | The maximum number of days required for shipping and handling
handling_days.min | Number | The minimum number of days required for shipping and handling
international | Boolean | Whether or not the product ships from outside of the United States
offer_id | String | (Amazon only). The unique identifier that identifies an item sold by any merchant on Amazon
price | Number | The price of the item, not including shipping in cents.
marketplace_fulfilled | Boolean | Whether or not the product ships direct from retailer. For Amazon, this indicates if the item is shipped with Prime shipping.
seller.id | String | The merchant's unique identifier for the product
seller.name | String | The name of the seller of the current offer
seller.num_ratings | Number | The number of ratings that the seller has accumulated
seller.percent_positive | Number | Number between 0 and 100 denoting the percentage of positive ratings the seller has received
shipping_options[].price | Number | The cost to ship the item in cents
shipping_options[].delivery_days.min | Number | The minimum time in days it might take for the item to be delivered
shipping_options[].delivery_days.max | Number | The maximum time in days it might take for the item to be delivered
shipping_options[].name | String | The name of the shipping option
prime_only | Boolean | (Amazon only). Whether or not the product only ships using Amazon Prime
member_only | Boolean | (Costco only) Whether or not the purchase must be from a Costco Member

## Tracking object

> Example tracking object

```shell
    {
      "merchant_order_id": "112-111111-6553065",
      "carrier": "ZNLOGIC",
      "tracking_number": "ZPYAA0051111007YQ",
      "delivery_status": "InTransit",
      "product_ids": [
        "B000R31KH2"
      ],
      "tracking_url": "https://t.17track.net/en#nums=ZPYAA0051111007YQ",
      "retailer_tracking_number": "TBA111189418000",
      "retailer_tracking_url": "https://www.amazon.com/progress-tracker/package/ref=oh_aui_hz_st_btn?_encoding=UTF8&itemId=khlnkqmn1111n&orderId=112-111111-6553065",
      "obtained_at": "2018-11-29T20:53:05.924Z"
    }
```

Attribute | Type | Description
--------- | ---- | -----------
merchant_order_id | String | The corresponding order identifier for which tracking was obtained.
carrier | String | (Optional) The logistics carrier that can track the package.
tracking_number | String | (Optional) The tracking number from the logistics carrier.
delivery_status | String | The current tracking status. Will be "Delivered" when the package is delivered.
tracking_url | String | (Optional) The tracking url that can be used to find the carrier and tracking number for a package.
product_ids | String | The list of product ids in the shipment. Product ids will be repeated if more than one of the product is in the shipment.
retailer_tracking_number | String | (Amazon only) (Optional) Amazon's tracking numbers are not publicly trackable but are printed on the package so we include them here.
retailer_tracking_url | String | (Optional) A url provided by the retailer than can be used to track the package
obtained_at | String | When tracking was last updated
