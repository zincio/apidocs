# Object reference

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
country | String | The ISO abbreviation for the country of the address (e.g. US). A list of all available two-letter country codes can be found [here](http://www.theodora.com/country_digraphs.html).
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

## Product offer object

Attribute | Type | Description
--------- | ---- | -----------
addon | Boolean | Whether or not the product is an addon item that can only be purchased in a bundle
condition | String | The condition of the product. Possible values are `New`, `Refurbished`, `Used - Like New`, `Used - Very Good`, `Used - Good`, `Used - Acceptable`, `Unacceptable`.
handling_days_max | Number | The maximum number of days required for shipping and handling
handling_days_min | Number | The minimum number of days required for shipping and handling
international | Boolean | Whether or not the product ships from outside of the United States
merchant_id | String | The merchant's unique identifier for the product
offerlisting_id | String | (`amazon` and `amazon_uk` only). The unique identifier that identifies an item sold by any merchant on Amazon
price | Number | The price of the item, not including shipping
ship_price | Number | The price of the shipping for the item
prime | Boolean | (`amazon` and `amazon_uk` only). Whether or not the product ships using Amazon Prime
prime_only | Boolean | (`amazon` and `amazon_uk` only). Whether or not the product only ships using Amazon Prime
seller_name | String | The name of the seller of the current offer
seller_num_ratings | Number | The number of ratings that tha seller has accumulated
seller_percent_positive | Number | Number between 0 and 100 denoting the percentage of positive ratings the seller has received
