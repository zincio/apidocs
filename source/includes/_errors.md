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

The `code` field provides a short, unique error code describing the error situation. The `message` field provides a human readable message describing the error and is intended for the developer and not the end user. The `data` field contains specific information related to the error (for example, the maximum quantity allowed and the desired quantity would be shown for a `max_quantity_exceeded` error).

The Zinc API uses the following errors:

Error Code | Meaning
---------- | -------
invalid_json | The JSON in your request could not be parsed.
internal_error | Zinc or the retailer you requested is experiencing outages. Please try again or contact support@zinc.io if this error persists.
invalid_client_token |  Your client token is invalid.
product_unavailable | The product_id you used is being phased out by the retailer -- please update your product_id database accordingly. (On Amazon, this means that the offers page at [amazon_domain]/gp/offer-listing/[your_ASIN] has a more recent ASIN for that same product).
request_processing | Request is currently processing and will complete soon.
invalid_request_id | The provided request_id is invalid.
invalid_request | Validation failed on the request.
max_quantity_exceeded | You have exceeded the maximum quantity available for a specific product.
invalid_shipping_method | The shipping method you selected was not valid.
shipping_address_refused | The shipping address you provided was refused by the retailer.
billing_address_refused | The billing address you provided was refused by the retailer.
credit_card_declined | The credit card you entered was declined.
invalid_security_code | The security code you entered was declined.
invalid_card_number | The credit card number you entered is not valid.
brand_not_accepted | Your credit card brand is not accepted with this merchant.
invalid_login_credentials | The email and password you entered were incorrect.
duplicate_order | This order is a duplicate.
add_on_item | Add-on items cannot be ordered individually.
invalid_promo_code | One of the promotion code you entered was not valid.
no_two_day_shipping | Two day shipping (or faster) is not available for the item(s) you selected.
no_free_shipping | Free shipping is not available for the item(s) you selected.
invalid_quantity | The quantity for one of the products does not match the one available on the retailer.
additional_information_required | The retailer asked for additional account verification questions. If using the API, please add a field 'phone_number' in the billing address that matches your billing telephone number.
payment_info_problem | There was a problem with your payment information (likely not enough gift balance).
expired_product_id | The product_id you used is no longer supported by the retailer.
insufficient_variants | You did not select all required variants for a product.
