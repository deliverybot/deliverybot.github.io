---
layout: post
title: The road to a production release
description: Over the last few months hundreds of users have used Deliverybot to deploy code to a variety of platforms. From Kubernetes, Firebase to Heroku. I’ve seen the value of Deliverybot go up as GitHub actions becomes a tool that more and more organizations are jumping into to test their code.
light: true
---

# The road to a production release

Over the last few months hundreds of users have used Deliverybot to deploy code to a variety of platforms. From Kubernetes, Firebase to Heroku. Deliverybot has powered automatic deployments, deployments for a single pull request and ChatOps style deployments from Slack.

Deliverybot comes from the pain when trying to scale continuous delivery in a fast moving startup. Too many times we found that running a “git revert” and waiting for CI to rollback code was too slow and impacted our users. We also found that messaging in Slack “@channel don’t deploy” didn’t scale to a larger team, or that spinning up environments per pull request involved a lot of flaky bash scripts. All these problems continue to compound and cause pain for many companies today. Wiring up good continuous delivery practices takes time that often your team may not have to invest.

The mission of Deliverybot is to give you and your team confidence that you can deploy your code quickly and safely to any environment. This goal drives us to take those common practices done manually by many companies and build them into a product that you can install in a single click on GitHub. Our initial set of features tackling this problem are:

* Rollbacks: Quick and simple, one click on the Deliverybot dashboard and your code will be rolled back with no need to re-run CI.

* Locking: Lock an environment to prevent further deployments when debugging issues.

* Slack integration: Deploy via Slack to increase visibility in your team and keep work in a single place.

* PR commands: Deploy via a slash command in your pull request to spin up a custom environment.

I’m really excited about this initial set of features. I hope you are too! Over the beta period these features have been tested and used many times, giving me confidence in Deliverybot going forwards. Over just the last month Deliverybot has processed on average 200+ deployments per day, successfully deploying code to many different environments. This means we’re ready to move on to the next stage.

Over the next few months original beta users will be asked for feedback on pricing. It’s a goal to make sure that early adopters feel heard and have a say in where this product goes. After this, pricing will roll out as generally available over the GitHub Marketplace and anyone will be able to sign up. This process will start early next year. Until then, Deliverybot will continue to be free for beta level testing. If you need more time to test your integration or wait for features to come in, let me know!

Thanks for reading :) I hope you join Deliverybot and continue to track our progress going forwards. If you want to reach out, you can reach us at <a href="mailto:support@deliverybot.dev" class="ic-open">support@deliverybot.dev</a>.
