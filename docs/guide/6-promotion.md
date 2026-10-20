---
layout: page
title: Promote a commit
group: Guide
description: Promote a commit that passed QA on staging to the next stage of your deployment pipeline with Deliverybot.
---

# Promote a commit

{% raw %}

In this stage we want QA to manually run through checks on our staging
environment once deployments have been successful. They will mark off the
commit as ready to move on to our next stage of the pipeline.

Simply click the "promote" button on the commit that QA needs to check off
shown in the image below.

<picture class="screenshot">
  <source data-theme="dark" srcset="/assets/images/promote-button-dark.png" media="(prefers-color-scheme: dark)">
  <img src="/assets/images/promote-button.png" alt="Show promote button">
</picture>

We can then apply to our production deployment a requirement that the promoted
context is checked.

```yaml
# .github/deploy.yml
production:
  production_environment: true
  required_contexts: ["ci", "deliverybot/promotion"]
  environment: production
```

This stops anyone from deploying to production unless all checks are passing
including CI and promotion. We also have audit logging since promotion events
are logged in GitHub with the username who checked them off we can trace this
throughout the history of the repository.

![Promoted check](/assets/images/promoted-check.png)

{% endraw %}

## Next

[Rolling back >>](/docs/guide/7-rollback/)
