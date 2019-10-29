---
layout: page
title: Promote a commit
group: Guide
---

# Promote a commit

{% raw %}

In this stage we want QA to manually run through checks on our staging
environment once deployments have been successful. They will mark off the
commit as ready to move on to our next stage of the pipeline.

Simply click the "promote" button on the commit that QA needs to check off
shown in the image below.

![Show promote button](/assets/images/deploy-show.png)

We can then apply to our production deployment a requirement that the promoted
context is checked.

```yaml
# .github/deploy.yml
production:
  production_environment: true
  required_contexts: ["ci", "deliverybot/promoted"]
  environment: production
```

{% endraw %}

## Next

[Rolling back >>](/docs/guide/7-rollback/)
