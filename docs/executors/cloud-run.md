---
layout: page
title: Cloud Run
group: Executors
---

# Cloud Run

Deploys services to Google Cloud run.

## Secrets

- `GCLOUD_SERVICE_KEY` (Required): A Google Cloud service account with access to
  the cloud run service.

## Parameters

```yaml {% raw %}
# .github/deploy.yml
mytarget:
  exec:
    image: cloud-run
    params:
      service: deliverybot # required, name of service
      image:
        repository: gcr.io/project/service # required, image name
        tag: "{{short_sha}}" # required, image tag
{% endraw %}
```

For a preview environment in a pull request:

```yaml {% raw %}
# .github/deploy.yml
mytarget:
  environment: pr{{pr}}
  exec:
    image: cloud-run
    params:
      service: deliverybot-{{pr}} # dynamic service name
      image:
        repository: gcr.io/project/service
        tag: "{{short_sha}}"
{% endraw %}
```
