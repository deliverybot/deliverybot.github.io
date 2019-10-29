---
layout: page
title: Deploy on master
group: Guide
---

# Deploy on master

{% raw %}

So far we've setup continuous integration checks as well as an initial
deployment action to handle deployments. We, however, don't yet have a way of
actually triggering a deployment. This next step will trigger a deployment
automatically when CI passes on all new pushes to master.

We configure deliverybot by adding a configuration file at `.github/deploy.yml`
with targets that we can issue deployments to. Targets describe the deployment
payload that will be sent to GitHub and subsequently read by our action. It's
where we configure high level items like deployment environment or whether
automatic deployments will happen.

We are going to first create a `staging` target that describes deployments to
our staging environment. Do this by copying the below file into your
repository and pushing this to master.

```yaml
# .github/deploy.yml
staging:
  # Auto deploy on master.
  auto_deploy_on: refs/heads/master
  # Wait for our ci pipeline to pass.
  required_contexts: ["ci"]
  environment: staging
```

When you issue this commit to add the file Deliverybot will pick up this commit
and register that an automatic deployment is required and trigger a deployment.
If you view your project in the Deliverybot dashboard you should be able to see
green checkmarks next to your new commit indicating that a deployment to
staging was successful.

Since we specified the `required_contexts` parameter and included in this the
`ci` key our automatic deployment will wait for the `ci` job to complete before
deploying to staging.

![On master deploy](/assets/images/deploy-list.png)

{% endraw %}

## Next

[Deploy to production >>](/docs/guide/4-deploy-to-production/)
