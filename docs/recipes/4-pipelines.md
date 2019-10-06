---
layout: page
title: Build pipelines
group: Recipes
---

# Build pipelines

This recipe goes over how to setup build promotion with tests or manual approval
that promote a build by marking a specific commit as promoted. The deployment
configuration file references the "promoted" status for production deploys to
go out.

```yaml {% raw %}
# .github/deploy.yml
production:
  auto_deploy_on: refs/heads/master
  # Wait for builds to finish for auto deploys to kick in. Additionally wait
  # for a "promoted" check to be applied from the commit.
  required_contexts: ["ci/build", "promoted"]
  environment: production
staging:
  auto_deploy_on: refs/heads/master
  required_contexts: ["ci/build"]
  environment: staging
{% endraw %}
```

Marking a build as promoted could be as simple as a curl command in a script
that is run after a deployment:

```bash
curl "https://api.github.com/repos/my-org/my-repo/statuses/$GIT_COMMIT?access_token=$TOKEN" \
  -H "Content-Type: application/json" \
  -X POST \
  -d "{\"state\": \"success\", \"context\": \"promoted\"}"
```

## Pipelines

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
  environment: production

staging:
  auto_deploy_on: refs/heads/master
  required_contexts: ["ci/build"]
  environment: staging

qa:
  auto_deploy_on: refs/heads/master
  required_contexts: ["ci/build"]
  environment: staging {% endraw %}
```

The only missing piece here is to run your code on `deployment_status` events
when the `success` event is fired. Run a GitHub action or another CI process
to test your code.
