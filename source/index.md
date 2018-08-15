---
title: API Reference

language_tabs:
  - shell

toc_footers:
  - <a href='http://dash.zinc.io/signup'>Sign Up for a Zinc account</a>

includes:
  - authentication
  - idempotency
  - orders
  - cancellations
  - returns
  - products
  - addax
  - object_reference
  - errors
  - FAQ

search: true
---

# Introduction

Zinc lets you buy things from popular online retailers, including Amazon.com, with  a single POST request. Zinc also lets you get prices and descriptive information about products from supported retailers.

### Quick start

1. Make an account at [dash.zinc.io](https://dash.zinc.io/signup).
2. Follow the instructions in the [create an order](#create-an-order) section from the documentation below to place your first order.

# Supported retailers

The table below shows the endpoints available for each retailer. We can add additional retailers upon request -- fill out the form at the [bottom of our home page](https://zinc.io/#bottom) for a quote for a particular retailer.

Name | Retailer Code | Orders | Product Details | Product Prices | Product Search
---- | ------------- | ------ | --------------- | -------------- | --------------
AliExpress | aliexpress | Y | Y | Y | N
Amazon† | amazon | Y | Y | Y | Y
Amazon United Kingdom† | amazon_uk | Y | Y | Y | N
Amazon Canada† | amazon_ca | Y | Y | Y | N
Amazon Germany† | amazon_de | Y | Y | Y | Y
Amazon Mexico† | amazon_mx | Y | Y | Y | N
Costco | costco | Y | Y | Y | N
Walmart | walmart | Y* | Y | Y | N
Wayfair | wayfair | Y* | N | N | N
Homedepot | homedepot | Y* | N | N | Y
Lowes | lowes | N | N | Y | N

```*```Currently in unsupported beta.
```†```Prime Pantry Items, Kindles, Alexa Products, and Digital items(eBooks and Digital movies) are not supported
