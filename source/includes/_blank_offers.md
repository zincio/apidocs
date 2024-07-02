# Blank Offers Page

Recently, Amazon has begun to return an empty page instead of a list of product offers.
This appears to be an anti-bot response by Amazon, caused by the IP addresses used to place orders.

This appears to primarily affect the UK, DE, and IN regions. US, CA, and FR currently appear unaffected.

When this happens, our ordering agent will respond with the error `amazon_antibot_blank_offers_page`.

This is done because we cannot guarantee full ordering safeguards without accessing this offers page.

There are two workarounds that can be attempted:

1. Set `take_buybox_offers` to true on the top level of the ordering object.
   This will automatically accept the first offer on the Amazon product page,
   without applying any `seller_selection_criteria`. For safety, it is
   suggested to set `max_price` and `max_delivery_days` as well. Because this
   accepts the default offer, it will not require loading the broken page.

2. Bring your own proxy with BYOP. Ideally, you should use a real
   residential IP that is dedicated to your ordering flow. For more details,
   review the [BYOP docs](/#proxies).

We will continue to monitor the situation and update this page as new details emerge.
