# Cancellations

## Initiate a cancellation

> Example cancellation

```shell
curl "https://api.zinc.io/v1/orders/<request_id>/cancel" \
  -X POST \
  -u <client_token>: \
```

> Example advanced cancellation

```shell
curl "https://api.zinc.io/v1/orders/<request_id>/cancel" \
  -X POST \
  -u <client_token>: \
  -H 'Content-type: application/json' \
  -d '{
    "merchant_order_id": "112-1234567-7272727",
    "webhooks": {
      "request_succeeded": "https://www.example.com/webhooks/success",
      "request_failed": "https://www.example.com/webhooks/failed"
     }
   }'
```

> Example cancellation response

```shell
{
  "request_id": "3f1c939065cf58e7b9f0aea70640dffc"
}
```

The Zinc API supports pre-shipment order cancellation on Amazon.com and
Amazon.co.uk. Simply POST to the cancellation endpoint. Note that cancelling an order
occurs after an order has been successfully placed on the API. This is distinct from
an order abort, which occurs while the order is still in progress. Cancellations
will send a cancellation request to the retailer and attempt to stop the order from
shipping and can only be initiated for order requests that were successful.

There aren't any required parameters for a cancellation, so you can send an authenticated post to the cancellation URL ```"https://api.zinc.io/v1/orders/<request_id>/cancel"``` without any extra parameters. However, cancellations can only be performed for a single merchant order id. If your order response has multiple merchant order ids, then you need to pass the `merchant_order_id` parameter to the request.

### Optional cancellation attributes

Attribute | Type | Description
--------- | ---- | -----------
merchant_order_id | String | The merchant order id of the order that you would like to cancel. If multiple merchant order ids exist for a particular order, this parameter is required, otherwise the cancellation request will fail
webhooks | Object | A [webhooks object](#webhooks-object) including URLs that will receive POST requests after particular events have finished

The `request_succeeded` and `request_failed` webhooks are optional. If supplied,
they will be called when the corresponding event occurs on the cancellation
request.

## Retrieve a cancellation

> Example cancellation retrieval request

```shell
curl "https://api.zinc.io/v1/cancellations/<request_id>" \
  -u <client_token>:
```

> Example cancellation retrieval response

```shell
{
  "_type": "cancellation_response",
  "merchant_order_id": "112-1234567-7272727",
  "request": {
    ...
  }
}
```

To retrieve a cancellation response given a cancellation request id, simply make a GET request to the cancellation URL ```"https://api.zinc.io/v1/cancellations/<request_id>".``` You will receive either a `request_processing` response, an error response, or a successful cancellation response of type "cancellation_response".

### Cancellation response attributes

Attribute | Type | Description
--------- | ---- | -----------
merchant_order_id | String | The merchant order id of the order that was cancelled
request | Object | The original request that was sent to the Zinc API

## Attempting to cancel

> Example `attempting_to_cancel` cancellation response

```shell
{
  "_type": "error",
  "code": "attempting_to_cancel",
  "message": "The retailer is attempting to cancel the order.",
  "data": {
    "msg": "Attempting to cancel order",
  },
  "request": {
    ...
  }
}
```

In about 50% of cases, Amazon is unable to immediately cancel an order. Instead,
they tell Zinc that they're "Attempting to Cancel" the order. This currently
results in the _failure_ code `attempting_to_cancel` in the API. This status will
be updated when the order is either cancelled successfully or if the cancellation
fails. The Zinc API will continue to poll the retailer and attempt to figure out
the status of the order, but no guarantees can be made for how long this will take.
Once Zinc determines the actual status of the cancellation, the `attempting_to_cancel`
error code will be removed and the updated response will take its place.

The `request_failed` webhook will be hit if the cancellation goes into the
`attempting_to_cancel` state. If it moves out of this state and into an error
state, the `request_failed` webhook will be hit again with the updated
cancellation response. If the cancellation moves into a successful state, the
`request_succeeded` webhook will be hit with the updated cancellation response.
Thus if you are using the `request_succeeded` and `request_failed` webhooks,
you won't need to poll the cancellation request id to learn about changes from
the `attempting_to_cancel` state.
