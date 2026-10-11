---
layout: post
title: Deliverybot is back
description: Deliverybot is being revived as a hosted service at app.deliverybot.dev, on a modernized open source codebase.
light: true
---

# Deliverybot is back

In 2020 Deliverybot [went open source](/2020/02/14/deliverybot-goes-open-source/)
and the hosted service was wound down, leaving self-hosting as the only way to
use it. Development stalled not long after.

Deliverybot is now being picked up again, and the hosted version is coming
back at [app.deliverybot.dev]({{ site.deliverybot_url }}).

## What changed

The [codebase]({{ site.source_url }}) has been brought up to date:

- It runs on Node.js 22 and the latest Probot.
- Data, sessions and background jobs live in PostgreSQL, and sessions are
  stored server-side with the GitHub token encrypted.
- It ships as a container image with Kubernetes manifests, so it is easy to
  [run yourself](/docs/deploying/) too.

Your `.github/deploy.yml` works the same as before, and the
[docs](/docs/) and [guide](/docs/guide/) still apply.

## Getting started

[Install the GitHub App]({{ site.install_url }}), push a commit and watch it
deploy. The [quickstart](/docs/quickstart/) walks through it with one of the
example repositories.

Found a bug or have an idea? [Open an issue]({{ site.community_url }}) or
email [{{ site.support_email }}](mailto:{{ site.support_email }}).
