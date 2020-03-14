---
layout: post
title: Deliverybot goes open source 🎉
description: An update on Deliverybot for 2020. The project is going fully open source and focusing on a self hosted model.
light: true
---

# Deliverybot goes open source 🎉

As stated in the last post I've been incredibly happy with the success of Deliverybot so far. The project is continuing to grow and gain traction as people really want a simple way of wiring up their continuous delivery pipelines from GitHub.

However, the project has hit a bit of a snag. As of right now there is no path to becoming verified on the GitHub marketplace. The verified badge is one of the key features in the success of Deliverybot as a hosted GitHub addon. It allows billing to be enabled via the GitHub marketplace and allows potential customers to feel confident in their choice that they can securely use the project.

**Because of this Deliverybot is going to adapt over the next few months into a project that you will deploy yourself on your own infrastructure.** This means that Deliverybot will also be going fully open source to allow for self hosted projects 🎉.

The https://github.com/deliverybot/deliverybot repository will be the main repository hosting deliverybot and all subpackages required to run it. It will also contain a highly modular setup which will allow for deploying to any type of infrastructure and allow the community to contribute new functionality and modules. Immediate releases will include a Firebase deployment target as well as a Kubernetes deployment target.

While these changes are underway Deliverybot will still be fully available at [https://app.deliverybot.dev](https://app.deliverybot.dev) and no interruptions at all are expected to your daily workflows. **The free hosted version of the service will be available at least until August 2020.** After this period the freely available service will be removed and can be replaced easily with a deployment on your own infrastructure. During this period the main focus on the development side will be providing simple and easy installs so that you can get Deliverybot deployed onto any infrastructure in a matter of minutes.

I'm excited for this next year as I think the project will continue to grow even larger with these changes in place :). Having the ability to introduce more collaborators and have features be completed by the community is a big addition and will allow for many more contributions than I am able to provide. Thanks to all the early adopters for your support so far!

Please reach out to [support@deliverybot.dev](mailto:support@deliverybot.dev) if you have any questions.
