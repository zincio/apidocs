---
title: API Reference

language_tabs:
  - shell

toc_footers:
  - <a href='http://dash.zinc.io'>Sign Up for a Zinc account</a>

includes:
  - authentication
  - orders
  - products
  - object_reference
  - errors

search: true
---

# Introduction

Zinc lets you buy things from popular online retailers, including Amazon.com, with  a single POST request. Zinc also lets you get prices and descriptive information about products from supported retailers.

### Quick start

1. Make an account at [dash.zinc.io](https://dash.zinc.io).
2. Follow the instructions in the [create an order](#create-an-order) section from the documentation below to place your first order.

# Supported retailers

The table below shows the endpoints available for each retailer. We can add additional retailers upon request -- fill out the form at the [bottom of our home page](https://zinc.io/#bottom) for a quote for a particular retailer.

Name | Retailer Code | Orders | Product Details | Product Prices
---- | ------------- | ------ | --------------- | --------------
AliExpress | aliexpress | Y | Y | Y
Amazon | amazon | Y | Y | Y
Amazon United Kingdom | amazon_uk | Y | Y | Y
Amazon Canada | amazon_ca | Y | Y | Y
Amazon Mexico | amazon_mx | Y | Y | Y
Best Buy | bestbuy | | Y | Y
BH Photo Video | bhphotovideo | | Y | Y 
Costco | Y | Y | Y
East Dane | eastdane | Y | |
Google Shopping | google_shopping | | Y | Y
Newegg | newegg | Y | |
Nordstrom | nordstrom | Y | |
Overstock | overstock | | Y | Y
Sears | sears | | Y | Y
Shopbop | shopbop | Y | |
Walmart | walmart | Y | Y | Y

