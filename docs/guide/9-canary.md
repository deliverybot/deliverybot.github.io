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
  environment: production
  description: Deploy to production with %15 traffic.
  payload:
    traffic: 15
production:
  environment: production
```

In this case we use the payload parameter to allow specifying custom variables
that can be used in our deployment actions. This allows us to specify high level
parameters and push them throughout the deployment pipeline.

{% endraw %}

## Compatible integrations

Follow the guides in these integrations below for implementing canary
deployments.

{%- for integration in site.data.integrations %}
{%- if integration.labels contains "CANARY"%}
- [{{ integration.name }}](/docs/integrations/{{integration.id}})
{%- endif %}
{%- endfor %}

## Next

[Deployment analytics >>](/docs/guide/10-analytics/)
