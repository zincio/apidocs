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

Zinc offers the underlying API for apps that need real-time order placing capabilities. With a single POST request, you can order an item from one of our supported retailers.

### Quick start

1. Make an account at [dash.zinc.io](https://dash.zinc.io).
2. Follow the instructions in the [create an order](#create-an-order) section from the documentation below to place your first order.

# Supported retailers

The table below shows the endpoints available for each retailer. We can add additional retailers upon request -- fill out the form at the [bottom of our home page](https://zinc.io/#bottom) for a quote for a particular retailer.

Name | Retailer Code | Orders | Product Details | Product Prices
---- | ------------- | ------ | --------------- | --------------
Amazon | amazon | Y | Y | Y
Amazon United Kingdom | amazon_uk | Y | Y | Y
Amazon Canada | amazon_ca | Y | |
Nordstrom | nordstrom | Y | |
Shopbop | shopbop | Y | |
East Dane | eastdane | Y | |
Newegg | newegg | Y | |
Walmart | walmart | Y | Y | Y
Google Shopping | google_shopping | | Y | Y

