# Returns

## Create a Return

The Zinc API also supports generating return labels. Returns are only available
on the following retailers: `amazon`, `amazon_uk`. You can create a return for
an order by hitting the `https://api.zinc.io/v1/orders/<request_id>/return`
route where `request_id` is the request id of the original order.

> Example return label request

```shell
curl "https://api.zinc.io/v1/orders/<request_id>/return" \
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

> Example return label response

```shell
{
  "request_id": "3f1c939065cf58e7b9f0aea70640dffc"
}
```

### Required attributes

Attribute | Type | Description
--------- | ---- | -----------
products | List | A list of [product objects](#product-object) that should be returned
reason_code | String | The reason for the return. This is passed directly to
Amazon. Reason codes will vary depending on Amazon country. Many users have had
success using "inaccurate website description" for Amazon.com and "description
on website was not accurate" for Amazon.co.uk. Note that the reason_code must
be an exact match with the reason code dropdown available on Amazon.
method_code | String | The method of returning the specified products. This is
passed directly to Amazon. The available options may vary based on Amazon
country and customer address. Note that `UPS Dropoff` is the only method
supported for automatic refunds on Zinc Managed Account orders. If you'd like
to use a different method, you'll need to manually request a refund.
explanation | String | Any extra information that will be passed to Amazon or
the Amazon seller. It is required for some return reasons.

### Optional attributes

Attribute | Type | Description
--------- | ---- | -----------
webhooks | Object | A [webhooks object](#webhooks-object) including URLs that
will receive POST requests after particular events have finished.
cancel_pending | Boolean | Whether or not this request should cancel any
pending returns while creating a new return. If false, the request will return
a `return_in_progress` error code if a pending return already exists. Defaults
to false.
return_address | Object | An [address object](#address-object) from which the
return is sent. If not provided, the default return address from Amazon will
be used.

You can use the `return_in_progress` error to check the status of your return.
Just supply an invalid `method_code` like "Dummy Method Code". If the return is
in progress, you'll get the status back with the error. If the return
is not yet started, we'll be unable to start a return because the method code
does not exist.

## Retrieving a return

> Example return retrieval request

```shell
curl "https://api.zinc.io/v1/returns/<request_id>" \
  -u <client_token>:
```

> Example return retrieval response

```shell
{
  "_type": "return_response",
  "merchant_return_id": "1b95c9d5-6a4c-409d-9598-6e5da88b91e7",
  "return_by": "2018-02-01T00:00:00",
  "label_urls": [
    "https://zincapi.s3.amazonaws.com/2791c7cf243f44349ac1fbf179dd7428_return_label.pdf"
  ],
  "request": {
    ...
  }
}
```

> Example `return_in_progress` return retrieval response

```shell
{
  "_type": "error",
  "code": "return_in_progress",
  "message": "A return is currently in progress for the items you specified.",
  "data": {
    "status": {
      "status": "Refund issued",
      "description": "$6.30 refund issued on Nov 22, 2017."
    },
    "error": "Tried to cancel but could not find cancel button",
  },
  "request": {
    ...
  }
}
```

### Return response attributes

Attribute | Type | Description
--------- | ---- | -----------
merchant_return_id | String | A unique identifier for the return
return_by | String | The date before which the products must be returned by
label_urls | Array | A list of URLs for the generated return labels
request | Object | The original request that was sent to the Zinc API
