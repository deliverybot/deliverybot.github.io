---
layout: page
title: Deploy on master
group: Recipes
---

# Deploy on master

Deploy code that goes onto master automatically.

```yaml {% raw %}
# .github/deploy.yml
production:
  auto_deploy_on: refs/heads/master
  # Include the required context here "ci/build" so that we don't deploy before
  # our container is built.
  required_contexts: ["ci/build"]
  environment: production
{% endraw %}
```

## Deploying

Since `auto_deploy_on` is configured, a deployment will be kicked off every time
there is a new push event on master.

### Manual kickoff

Alternatively, you may want to leave out the `auto_deploy_on` configuration and
kick off deployment from the deliverybot ui pictured below. This can be found at
<{{site.deliverybot_url}}/deploy/my-username/my-repo>.

![On master deploy](/assets/images/deploy-list.png)

A common pattern is to combine a staging environment that deploys on master
automatically with a manual step (clicking the list above) to deploy to
production. This setup can be configured with the below pattern. Note that the
production target doesn't have `auto_deploy_on` while staging does.

```yaml {% raw %}
# .github/deploy.yml
staging:
  auto_deploy_on: refs/heads/master
  environment: staging
production:
  environment: production
{% endraw %}
```

## Next

[Learn about actually delivering your deployments.](/docs/integrations)
