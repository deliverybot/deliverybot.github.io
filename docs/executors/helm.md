---
layout: page
title: "7 Executor: Kubernetes"
---

# Helm

> Deploys services to Kubernetes.

## Secrets

- `KUBECONFIG` (Required): A Kubeconfig file with access to a Kubernetes
  cluster.

## Parameters

```yaml
# .github/deploy.yml
mytarget:
  ...
  exec:
    image: helm
    params:
      namespace: default # required, namespace
      chart: my-chart # chart name, defaults to "charts/default"
      release: my-release # required, helm release name
      image:
        repository: gcr.io/project/service # required, image name
        tag: {{short_sha}} # required, image tag
```

For a preview environment in a pull request:

```yaml
# .github/deploy.yml
mytarget:
  ...
  exec:
    image: helm
    params:
      namespace: default
      release: my-release-{{pr}} # dynamic release name
      image:
        repository: gcr.io/project/service
        tag: {{short_sha}}
```
