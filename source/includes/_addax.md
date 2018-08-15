# Zinc Managed Accounts

## Overview

Zinc Managed Accounts allow customers to place orders without worrying about
creating and managing their own Amazon accounts. Instead, users of a Managed Account can fund a balance
with Zinc using PayPal or wire transfer, which Zinc will then debit to place orders on your behalf.

Managed accounts are currently available for Amazon and Amazon UK.

Zinc Managed Accounts are currently available by invite only. Please contact
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

Follow the [standard documentation for creating orders](#create-an-order) with two changes:

1. Add `"addax": true` to your request body.
2. Do not supply the `retailer_credentials`, `payment_method`, or `billing_address` keys.

All other ordering features and options work as specified in the standard
documentation.

Successful orders will result in a transaction decreasing your account balance
for the currency of the market. Failed orders will not cost you anything.

## Cases

In some cases, a Managed Account order might initially succeed (and thus charge
your account) but later need to be reversed. For example, your buyer might want
to return the product, or the order may be cancelled by the Amazon seller.

Cases are automatically opened by Zinc when an order is cancelled, a return is
requested, and for other scenarios. You can also open a Case to ask for
assistance with a failed return, cancellation, and other issues. Cases are
regularly updated by Zinc with information about the status of the case. 

### Checking the status of a Case

Make a GET request to the case endpoint

> Check Case status
```shell
curl "https://api.zinc.io/v1/orders/<order_id>/case" \
  -u <client_token>:
```

`state` will be one of the following values:
Case State | Description
----- | -----------
(null) | No case has been opened for this order.
open | A case has been opened for this order.
closed | A case has been closed for this account.

`messages` contains the entire history of a case, and can have any of these values for `type`:
Message Type | Description
----- | -----------
case.opened.return.request_label | A case has been opened for a return label
case.opened.nondelivery.not_delivered | A case has been opened for a non-delivery issue
case.opened.nondelivery.damaged | A case has been opened for a damaged package
case.opened.nondelivery.empty_box | A case has been opened for an empty box
case.opened.tracking.request_update | A case has been opened requesting an update on an order status
case.opened.cancel.forced_cancellation | A case has been opened for a order force cancelled by the source
case.opened.other | A catch-all category for a case
case.freetext | A generic, free text case response
case.return.label_generated | A return label has been geneerated
case.return.label_generation_failed | Return label generation failed
case.return.status_updated | The case status has been updated
case.refund.partial | The case has resulted in a partial refund being issued
case.refund.full | The case has resulted in a full refund being issued
case.closed | A case has been closed

The most up to date case status is represented by the latest object in the `messages` list.

### Opening a Case

Make a POST request to the case endpoint

> Create a new Case
```shell
curl "https://api.zinc.io/v1/orders/<order_id>/case" \
  -X POST \
  -u <client_token>: \
  -H 'Content-type: application/json' \
  -d '{"reason": "return.request_label", "message": "I need a return label"}'
```

To open a case you must use one of the following values for `reason`:

Reason | Description
----- | -----------
return.request_label | Request a return label
nondelivery.not_delivered | Package never delivered
nondelivery.damaged | Item or package damaged
nondelivery.empty_box | Empty box delivered
tracking.request_update | Request update
cancel.forced_cancellation | Forced cancellation by seller
other | Other

### Updating a Case

You can append a freetext `message` to a Case by POSTing a `message` without a `reason`:

> Update a Case
```shell
curl "https://api.zinc.io/v1/orders/<order_id>/case" \
  -X POST \
  -u <client_token>: \
  -H 'Content-type: application/json' \
  -d '{"message": "I have an update on this case"}'
```

## Refunds [DEPRECATED]

In some cases, a Managed Account order might initially succeed (and thus charge
your account) but later need to be reversed. For example, your buyer might want
to return the product, or the order may be cancelled by the Amazon seller.

To address these cases, we've created a refund process. All refunds will be sent
to Zinc, which we will approve or decline. Any
declined refunds may be appealed to support@zinc.io.

When there's a successful cancellation (see above) or a return created through
the Zinc API is delivered back to Amazon, we'll automatically start the refund
process for your account. In other cases, you'll need to request a refund
manually.

### Checking refund status [DEPRECATED]

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
requested | A refund has been requested. Zinc has 30 days to respond.
refunded | A refund has been issued to your account.
declined | Zinc has declined the refund request. Please contact support@zinc.io if you need more information.

### Requesting a refund manually [DEPRECATED]

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
attempting_to_cancel | You attempted to cancel the order, but are unsure if it completed. Zinc will refund if possible and decline if the order actually went through.
return_completed | The item was returned, but not using a label that was generated by Zinc.
other | Please contact support@zinc.io and explain why you need to use this code.

If none of these reason codes cover your use case, please contact
support@zinc.io and use the code: `other`.
