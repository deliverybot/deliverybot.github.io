---
layout: post
title:  What is the GitHub deployments API?
description: Let's talk about this often forgotten feature hidden in the GitHub api.
---

# What is the GitHub deployments API?

### A lesser known tool to ship your code that’s baked right in to GitHub.

*This is part of a series of posts on building [Deliverybot](http://deliverybot.github.io/), a deployment tool for simple deployment automation on GitHub.*

A year or so ago I came across this interesting feature in GitHub called the deployments api. It seemed like a bit of a lost section in the GitHub docs, disconnected from other component and unlike pretty much everything else in GitHub I really hadn’t used this. I’ve spent some time investigating the deployments API over the last month or so and wanted to explain this for those of you who have hit this and wondered, what is this thing?

The GitHub deployments API is effectively a decoupled API for **triggering** deployments. GitHub doesn’t try and actually deploy the code for us, it just gives us an event to allow our own system to respond to and actually deploy the code.

The workflow seems relatively simple:

* GitHub kicks off the deployment event with some payload.

* My system receives an event from GitHub and runs the actual deployment.

When I figured this out I thought this was pretty cool. I can replace my Jenkins pipeline with something more modern and API driven. Additionally, it decouples tools from one another by using GitHub as the source of truth for all the automation that needs to take place. Push events dictate when my code builds and deployment events dictate when my code is deployed.

GitHub has also added in some new UI which gives a picture of deployments for a specific pull request:

![](https://cdn-images-1.medium.com/max/2896/1*ridTijg0ADBaF74zQs9EsA.png)

We can also view a list of deployments to all environments by visiting the environments tab on your project:

![](https://cdn-images-1.medium.com/max/3980/1*lNvo8KfH2Y6cgESST2zN1Q.png)

### Completing the picture

So far so good. However, when I went to wire up my integration I realized there is a piece missing from this story. The workflow of the GitHub deployments API looks roughly like the picture below.

```
+---------+             +--------+            +-----------+        +-------------+
| Tooling |             | GitHub |            | 3rd Party |        | Your Server |
+---------+             +--------+            +-----------+        +-------------+
     |                      |                       |                     |
     |  Create Deployment   |                       |                     |
     |--------------------->|                       |                     |
     |                      |                       |                     |
     |  Deployment Created  |                       |                     |
     |<---------------------|                       |                     |
     |                      |                       |                     |
     |                      |   Deployment Event    |                     |
     |                      |---------------------->|                     |
     |                      |                       |     SSH+Deploys     |
     |                      |                       |-------------------->|
     |                      |                       |                     |
     |                      |   Deployment Status   |                     |
     |                      |<----------------------|                     |
     |                      |                       |                     |
     |                      |                       |   Deploy Completed  |
     |                      |                       |<--------------------|
     |                      |                       |                     |
     |                      |   Deployment Status   |                     |
     |                      |<----------------------|                     |
     |                      |                       |                     |
```

What this means is that the story of a deployment looks like this:

1. *Tooling calls a GitHub API to say “deploy this commit”*

1. GitHub fires webhooks to a system that takes action deploying the commit.

1. Your code is then deployed when this system receives the webhook.

In the third step we can use GitHub actions or we can even just fire up a lambda function to listen for http events to deploy our code. The second step is all handled by GitHub. The first step of this story here is the problem. We don’t *yet* have a standardized toolkit to call this API.

I think immediately of a few things I would want here:

1. I want a way of automatically triggering this API when a push event occurs on a branch.

1. I want a way of deploying from Slack (ChatOps) using cool slash commands.

1. I want to deploy ephemeral environments using these in pull requests.

There is also the opportunity for building advanced workflows on top of this. We can require that certain status checks are passing before a deployment can proceed. We can also listen to deployment success events to trigger other deployments to different environments. Having an API and even driven platform gives us a lot of power and freedom.

### What is [Deliverybot](https://deliverybot.dev)?

When researching all this tooling I wanted a GitHub app to fill these gaps. Deliverybot is an answer to these gaps. It allows you to simply click on a commit and fire off a deployment event to let GitHub actions or your own tooling handle the event and actually execute the deployment. Give it a shot and let me know what you think!

*Thanks for reading and stay tuned for more good read on deployments and DevOps. Follow me on twitter [@colinjfw](https://twitter.com/@colinjfw).*
