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

View the below documents for examples with `exec` configuration:

- [Cloud Run](/docs/executors/cloud-run)
- [Helm](/docs/executors/helm)


## Deploying

Since `deploy_on` is configured, a deployment will be kicked off every time
there is a new push event on master.

Alternatively, you may want to leave out the `deploy_on` configuration and kick
off deployment from the deliverybot ui pictured below. This can be found at
<{{site.deliverybot_url}}deploy/my-username/my-repo>.

![On master deploy](/assets/images/deploy-list.jpg)
