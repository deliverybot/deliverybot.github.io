---
layout: page
title: Quickstart
description: Install the Deliverybot GitHub App, fork an example repository and ship your first deployment in a few minutes.
---

# Quickstart

Deliverybot is a GitHub App. To get started with deployments you need a
repository with the Deliverybot app installed on it. The steps below use the
hosted app at [app.deliverybot.dev]({{ site.deliverybot_url }}) and one of the
example repositories. Prefer to run it yourself? See
[self-hosting](/docs/deploying/).

### 1. [Fork the example repository][example]{:target="_blank"}

Fork the [example repository][example]{:target="_blank"}. Its deployments
don't go anywhere, but it shows the whole flow.

### 2. [Install the Deliverybot GitHub App][install]{:target="_blank"}

Install the app and give it access to your fork. Deliverybot only needs
read access to code to see pushes and to read `.github/deploy.yml`; see the
[security overview](/terms/security/) for every permission it asks for.

### 3. Push a commit to watch the workflows kick off!

Go to your repository and push a commit, then open the
[dashboard]({{ site.deliverybot_url }}) to watch the deployment and deploy any
commit with a click.

### 4. [Install integrations][integrations]{:target="_blank"}

Install integrations like Slack or Helm to build a workflow for your team. Visit
our [integrations page][integrations]{:target="_blank"} for more information.

## Next

Once you have a working example read through the [guide](/docs/guide/) for more
information on how to setup complex workflows.

[install]: {{ site.install_url }}
[how]: /docs/how-it-works/
[example]: https://github.com/deliverybot/example
[integrations]: /integrations/
