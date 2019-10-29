---
layout: page
title: Canary deployments
group: Guide
---

# Canary deployments

{% raw %}

Canary deployments deploy only a percentage of your new code to servers. They
allow for testing new code on only a subset of users. The heavy lifting for
these deployments is done by your code doing the deployment automation, from
the deliverybot standpoint we can make a deployment with parameters describing
the percentage of traffic we would like to shift over.

```yaml
# .github/deploy.yml
canary:
  auto_deploy_on: refs/heads/master
  environment: production
  description: Deploy to production with %15 traffic.
  payload:
    traffic: 15
production:
  environment: production
```

{% endraw %}

## Compatible integrations

Follow the guides in these integrations below for implementing real
deployments.

{% for integration in site.data.integrations %}
{% if integration.labels contains "CANARY"%}
- [{{ integration.name }}](/docs/integrations/{{integration.id}})
{% endif %}
{% endfor %}
