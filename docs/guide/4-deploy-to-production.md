---
layout: page
title: Deploy to production
group: Guide
---

# Deploy to production

{% raw %}

We've now setup automatic deployments to staging with pushes to master. What's
missing from this step is deploying to a production environment. We assume that
developers want to click a button (or message in Slack) manually to issue a
deployment to production.

For this we'll add a target `production` that requires CI to be deployed. Add
the below key to your `.gtihub/deploy.yml` file.

```yaml
# .github/deploy.yml
production:
  production_environment: true
  required_contexts: ["ci"]
  environment: production
```

Since we specified the `required_contexts` parameter and included the
`ci` key if we try and deploy from the Deliverybot dashboard before our ci job
has completed this will throw an error. This keeps production from having
untested code deployed.

That's it! We've now setup a CI pipeline, staging deployments and manual
production deployments. We'll next move onto some of the more advanced features
of Deliverybot.

{% endraw %}

## Next

[Deploy a PR environment >>](/docs/guide/5-deploy-on-pr/)
