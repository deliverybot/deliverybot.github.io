---
layout: page
title: Deploy on master
group: Guide
---

# Deploy on master

{% raw %}

So far we've setup continuous integration checks as well as an initial
deployment action to handle deployments. We don't yet have a way of
actually triggering a deployment. This next step will trigger a deployment
automatically when CI passes on all new pushes to master.

We configure deliverybot by adding a configuration file at `.github/deploy.yml`.
Inside this configuration file are a set of key value pairs called targets.
Targets describe the deployment payload that will be sent to GitHub and
subsequently read by our action. It's where we configure high level items like
deployment environment or whether automatic deployments will happen.

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
staging was successful. You should see something like the image below:

![On master deploy](/assets/images/deploy-list.png)

Since we specified the `required_contexts` parameter and included in this the
`ci` key our automatic deployment will wait for the `ci` job to complete before
deploying to staging. This is a key tool we'll use throughout the guide to make
sure that your deployments are always safe by describing required steps
needed to ship a deployment.

### Some more details

Even though deploying on master seems like a simple task, Deliverybot has some
logic to keep you safe in different scenarios that occur. We follow a few rules
to keep your auto deployments sane.

If an auto deployment is pending but the sha that this refers to is stale,
meaning there is a new commit on that ref, then we do not deploy this sha.
Instead we'll wait for the new auto deployment for the latest ref to come
through. This protects unexpected code from landing on master. Most of the time,
you will always expect the latest ref to be the one that is in process of being
auto deployed.

This process may fall down if you have very slow CI. This should be configurable
in the future. Reach out if this is causing a problem.

{% endraw %}

## Next

[Deploy to production >>](/docs/guide/4-deploy-to-production/)
