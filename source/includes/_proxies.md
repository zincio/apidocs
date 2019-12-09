# Proxies

The Zinc API interfaces with the retailers via proxies. This enables each retailer interaction session to use unique and consistent IP addressing. Due to many factors, sometimes the bulk proxies available to us become blocked by retailers. The best path to keeping your own account from being blocked is to provide your own proxy service, by either hosting your own proxy or purchasing a proxy from a provider. We call this "bring-your-own-proxy" (BYOP).

## Configure ZincAPI for your own proxy (BYOP)

> Example BYOP configuration

```shell
curl "https://api.zinc.io/v1/proxies/byop" \
  -X PUT \
  -u <client_token>: \
  -d '{"retailer":"amazon","email":"youremail@youremail.com","proxy_url":"http://proxy_user:proxy_password@192.168.1.1:1234"}'
```

## Query ZincAPI for current BYOP details

> Example query of existing BYOP configuration

```shell
curl "https://api.zinc.io/v1/proxies/byop" \
  -X GET \
  -u <client_token>: \
  -d '{"retailer":"amazon","email":"youremail@youremail.com"}'
```

### BYOP attributes

Attribute | Type | Description
--------- | ---- | -----------
retailer | string | Single-word name representing the retailer
email | string | Email address used as account with the retailer
proxy_url | string | Full HTTP proxy connection string for proxy service

The proxy_url components are as follows:

Component | Description
--------- | ---- | -----------
proxy_user | Username for the proxy service account
proxy_password | Password for the proxy service account
proxy_ip | IP address of the proxy server (sample shows 192.168.1.1)
proxy_port | Port number of the proxy server (sample shows 1234)
