# Errors

> Example error response

```shell
{
  "_type": "error",
  "code": "product_unavailable",
  "message": "One of the products you selected is unavailable.",
  "data": {'product_id': '018293801'}
}
```

If there is an error processing a request, the result endpoint will return an error object containing three fields: `code`, `message`, and `data`.

The `code` field provides a short, unique error code describing the error situation. The `message` field provides a human readable message describing the error and is intended for the developer and not the end user. The `data` field contains specific information related to the error. For example, the maximum quantity allowed and the desired quantity would be shown for a `max_quantity_exceeded` error.

The Zinc API uses the following errors:

Error Code | Meaning
---------- | -------
account_locked | The retailer asked for additional information to verify your account.
account_locked_verification_required | The retailer emailed you a code which you must supply to continue ordering. [More info](#amazon-email-verification)
account_login_failed | We were unable to log in to the retailer with the username and password you provided.
add_on_item | Add-on items cannot be ordered individually.
additional_information_required | The retailer asked for additional account verification questions. If using the API, please add a field 'phone_number' in the billing address that matches your billing telephone number.
billing_address_refused | The billing address you provided was refused by the retailer.
brand_not_accepted | Your credit card brand is not accepted with this merchant.
cannot_schedule_delivery | Item requires scheduled delivery options that Zinc does not support.
credit_card_declined | The credit card you entered was declined.
duplicate_order | This order is a duplicate.
expired_product_id | The product_id you used is no longer supported by the retailer.
incomplete_account_setup | You attempted to place an order with an account that has not been fully set up.
insufficient_zma_balance | Insufficient funds in your Managed Account Balance to complete the order. Add more funds through your payment channel.
insufficient_variants | You did not select all required variants for a product.
internal_error | Zinc or the retailer you requested is experiencing outages. Please try again or contact support@zinc.io if this error persists.
invalid_address | The provided address was incomplete or could not be parsed. Try providing an address in canonical Zinc format rather than free-form text.
invalid_card_number | The credit card number you entered is not valid.
invalid_client_token |  Your client token is invalid.
invalid_expiration_date | The expiration date on your credit card is not valid.
invalid_gift_options | The gift options you provided were rejected by the retailer.
invalid_json | The JSON in your request could not be parsed.
invalid_login_credentials | The email and password you entered were incorrect.
invalid_payment_method | The payment method provided is not available on the retailer.
invalid_promo_code | One of the promotion codes you entered was not valid.
invalid_quantity | The quantity for one of the products does not match the one available on the retailer.
invalid_request | Validation failed on the request.
invalid_request_id | The provided request_id is invalid.
invalid_security_code | The security code you entered was declined.
invalid_shipping_method | The shipping method you selected was not valid.
invalid_variant | One of the product variants you provided was not valid.
item_not_supported | The item is not supported via the buyapi - likely a digital or handmade item
manual_review_required | This order is under manual review by Zinc -- please check back later for the status of this order.
max_price_exceeded | The retailers final price exceeds the maximum price.
max_quantity_exceeded | You have exceeded the maximum quantity available for a specific product.
max_delivery_days_exceeded | This retailers estimated delivery date exceeds the max_delivery_days parameter.
mismatching_retailer | Product URLs were provided for multiple retailers, or an explicit retailer was provided, but it did not match the provided URLs. Try again using only products from a single retailer.
no_free_shipping | Free shipping is not available for the item(s) you selected.
no_gift_shipping | No gift shipping was available on this order.
no_two_day_shipping | Two day shipping (or faster) is not available for the item(s) you selected.
order_probably_placed | This order was probably placed, but we were not able to retrieve the merchant order ids. You'll need to retry the order, so manually check the retailer website to see if the order was actually placed. If it was, cancel it and then retry the order.
payment_info_problem | There was a problem with your payment information (likely not enough gift balance).
prime_pantry_not_supported | Purchasing Prime Pantry items is not supported by the Zinc API.
product_unavailable | One of the products you selected is not available on the retailer. Either the seller selection criteria did not match any available offers or the product is out of stock and not available for purchase.
request_processing | Request is currently processing and will complete soon.
shipping_address_refused | The shipping address you provided was refused by the retailer.
shipping_address_unavailable | The item(s) cannot be shipped to the selected shipping address.
shipping_method_unavailable | The selected shipping_method is not available for the selected shipping_address.
unauthorized_access | You are not authorized to make this API call. Please contact support@zinc.io. (Usually, attempting to use Addax before it has been enabled)
unknown_retailer | The provided product URLs did not correspond to a known supported retailer. Check the URL and try again, or use a different request format with explicit retailer.
unsupported_product_id | The item product_id is not specific enough. Choose a specific product_id to order.
zma_temporarily_overloaded | The ZMA system was unable to place your order within 4 hours. Try again later, or check your parameters.
