---
layout: page
title: Canary deployments
group: Deploying
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
  deployments:
  - environment: production
    description: Deploy to production with %15 traffic.
    required_contexts: ["ci/build"]
    payload:
      traffic: 15
production:
  deployments:
  - environment: production
    required_contexts: ["ci/build"]
{% endraw %}
```

## Canary deployments with helm

Canary deployment with helm follow this same pattern. Here we create a new
deployment for canaries with a specific replica count that we want to release.
The difference from the production deployment is that we don't change the
service or ingress resource, we keep those disabled, and just release a new
deployment resource.

The helm action in GitHub handls this logic for us, view examples and
documentation for the action: https://github.com/deliverybot/helm.

```yaml {% raw %}
canary:
  deployments:
  - environment: production
    description: 'Canary'
    payload:
      release: production-myapp
      namespace: production
      track: canary
      values:
        replicaCount: 1

production:
  deployments:
  - environment: production
    task: remove
    description: 'Remove canary'
    payload:
      track: canary
      release: production-myapp
      namespace: production
  - environment: production
    description: 'Production'
    payload:
      release: production-myapp
      namespace: production
      track: stable
      values:
        replicaCount: 5
{% endraw %}
```
