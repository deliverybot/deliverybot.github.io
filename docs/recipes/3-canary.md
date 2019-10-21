---
layout: page
title: Canary deployments
group: Recipes
---

# Canary deployments

Canary deployments deploy only a percentage of your new code to servers. They
allow for testing new code on only a subset of users. The heavy lifting for
these deployments is done by your code doing the deployment automation, from
the deliverybot standpoint we can make a deployment with parameters describing
the percentage of traffic we would like to shift over.

```yaml {% raw %}
# .github/deploy.yml
canary:
  auto_deploy_on: refs/heads/master
  environment: production
  description: Deploy to production with %15 traffic.
  payload:
    traffic: 15
production:
  environment: production
{% endraw %}
```

## Canary deployments with Helm

Check out the [Helm documentation](/docs/integrations/action-helm) to see how
the Helm action allows for canary deployments.
