---
layout: post
title: ChatOps deployments with Deliverybot
description: Deploy your code on GitHub right from Slack.
---

# ChatOps deployments with Deliverybot

![slack-app](/assets/images/deploy-slack.png)

ChatOps is a term that's been coined recently to refer to using Slack or other
chat services to deploy code or run other operations. It's a simple concept,
to gain visibility over deployments and other operational concepts, we expose to
the developers tools in Slack so that they can deploy code, look at graphs or
do other operational things within a conversation channel.

ChatOps is great for building living documentation for your team. Onboarding a
new team member? They can watch Slack as a way of learning how deployments
happen and even chime in with feedback or questions in real time.

The Deliverybot Slack integration is simple. It simply takes the functionality
you get from the dashboard where clicking on a commit deploys that code and
moves it into Slack.

Deploying code looks like the following slash command:

```
/deliverybot deploy deliverybot/example@heads/master production
```

That's it! All your current integrations with Deliverybot will work just the
same. Just call `/deliverybot help` if you have any questions.
[Install the Slack app to get started]({{site.slack_url}}).

*If you haven't yet started with Deliverybot, [start here](/docs/).*

