# Frequently Asked Questions

#####  If we wish to place a large quantitiy of orders, is it best to place a large number of orders with one product per order or a smaller number of orders with multiple products in each?
*  Either will work but there are tradeoffs. Orders with a single product will produce better error messages when something goes wrong and will not cause other items to not be ordered when individual items fail. Larger quantities in a single order will process faster as there is a cap on the number of orders that can be placed in a short time frame, and will be more likely to have free shipping, depending on the retailer.
#####  Will placing many orders in short succession cause the retailer to lock our account?
* No. Our system throttles the requests for individual accounts so we should not trigger lockouts from retailers.
