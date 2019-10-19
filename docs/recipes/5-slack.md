---
layout: page
title: Slack deployments
group: Recipes
---

# Slack deployments

ChatOps means doing 'operations' over slack or other instant messaging services.
Deliverybot integrates with Slack by providing a Slack slash command with an
option to trigger a deployment on your repository. Deploying a project looks
similar to this:

```
/deliverybot deploy deliverybot/example@heads/master production
```

[Install the integration]({{slack_url}}).
