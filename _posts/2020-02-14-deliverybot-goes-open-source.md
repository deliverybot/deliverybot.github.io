---
layout: post
title: Going open source
description: Deliverybot is going open source.
light: true
---

# Deliverybot goes open source 🎉

As stated in the last post I've been incredibly happy with the success of Deliverybot so far. The project is continuing to grow and gain traction as people really want a simple way of wiring up their continuous delivery pipelines from GitHub.

However, the project has hit a bit of a snag. As of right now there is no path to becoming verified on the GitHub store. I think this is because of some changes internally at GitHub that I'm not aware of. Right now it does not look feasible to have billing done via the GitHub marketplace in the near future. What this means is that Deliverybot will be eventually introducing billing for the hosted service using a custom provider, likely Stripe. This will involve some significant changes to the application and time invested to change the app to support this new structure.

While these changes are underway Deliverybot will still be fully available at [https://app.deliverybot.dev](https://app.deliverybot.dev) and no interruptions at all are expected to your daily workflows.

While making an investment in the core behind Deliverybot I'm going to take the time to modularize the code to allow for making the full functionality of deliverybot open source 🎉.

The https://github.com/deliverybot/deliverybot repository will be the main repository hosting deliverybot and all subpackages required to run it. It will also contain a highly modular setup which will allow for deploying to any type of infrastructure and allow the community to contribute new functionality and modules.

I'm excited for this next year as I think the project will continue to grow even larger with these changes in place :). Thanks to all the early adopters for your support so far!

---

A note on pricing: This does mean that the hosted service does not have a timeline for introducing pricing at this time.
