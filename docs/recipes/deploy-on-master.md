---
layout: page
title: Deploy on master
group: Recipes
---

# Deploy on master

Deploy code that goes onto master automatically.

```yaml
# .github/deploy.yml
production:
  deploy_on: refs/heads/master
  environment: production

  # Include the required context here "ci/build" so that we don't deploy before
  # our container is built.
  required_contexts: ["ci/build"]

  # Exec configuration required to execute the deployment.
  exec:
    ...
```

## Deploying

Since `deploy_on` is configured, a deployment will be kicked off every time
there is a new push event on master.

### Manual Kickoff

Alternatively, you may want to leave out the `deploy_on` configuration and kick
off deployment from the deliverybot ui pictured below. This can be found at
<{{site.deliverybot_url}}deploy/my-username/my-repo>.

![On master deploy](/assets/images/deploy-list.png)

A common pattern is to combine a staging environment that deploys on master
automatically with a manual step (clicking the list above) to deploy to
production. This setup can be configured with the below pattern. Note that the
production target doesn't have `deploy_on` while staging does.

```yaml
# .github/deploy.yml
staging:
  deploy_on: refs/heads/master
  environment: staging
  required_contexts: ["ci/build"]
  exec: ... # This is required.
production:
  environment: production
  required_contexts: ["ci/build"]
  exec: ... # This is required.
```

## Next

[Learn about actually delivering your deployments.](/docs/executors)
