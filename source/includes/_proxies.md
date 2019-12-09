# Proxies

The Zinc API interfaces with the reatilers via proxies. This enables each retailer interaction to use unique and consistent IP addressing. Due to many factors, sometimes the bulk proxies available to us become blocked by retailers. The best path to keeping your own account from being blocked is to provide your own proxy service, by either hosting your own proxy or purchasing a proxy from a provider. We call this "bring-your-own-proxy" (BYOP).

## Configure ZincAPI for your own proxy (BYOP)

> Example BYOP configuration

```shell
curl "https://api.zinc.io/v1/orders/<request_id>/cancel" \
  -X POST \
  -u <client_token>: \
```

## Query ZincAPI for current BYOP details


### BYOP attributes

Attribute | Type | Description
--------- | ---- | -----------
retailer | string | Single-word name representing the retailer
email | string | Email address used as account with the retailer
proxy_url | string | Full HTTP proxy connection string for proxy service