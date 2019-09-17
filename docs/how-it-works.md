---
layout: page
title: How it works
---

# How it works

Deliverybot uses the GitHub [deployments api][1] to trigger deployments via
GitHub. Your code responds to events from GitHub and runs the actual deployment.
The diagram below details the steps involved:

```
+-------------+         +--------+            +-----------+        +-------------+
| Deliverybot |         | GitHub |            | 3rd Party |        | Your Server |
+-------------+         +--------+            +-----------+        +-------------+
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

Your code is expected to respond to `deployment` events that GitHub will deliver
to you to trigger deployments. Deliverybot controls when these events fire based
on configuration in the [`.github/deploy.yml`][2].

The simplest way of responding to these deployment events is by using GitHub
actions. [Deliverybot maintains a set of actions and recipes][3] for your to be
able to work with these actions effectively.

[1]: https://developer.github.com/v3/repos/deployments/
[2]: /docs/configuration
[3]: /docs/delivering

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

