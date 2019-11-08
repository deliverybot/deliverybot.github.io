---
layout: post
title: Are you tracking DevOps metrics? You should be
description: Listen to the authors of the state of DevOps report on what makes for highly effective teams.
image: https://miro.medium.com/max/11150/1*hThcGlxFOknc_AY13jyAAg.jpeg
light: true
---

# Are you tracking DevOps metrics? You should be

Are you tracking DevOps metrics? You should be

The State of DevOps report every year studies organizations to evaluate the success of DevOps within the organization and compares this across industries. In 2018 the authors took on a rigorous study to find key metrics that separate out organizations that are doing DevOps successfully from organizations that are slower to adopt these new practices.

The authors unsurprisingly found that elite performers, organizations which have implemented DevOps the most effectively, deliver software more reliably, faster and with a higher quality than low DevOps performers[[1]](https://cloudplatformonline.com/rs/248-TPC-286/images/DORA-State%20of%20DevOps.pdf). Elite performers also spend more time than lower performers working on value add activities and new features compared to lower performers who spend more time resolving infrastructure and security issues.

We all want our teams to be elite performers. How do we track this? The team behind the DevOps report identified four key metrics[[1]](https://cloudplatformonline.com/rs/248-TPC-286/images/DORA-State%20of%20DevOps.pdf) which are used to determine this performance tier.

* **Deployment frequency:** For the primary application or service you work on, how often does your organization deploy code?

* **Lead time for changes:** For the primary application or service you work on, what is your lead time for changes (i.e., how long does it take to go from code commit to code successfully running in production)?

* **Time to restore service:** For the primary application or service you work on, how long does it generally take to restore service when a service incident occurs (e.g., unplanned outage, service impairment)?

* **Change failure rate:** For the primary application or service you work on, what percentage of changes results either in degraded service or subsequently requires remediation (e.g., leads to service impairment, service outage, requires a hotfix, rollback, fix forward, patch)?

These four metrics determine the tier that your organization can be categorized in. Is your lead time to deploy code to production over an hour? You are likely not an elite performer. Is your time to restore service also greater than an hour? Again, you are likely not an elite performer.

![Source](https://cloudplatformonline.com/rs/248-TPC-286/images/DORA-State%20of%20DevOps.pdf)*

What tier do you think your organization is in? Are you tracking these metrics? Even if you don’t have the detailed numbers it’s important to be able to estimate roughly these metrics as they are things that you can aim to optimize.

Importantly, this is not a theoretical exercise that has no impact on your business. If your time to restore (or sometimes named mean time to recover) is under an hour that means that if there is a service disruption your users will have a restored service quickly. The authors also go to lengths to draw strong correlation between metrics like deployment frequency and lead time to show that developers will ultimately be able to deliver software faster and more reliably.

Regardless of the report, if we think about these metrics, it inherently makes sense that teams will be more effective if they are at the top end of these metrics. Teams that deploy more frequently have less technical debt and less holding them back from deploying early and often. The less changes break CI or QA the faster teams are also going to move. What we have with this report is a really effective 1000 foot picture of your teams performance by tracking certain metrics.

### A note on measuring performance

With any sort of metrics about software delivery we have a predicament. We don’t necessarily want to aim for a higher deployment frequency. This incentivizes developers to deploy meaningless and safe code that improves scores. Instead, what your development team should be aiming for is a fast, reliable and predictable cycle. Developers should be aiming to build features quickly and safely.

For a manager, these metrics are an effective way to measure how well your tooling and infrastructure is doing in supporting your development team. These metrics are just proxies for the real truth of how well your processes are working for your developers.

### How do I get these metrics?

In building [Deliverybot](https://deliverybot.dev) we’re incorporating these metrics into the platform from day one. We want to expose all the important continuous delivery insights to teams that need them. Take a look at our [walkthrough guide](https://deliverybot.dev/docs/guide/) for setting up a full deployment pipeline with GitHub and GitHub Actions.
