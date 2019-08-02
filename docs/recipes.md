---
layout: page
title: 4 Recipes
---

# Recipes

## Just deploy

Deploy code to that goes onto master.

```yaml
# .github/deploy.yml
production:
  deploy_on: refs/heads/master
  environment: production
  transient_environment: false
  production_environment: true
  required_contexts: ["ci/build"]
```

Note: We probably want to include our build step as a required context so that
if we are deploying a container we run the deployment after the build has
finished.

## Deploy on master

- Developers create pull requests and push to review environments.
- When a pull request is ready, and it has been successfully deployed to a
  review environment, the pr is merged.
- Deployments to staging production are kicked off with a new commit to master.
- Failed deployments on master mark the commit as red.

```yaml
# .github/deploy.yml
review:
  environment: pr{{ number }}
  transient_environment: true
  production_environment: false
  required_contexts: ["ci/build"]
production:
  deploy_on: refs/heads/master
  environment: production
  transient_environment: false
  production_environment: true
  required_contexts: ["ci/build"]
```

## Deploy in pull requests

- Developers create pull requests and push to review environments.
- When a pull request is ready, and it has been successfully deployed to a
  review environment, we lock for a deploy.
- The pr is then deployed to staging.
- The pr is finally deployed to production.
- If the above steps pass, the pr is merged into master.

```yaml
# .github/deploy.yml
review:
  environment: pr{{ number }}
  transient_environment: true
  production_environment: false
  required_contexts: ["ci/build"]
  exec:
    image: colinjfw/cloud-run:latest
    args: ["deliverybot-pr{{ pr }}", "gcr.io/project/deliverybot"]
staging:
  environment: staging
  transient_environment: false
  production_environment: true
  auto_merge: true
  required_contexts: ["ci/build", "deploy/review"]
  exec:
    image: colinjfw/cloud-run:latest
    args: ["deliverybot-staging", "gcr.io/project/deliverybot"]
production:
  environment: production
  transient_environment: false
  production_environment: true
  auto_merge: true
  required_contexts: ["ci/build", "deploy/staging"]
  exec:
    image: colinjfw/cloud-run:latest
    args: ["deliverybot-production", "gcr.io/project/deliverybot"]
```

Additional configuration:
- Require `deploy/production` before merging.
- Require pr's to be up to date before merging.
