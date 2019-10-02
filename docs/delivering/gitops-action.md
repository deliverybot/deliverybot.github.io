---
layout: page
title: GitOps action
group: Delivering
---

# GitOps

GitOps is a pattern for deploying to Kubernetes through a GitHub repository as
an intermediary. This works well with a system like Deliverybot. Instead of
running the actual deployment inside GitHub actions, we can run a script to edit
our Kubernetes manifests.

GitOps providers:

- [Flux](https://docs.fluxcd.io/en/latest/index.html)
- [Argo](https://argoproj.github.io/argo-cd/)
