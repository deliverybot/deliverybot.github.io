---
layout: page
title: 7 Building Executors
---

# Building Executors

> Individual containers that provide deployments.

- [Helm](helm)
- [Cloud Run](cloud-run)

## Creating a Builder

Builders implement a simple interface to deliver deploys from GitHub. They
provide both GitHub commit status checks and Deployment status events.

- Send a "pending" GitHub commit and deployment status when starting.
- Send a "success" GitHub commit and deployment status when successful.
- Send a "failure" GitHub commit and deployment status when failed.

The context for the GitHub commit status must be `deploy/$ENVIRONMENT`. And the
`$LOGS_URL` variable must be provided as the target_url for both commit and
deploy statuses.

The [entrypoint.sh](entrypoint.sh) file handles this interface if you are
building a bash based builder. You need to provide executables at `/deploy.sh`
and at `/remove.sh` that handle the individual actions.

## Environment

- `PARAMS=`: Deployment parameters. JSON encoded from `exec.params`.
- `DEPLOYMENT=123`: GitHub deployment id.
- `LOGS_URL=`: Logs url for deployment.
- `OWNER=colinjfw`: Repository owner.
- `REPO=deliverybot`: Repository name.
- `ENVIRONMENT=production`: Deployment environment.
- `SHA="commit-sha"`: Commit sha.
- `SHORT_SHA=1234567`: Short commit sha (always 7 characters).
- `ACTION="deploy|remove"`: Deployment action.

## Deploy Actions

If the deployment action is `deploy` this should deploy the deployment. If the
action is `remove` this should remove the deployment. This is triggered if a
transient environment is present on a closed pr.
