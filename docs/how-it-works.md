---
layout: page
title: How it works
---

# How it works

Deliverybot uses the GitHub [deployments api][1] to trigger deployments via
GitHub. Your code responds to events from GitHub and runs the actual deployment.
The diagram below details the steps involved.

Deliverybot kicks off deployments using configuration found in the
`.github/deploy.yml` file. GitHub Actions or other CI services then listen for
the `deployment` event from GitHub. This is where your code takes over, doing
the work to run the actual deployment to your servers.

This is a decoupled architectures that supports any deployment target and a wide
variety of tooling. Since it's all based around GitHub events, your tools to
listen to events and webhooks will all work with your new deployment system.

```
+-------------+         +--------+         +----------------+        +-------------+
| Deliverybot |         | GitHub |         | GitHub Actions |        | Your Server |
+-------------+         +--------+         +----------------+        +-------------+
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
     |                      |                       |>--------------------|
     |                      |                       |                     |
     |                      |   Deployment Status   |                     |
     |                      |<----------------------|                     |
     |                      |                       |                     |
```

Read more about what [integrations](/docs/integrations) are available to deploy
your code or read [recipes](/docs/recipes) to control how your deployments are
rolled out.

[1]: https://developer.github.com/v3/repos/deployments/

## Deployment events

Deliverybot keeps everything the same with the GitHub deployment event. Which
looks like the event below.

```json
{
  "id": 1,
  "sha": "a84d88e7554fc1fa21bcbc4efae3c782a70d2b9d",
  "ref": "topic-branch",
  "task": "deploy",
  "payload": {
    "target": "production"
  },
  "original_environment": "staging",
  "environment": "production",
  "description": "Deploy request from hubot",
  "creator": {
    "login": "octocat",
    "id": 1,
    "type": "User",
  },
  "created_at": "2012-07-20T01:19:13Z",
  "updated_at": "2012-07-20T01:19:13Z",
  "transient_environment": false,
  "production_environment": true
}
```

### Removal deployments

The `task` parameter is changed to `remove` when a pull request is closed and a
deployment is marked with the `transient_environment` parameter. This means that
the environment needs to be shut down. Code should handle this to delete the
necessary resources.
