---
layout: page
title: Locking deployments
group: Guide
---

# Locking deployments

Sometimes issues may take a while to debug in production. One of the worst
things that can happen is during an incident an automatic deployment may go out
worsening the issue. Deployment locking helps with this. We have a button that
blocks deployments from going out to a given environment, giving you time to
resolve issues as you see fit.

Simply click the "Lock" button in the UI. This will halt automatic deployments
and manual deployments from going out.

![On master deploy](/assets/images/deploy-locked.png)

## Next

[Canary deployments >>](/docs/guide/9-canary/)
