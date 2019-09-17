---
layout: page
title: Self hosting
---

# Self hosting

Deliverybot can be deployed as a GitHub app on your own infrastructure.

## Environment Variables

* `APP_ID` (required) GitHub app id.
* `PRIVATE_KEY` (required) GitHub app private key.
* `WEBHOOK_SECRET` (required) GitHub app webhook secret.
* `CLIENT_ID` (required) GitHub app oauth client id.
* `CLIENT_SECRET` (required) GitHub app oauth client secret.
* `BASE_URL` (required) URL the application is hosted at.
* `LOG_LEVEL` Log level.
* `NODE_ENV` Node environment.

## Deployment

Read up on <https://probot.github.io/docs/deployment> for available hosting
providers.
