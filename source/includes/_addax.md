# Zinc Managed Accounts

## Overview

Zinc's Managed Accounts allows customers to place orders without worrying about
creating and managing Amazon accounts. Instead, API users can fund a balance
with Zinc using PayPal or wire transfer. A network of Pro-buyers will then place
orders on your behalf.

Managed accounts is currently available for Amazon and Amazon UK.

## Using Managed Accounts

Zinc Managed Accounts is currently available by invite only. Please contact
sales@zinc.io and mention Managed Accounts. You can also contact this address if
you need more information to determine if Managed Accounts are right for you.

## Funding your account

> Check account balance and view past transactions

```shell
curl "https://api.zinc.io/v1/addax/balance" -u <client_token>:
curl "https://api.zinc.io/v1/addax/transactions?count=100&offset=0" -u <client_token>:
```

Please contact sales@zinc.io. They'll help set up funding options taylored for
your needs. Generally, funding is performed either through PayPal's Mass Pay
option or via wire transfer directly to our bank.

You'll need to fund your account before you'll be able to place orders.

You can check your account balance and transactions at any time.

Note: these funds are used to pay for the cost of your order on Amazon, but
you'll still be billed the normal ordering fee at the end of the month. Your
Zinc sales contact can provide more information about billing.

## Create an order

Follow the [standard documentation for creating orders]() with two changes:

1. Add `"addax": true` to your request body.
2. Do not supply the `retailer_credentials`, `payment_method`, or `billing_address` keys.

All other ordering features and options work as specified in the standard
documentation.

Successful orders will result in a transaction decreasing your account balance
for the currency of the market. Failed orders will not cost you anything.

## Cancelling orders

The Zinc API supports pre-shipment order cancellation on Amazon.com and
Amazon.co.uk. Simply POST to the cancellation endpoint.

> Example cancellation POST

```shell
curl "https://api.zinc.io/v1/orders/<order_id>/cancel" \
  -X POST \
  -u <client_token>: \
  -H 'Content-type: application/json' \
  -d '{
    "webhooks": {
      "request_succeeded": "https://www.example.com/webhooks/success",
      "request_failed": "https://www.example.com/webhooks/failed"
     }
   }'
```

The `request_succeeded` and `request_failed` webhooks are optional. If supplied,
they will be called when the corresponding event occurs on the cancellation
request.

### `attempting_to_cancel`

In about 50% of cases, Amazon is unable to immediately cancel an order. Instead,
they tell Zinc that they're "Attempting to Cancel" the order. This currently
results in a _failure_ code in the API. We hope to improve this in the future to
automatically update when the order is either cancelled or shipped. At the
moment, however, you'll need to manually open a refund request for these cases.
See below for more details.

> Checking on a cancelled order

```shell
curl "https://api.zinc.io/v1/cancellations/<cancellation request_id>" \
  -u <client_token>: \
```

## Returns

The Zinc API also supports generating return labels through Amazon.

> Example return label request

```shell
curl "https://api.zinc.io/v1/orders/<order_id>/return" \
  -X POST \
  -u <client_token>: \
  -H 'Content-type: application/json' \
  -d '{
    "webhooks": {
      "request_succeeded": "https://www.exaple.com/webhooks/return/success",
      "request_failed": "https://www.exaple.com/webhooks/return/failed",
    },
    "products": [{"product_id": "B0000001234", "quantity": 1}],
    "reason_code": "inaccurate website description",
    "method_code": "UPS Dropoff",
    "explanation": "Additional details for Amazon seller",
    "cancel_pending": false
  }'
```

`webhooks` and `cancel_pending` are optional, but the other four fields are required.

`products` is in the same format as for an order. It determines which products
of a multi-item order to return.

`reason_code` and `method_code` are passed directly to Amazon. The available
options may vary based on Amazon country and customer address. However, `UPS
Dropoff` is the only method supported for automatic refunds. If you'd like to
use a different method, you'll need to manually request refunds as specified
below.

Many users have had success using "inaccurate website description" for
Amazon.com and "description on website was not accurate" for Amazon.co.uk.

`explanation` is extra information that will be passed to Amazon or the Amazon
seller. It is required for some return reasons.
```
By default, if a return is already in progress, we'll respond with a
`return_in_progress` error code and include the status of the return. You may
override this behavior by setting `cancel_pending` to `true`. This will cause us
to cancel any pending returns before attempting to place the return.

You can also use the new `return_in_progress` error to check the status of your
return. Just supply an invalid `method_code` like "Dummy Method Code". If the
return is in progress, you'll get the status back with the error. If the return
is not yet started, we'll be unable to start a return because the method code
does not exist.

> Checking on a returned order

```shell
curl "https://api.zinc.io/v1/returns/<return request_id>" \
  -u <client_token>: \
```

## Refunds

In some cases, a Managed Account order might initially succeed (and thus charge
your account) but later need to be reversed. For example, your buyer might want
to return the product, or the order may be cancelled by the Amazon seller.

To address these cases, we've created a refund process. All refunds will be sent
to the Pro-buyer responsible for your order for them to approve or decline. Any
declined refunds may be appealed to support@zinc.io.

When there's a successful cancellation (see above) or a return created through
the Zinc API is delivered back to Amazon, we'll automatically start the refund
process for your account. In other cases, you'll need to request a refund
manually.

### Checking refund status

Make a GET request to the refund endpoint.

> Check refund status

```shell
curl "https://api.zinc.io/v1/orders/<order_id>/refund" \
  -u <client_token>:
```

`refund_state` will be one of the following values:

Value | Description
----- | -----------
(null) | No refund has been requested.
requested | A refund has been requested. The Pro-buyer has 30 days to respond.
refunded | A refund has been issued to your account.
declined | The Pro-buyer has declined the refund request. Please contact support@zinc.io if you need more information.

### Requesting a refund manually

Make a POST request to the refund endpoint.

> Create refund

```shell
curl "https://api.zinc.io/v1/orders/<order_id>/refund" \
  -X POST \
  -u <client_token>: \
  -H 'Content-type: application/json' \
  -d '{"reason": "refund_reason_code", "note": "Please include as much detail as possible in the note."}'
```

Valid reason codes include:

Code | Description
---- | -----------
`attempting_to_cancel` | You attempted to cancel the order, but are unsure if it completed. The Pro-buyer will refund if possible and decline if the order actually went through.
`return_completed` | The item was returned, but not using a label that was generated by Zinc.
`other` | Please contact support@zinc.io and explain why you need to use this code.

If none of these reason codes cover your use case, please contact
support@zinc.io and use the code: `other`.
