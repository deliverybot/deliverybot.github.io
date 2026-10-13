---
layout: page
title: Self-hosting
description: "Run Deliverybot on your own infrastructure: create a GitHub App, configure the environment and run the open source app with Postgres."
---

# Self-hosting

The hosted app at [app.deliverybot.dev]({{ site.deliverybot_url }}) is the
quickest way to get started, but Deliverybot is open source and you can run it
on your own infrastructure too.

Deliverybot is a [Probot](https://probot.github.io){:target="_blank"}
application that responds to events from GitHub and triggers deployments based
on actions in the dashboard and check status events from GitHub. It needs:

- Your own [GitHub App][create-app]. The [`app.yml`][app-yml] manifest in the
  repository lists the permissions and events it uses.
- PostgreSQL for storage, sessions and the job queue.
- Two processes from the same image: `web`, which serves the dashboard and
  receives webhooks, and `worker`, which runs background jobs.

## Running the container

Every commit to the main branch builds an image from the repository's
[`Dockerfile`][dockerfile]. Configure it with environment variables:

| Variable | Description |
| --- | --- |
| `APP_ID` | The GitHub App's ID. |
| `PRIVATE_KEY` | The GitHub App's private key. |
| `WEBHOOK_SECRET` | The GitHub App's webhook secret. |
| `CLIENT_ID`, `CLIENT_SECRET` | The GitHub App's OAuth credentials, used to sign in to the dashboard. |
| `SESSION_SECRET` | A long random string used to sign and encrypt sessions. |
| `DATABASE_URL` | Postgres connection string. |
| `BASE_URL` | The public URL the app is served from. |
| `SLACK_CLIENT_ID`, `SLACK_CLIENT_SECRET`, `SLACK_SIGNING_SECRET` | Optional, for the [Slack integration](/docs/integrations/chatops/). Create the Slack app from `packages/slackbot/manifest.yml`. |

Then run the database migrations once, and start both processes:

```sh
node packages/postgres/lib/cli.js   # migrations
node packages/run/lib/server.js     # web, listens on port 3000
node packages/run/lib/worker.js     # worker
```

Set the GitHub App's webhook URL to `https://<your host>/api/github/webhooks`
and its callback URL to `https://<your host>/login/cb`.

## Kubernetes

The repository ships [Kustomize manifests][kubernetes] with a base and
staging/production overlays, which run Postgres in the cluster through
[CloudNativePG](https://cloudnative-pg.io){:target="_blank"}. Their README
covers the one-time cluster setup.

## Local development

See the repository's [README][source] to run Deliverybot locally with
`docker compose` for Postgres and [smee.io](https://smee.io){:target="_blank"}
to forward webhooks.

[create-app]: https://docs.github.com/en/apps/creating-github-apps/registering-a-github-app/registering-a-github-app
[app-yml]: https://github.com/deliverybot/deliverybot/blob/master/app.yml
[dockerfile]: https://github.com/deliverybot/deliverybot/blob/master/Dockerfile
[kubernetes]: https://github.com/deliverybot/deliverybot/tree/master/deploy/kubernetes
[source]: https://github.com/deliverybot/deliverybot
