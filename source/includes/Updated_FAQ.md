# Frequently Asked Questions

###  If we wish to place a large quantity of orders, is it best to place a large number of orders with one product per order or a smaller number of orders with multiple products in each?

* Either will work but there are tradeoffs. Orders with a single product will produce better error messages when something goes wrong and will not cause other items to not be ordered when individual items fail. Larger quantities in a single order will process faster as there is a cap on the number of orders that can be placed in a short time frame, and will be more likely to have free shipping, depending on the retailer.

###  Will placing many orders in short succession cause the retailer to lock our account?

* No. Our system throttles the requests for individual accounts so we should not trigger lockouts from retailers.

### What products can I buy with the Automatic Ordering API?

* The API supports most products, but there are some notable exceptions: digital products (such as e-books), gift cards, Prime Pantry, Amazon Fresh items, and speciality Amazon products (such as the Echo and Kindle) are not supported. Also, products that require local pickup, scheduled delivery, age verification, or any other extra specialty step during checkout will fail.

### I submitted a lot of orders at once, why are they processing slower?

* They are not, they are just queued on our end. For each Amazon account, orders are placed one by one, since you can't have more than one shopping cart at a time. For example, each Amazon order takes about 2 minutes to process, so if you submit 10 orders at the same time for the same Amazon account, the last order will take about 20 minutes to process. If you need orders placed faster, consider using multiple retailer accounts.

### I received an internal_error response from the Automatic Ordering API. How do I handle this?

* Internal errors are caused by either an outage on the retailer's side (e.g. Amazon or Walmart are having issues) or a temporary Zinc problem. Internal errors are safe to retry -- we recommend using exponential backoff to place another order if you receive an internal error.

### My item has variants, how do I ensure I order the correct item with Zinc? 

* Each Amazon ASIN corresponds to a single variant. Please use our free Google Chrome extension [YakPal](https://chrome.google.com/webstore/detail/yakpal/gcjaibancpkbofjlkgihljhdheaokifb?hl=en) to look up variants for any product page on Amazon. Simply pass the ASIN to Zinc under product_id.

### How can I disable using a max_price?

* You can set max_price to an arbitrarily high number, such as 10000000, to avoid getting a max_price_exceeded error.

### I am receiving an Amazon security code text asking me to verify my identity when placing the order.

* This is common when placing orders on a new account for the first time, since we are accessing Amazon from a new IP address. See our documentation about [Amazon Email Verification](http://docs.zincapi.com/#amazon-email-verification).

### My payment methods are saved in my Amazon account. Can I just pass Zinc the last 4 digits of my credit card during checkout?

* You need to provide us the the full card because Amazon asks to verify it when shipping to new addresses. Alternative, you can select gift cards as your payment method (and you can use [Piranha](http://piranha.zinc.io) to both purchase gift cards as well as automatically load them onto your Amazon 
accounts).

### When will my tracking number post?

* Our algorithm checks at various times based on our knowledge of when tracking becomes available. We post this response via webhook.

### What is the structure of the POST body sent to the webhooks? 

* All webhook POST bodies are identical to the Order Response object outlined [here](http://docs.zincapi.com/#retrieving-an-order).

### Can I authenticate Zinc webhooks?

* Yes, use basic auth in the webhook URL as detailed by [RFC 1738](http://www.ietf.org/rfc/rfc1738.txt): “https://<username>:<password>@some.server.com/webhookpath” where <username> and <password> are the basic auth username and password respectively.

### I am not receiving POSTs to the my webhook URLs.

* Make sure that your server is configured to accept POST requests from any other server. To debug this, we recommend creating a [requestbin](https://requestb.in/) URL, passing that in as your webhook, and looking at what the data that we returns looks like. This will also confirm to you that our webhooks are working properly.

### Why am I getting multiple POSTs to my “order_placed” or other webhook?

* We will retry POSTing the webhook until you return a 200 status code, so make sure you are returning a 200 at your webhook endpoint.

### The Product Details/Product Offers API is taking a long time to respond. How do I speed it up?

* Our API is optimized for throughput, not latency, and we don't make any latency guarantees. If you want to do a real-time call (your users wait on the results of the call) it's best to try these things:

  * If your users are using a limited number of products, cache the data on your end regularly, and then display it to them from your cache in real-time when they request it.
  * Make sure you have set the [max_age](https://docs.zincapi.com/#product-details) parameter to the maximum value that's allowable for your needs.
  * We have other techniques for speeding up the API--contact us for more details.
