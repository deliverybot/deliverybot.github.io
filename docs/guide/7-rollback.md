---
layout: page
title: Rolling back
group: Guide
---

# Rolling back

Rolling back should be fast and safe so that you know that your code can be
quickly reverted and to improve metrics like mean time to recovery. Deliverybot
makes rolling back much faster than a revert commits. Since the build pipeline
doesn't need to be run again we simply issue deployment at an earlier commit sha
and trigger just the deployment workflow.

Rolling back is as simple as selecting the safest commit to deploy from the
list below:

![On master deploy](/assets/images/deploy-list.png)

A good practice is to have alerts pipe into the Slack channel where your
deployments are taking place. If errors spike right after a deployment it's
useful to know immediately so you can rollback as quickly as possible.

## Next

[Canary deployments >>](/docs/guide/8-canary/)
