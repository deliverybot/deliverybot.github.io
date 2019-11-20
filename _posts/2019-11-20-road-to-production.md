---
layout: post
title: The road to a production release
description: Over the last few months hundreds of users have used Deliverybot to deploy code to a variety of platforms. From Kubernetes, Firebase to Heroku. I’ve seen the value of Deliverybot go up as GitHub actions becomes a tool that more and more organizations are jumping into to test their code.
light: true
---
# The road to a production release

Over the last few months hundreds of users have used Deliverybot to deploy code to a variety of platforms. From Kubernetes, Firebase to Heroku. I’ve seen the value of Deliverybot go up as GitHub actions becomes a tool that more and more organizations are jumping into to test their code.

Deliverybot comes from the pain when trying to scale continuous delivery in a fast moving startup. Too many times we found that running a “git revert” and waiting for CI to rollback code was too slow and impacted our users. Messaging in Slack “@channel don’t deploy” didn’t scale to a larger team. Spinning up environments per pull request involved a lot of flaky bash scripts. All these problems continue to compound and cause pain for many companies today. Wiring up good continuous delivery practices takes time.

The mission of Deliverybot is to give you and your team confidence that you can deploy your code quickly and safely to any environment. The goal should drive us to take those common practices done manually by many companies and build them into a product that you can install in a single click on GitHub. We’ve gone part of that way with the current feature set:

* Rollbacks: Quick and simple, one click on the Deliverybot dashboard and your code will be rolled back with no need to re-run CI.

* Locking: Lock an environment to prevent further deployments when debugging issues.

* Slack integration: Deploy via Slack to increase visibility in your team and keep work in a single place.

* PR commands: Deploy via a slash command in your pull request to spin up a custom environment.

I’m really excited about this initial set of features. I hope you are too! Over the beta period these features have been tested and used many times, giving me confidence in Deliverybot going forwards. Over just the last month Deliverybot has processed on average 200+ deployments per day, successfully deploying code to many different environments. This means we’re ready to move on to the next stage.

Over the next few months original beta users will be asked for feedback on pricing via email. It’s a goal to make sure that early adopters feel heard and have a say in where this product goes. After this, pricing will roll out as generally available over the GitHub Marketplace and anyone will be able to sign up. This process will start early next year. Until then, Deliverybot will continue to be free for beta level testing. If you need more time to test your integration or wait for features to come in, let me know!

### Stability and security

Investing in Deliverybot means relying on us to deliver a key part of your infrastructure. How do you have confidence that Deliverybot is going to be around and be able to scale to suit your needs?

1. First of all, the core featureset in Deliverybot is (and always will be) open source at [https://github.com/deliverybot/deliverybot](https://github.com/deliverybot/deliverybot). Your team can run this if they need to build this on their own.

1. Going forwards I want to invest in building a self-hosted version for organizations that want to use the code in on-premises environments. Stay tuned for this.

1. Deliverybot is hosted using Serverless technologies on Google Cloud. The service stores very little state which allows us to scale infinitely to more and more traffic as it comes on.

Do you have any more questions about this? Reach out, I’m happy to discuss this in more detail. Also, I’ve recently released some new [security documentation](https://deliverybot.dev/terms/security/) which may be of interest.

Thanks for reading :) I hope you join Deliverybot and continue to track our progress going forwards. If you want to reach out, contact us at support@deliverybot.dev.
