---
layout: page
title: Pipelines
group: Recipes
---

# Pipelines

Since deployments are kicked off using a set of required contexts that they will
wait for, it means that simple pipelines can be built using required contexts to
provide a directed acyclic graph.

```
-> push (master) -> [staging]   -> (manual approval)      -> [production]
                 -> [qa]        -> (run acceptance tests) ->
```

```yaml {% raw %}
# .github/deploy.yml
production:
  auto_deploy_on: refs/heads/master
  required_contexts: ["ci/build", "qa", "promoted"]
  deployments:
  - environment: production

staging:
  auto_deploy_on: refs/heads/master
  required_contexts: ["ci/build"]
  deployments:
  - environment: staging

qa:
  auto_deploy_on: refs/heads/master
  required_contexts: ["ci/build"]
  deployments:
  - environment: staging {% endraw %}
```

The only missing piece here is to run your code on `deployment_status` events
when the `success` event is fired. Run a GitHub action or another CI process
to test your code.
