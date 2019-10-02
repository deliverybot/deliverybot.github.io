---
layout: page
title: GitOps
group: Delivering
---

# GitOps

GitOps is a pattern for deploying to Kubernetes through a GitHub repository as
an intermediary. This works well with a system like Deliverybot. Instead of
running the actual deployment inside GitHub actions, we can run a script to edit
our Kubernetes manifests. This implements the "push" GitOps workflow.


The below script is an example of responding to a deployment request from
GitHub:

```bash
git clone git@github.com:my-org/my-gitops-repo
sed "s/COMMIT_SHA/${SHORT_SHA}/g" kubernetes.yaml.tpl > my-gitops-repo/${ENVIRONMENT}/kubernetes.yaml
cd my-gitops-repo
git commit -m "Release ${SHORT_SHA}"
git push
```

GitOps providers:

- [Flux](https://docs.fluxcd.io/en/latest/index.html)
- [Argo](https://argoproj.github.io/argo-cd/)
