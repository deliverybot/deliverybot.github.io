---
layout: page
title: "6 Executor: Cloud Run"
---

# Cloud Run

Deploys services to Google Cloud run.

## Secrets

- `GCLOUD_SERVICE_KEY` (Required): A Google Cloud service account with access to
  the cloud run service.

## Parameters

```yaml
# .github/deploy.yml
mytarget:
  ...
  exec:
    image: cloud-run
    params:
      service: deliverybot # required, name of service
      image:
        repository: gcr.io/project/service # required, image name
        tag: {{short_sha}} # required, image tag
```

For a preview environment in a pull request:

```yaml
# .github/deploy.yml
mytarget:
  ...
  environment: pr{{pr}}
  exec:
    image: cloud-run
    params:
      service: deliverybot-{{pr}} # dynamic service name
      image:
        repository: gcr.io/project/service
        tag: {{short_sha}}
```
