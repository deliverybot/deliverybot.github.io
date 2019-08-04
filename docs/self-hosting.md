---
layout: page
title: Self Hosting
---

# Self Hosting

Deliverybot can be deployed as a GitHub app on your own infrastructure.

## Google Cloud

Google Cloud access must be configured to cloud storage and cloud build
services. The following cloud storage buckets are required:

- `{project}-secrets`
- `{project}-builds`

## Environment Variables

* `APP_ID` (required) GitHub app id.
* `PRIVATE_KEY` (required) GitHub app private key.
* `WEBHOOK_SECRET` (required) GitHub app webhook secret.
* `CLIENT_ID` (required) GitHub app oauth client id.
* `CLIENT_SECRET` (required) GitHub app oauth client secret.
* `BASE_URL` (required) URL the application is hosted at.
* `LOG_LEVEL` Log level.
* `EXEC_CLIENT` Exec client to run docker containers. (gcp-build, none).
* `SECRET_CLIENT` Secret storage client (gcp-storage, memory).
* `NODE_ENV` Node environment.

## Deployment

Read up on <https://probot.github.io/docs/deployment> for available hosting
providers.
