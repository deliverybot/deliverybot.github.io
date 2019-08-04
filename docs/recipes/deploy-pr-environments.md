---
layout: page
title: Deploy a PR environment
group: Recipes
---

# Deploy a PR environment

PR specific environments are useful for testing behaviour for a specific app
we can spin up a dedicated environment for every PR using configuration like
below:

```yaml
# .github/deploy.yml
review:
  # Dynamic environment name. The environment will look like pr123.
  environment: pr{{ pr }}

  # Set the transient environment flag to let GitHub and deliverybot know that
  # this environment should be destroyed when the PR is closed.
  transient_environment: true
  production_environment: false

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

As a comment in your PR, you can type the below command to kick off the pr.

    /deploy review
