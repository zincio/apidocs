# Idempotency Keys

> Example idempontency key request

```shell
curl "https://api.zinc.io/v1/orders" \
  -u <client_token>: \
  -d '{
  "idempotency_key": <idempotency_key>,
  "retailer": "amazon",
  "max_price": 2300,
  ...
  }'
```

The Zinc API does not provide out of the box deduplication of orders. Each time you send a new order request, the Zinc API will attempt to place a new order. However, the API supports idempotency for safely retrying requests without accidentally performing the same operation twice. For example, if an order request fails due to a network connection error, you can retry the request with the same idempotency key to guarantee that only a single order is created.

To perform an idempotent request, attach a unique key to request body of any POST request with the parameter `"idempotency_key": <idempotency_key>`. How you create unique keys is completely up to you. We suggest using random strings or UUIDs. We'll always send back the same response for requests made with the same key. If you receive an error on a request, you can retry by sending another request with a different idempotency key. Once you receive an error or success response, the order will no longer change.

Idempotency keys are **strongly** recommended. In the unlikely event that an API request returns a 5XX status code, duplicate requests could occur if you reattempt the request. We can't be sure of the state of the request when we return a 5XX status code, so it's best to attempt requests with an idempotency key. If you aren't using an idempotency key and you retry orders with a 5XX error code, Zinc will not refund you for duplicate orders.
