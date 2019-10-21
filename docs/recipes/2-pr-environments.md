---
layout: page
title: Deploy a PR environment
group: Recipes
---

# Deploy a PR environment

PR specific environments are useful for testing behaviour for a specific app
we can spin up a dedicated environment for every PR using configuration like
below:

```yaml {% raw %}
# .github/deploy.yml
review:
  # Set the transient environment flag to let GitHub and deliverybot know that
  # this environment should be destroyed when the PR is closed.
  transient_environment: true
  production_environment: false

  # Dynamic environment name. The environment will look like pr123.
  environment: pr${{ pr }}
{% endraw %}
```

## Deploying

As a comment in your PR, you can type the below command to kick off the pr.

    /deploy review

An example of what a pr environment deploy looks like:

![Deploy on pr environments](/assets/images/pr-deploy.png)

## Next

[Learn about actually delivering your deployments.](/docs/integrations)
