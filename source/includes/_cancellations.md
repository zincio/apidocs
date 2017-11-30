## Cancelling an order

The Zinc API supports pre-shipment order cancellation on Amazon.com and
Amazon.co.uk. Simply POST to the cancellation endpoint. Note that cancelling an order
occurs after an order has been successfully placed on the API. This is distinct from
an order abort, which occurs while the order is still in progress. Cancellations
will send a cancellation request to the retailer and attempt to stop the order from
shipping and can only be initiated for order requests that were successful.

> Example cancellation POST

```shell
curl "https://api.zinc.io/v1/orders/<request_id>/cancel" \
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

### Attempting to cancel

In about 50% of cases, Amazon is unable to immediately cancel an order. Instead,
they tell Zinc that they're "Attempting to Cancel" the order. This currently
results in the _failure_ code `attempting_to_cancel` in the API. This status will
be updated when the order is either cancelled successfully or if the cancellation
fails. The Zinc API will continue to poll the retailer and attempt to figure out
the status of the order, but no guarantees can be made for how long this will take.
Once Zinc determines the actual status of the cancellation, the `attempting_to_cancel`
error code will be removed and the updated response will take its place.

> Checking on a cancelled order

```shell
curl "https://api.zinc.io/v1/cancellations/<cancellation request_id>" \
  -u <client_token>: \
```
