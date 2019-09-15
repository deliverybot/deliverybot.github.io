---
layout: page
title: Kubernetes
group: Guides
---

# Deliverybot Helm guide

Read the [blog post][post] for a more in depth guide to how Deliverybot and Helm work
best together.

*Requires a Kubernetes cluster.*

1. Visit https://github.com/deliverybot/example-helm

1. Click the "Use this template" button to create a new fork of this repository.

1. Install [deliverybot](https://github.com/apps/deliverybot) on the new repo.

1. Add a `KUBECONFIG` secret into the secrets tab with your Kubernetes cluster.

1. Push a commit to your new fork and watch the example workflows kick off!

1. Visit the [deliverybot app](https://app.deliverybot.dev) and manually deploy.

Note: If you don't want to trigger a deployment using Deliverybot, you can do
this just with a curl command to the GitHub deployments api
https://developer.github.com/v3/repos/deployments/.

### Repository structure

```bash
config/                   # Contains value files per environment.
.github/workflows/cd.yml  # GitHub action workflow.
.github/deploy.yml        # Deliverybot configuration file.
```

[post]: /2019/09/15/deploying-to-kubernetes-with-helm-and-github-actions/
