---
layout: page
title: Locking deployments
group: Guide
description: Lock an environment in Deliverybot to stop automatic and manual deployments while you handle an incident.
---

# Locking deployments

Sometimes issues may take a while to debug in production. One of the worst
things that can happen is during an incident an automatic deployment may go out
worsening the issue. Deployment locking helps with this. We have a button that
blocks deployments from going out to a given environment, giving you time to
resolve issues as you see fit.

Open "Environment locks" above the commit list and click "Lock" next to the
target. This will halt automatic deployments and manual deployments from going
out. Locked targets show as a red badge next to the button.

<picture class="screenshot">
  <source data-theme="dark" srcset="/assets/images/deploy-locked-dark.png" media="(prefers-color-scheme: dark)">
  <img src="/assets/images/deploy-locked.png" alt="Locked production environment">
</picture>

## Next

[Canary deployments >>](/docs/guide/9-canary/)
