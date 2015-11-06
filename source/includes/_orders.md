# Orders

## The order object

```shell
curl "https://api.zinc.io/
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
