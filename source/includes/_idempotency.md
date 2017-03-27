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

To perform an idempotent request, attach a unique key to request body of any POST request with the parameter `"idempotency_key": <idempotency_key>`. How you create unique keys is completely up to you. We suggest using random strings or UUIDs. We'll always send back the same response for requests made with the same key.
