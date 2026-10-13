---
layout: page
title: Helm
group: Integrations
description: Deploy a Helm chart to Kubernetes from GitHub Actions on Deliverybot deployment events, and report the status back to GitHub.
---

# Helm

{% raw %}

Deploy a Helm chart from a GitHub Actions workflow that runs on the
`deployment` events Deliverybot creates. The workflow installs Helm with
[azure/setup-helm](https://github.com/Azure/setup-helm), runs
`helm upgrade --install` and reports the result back to GitHub with
[deliverybot/deployment-status](https://github.com/deliverybot/deployment-status).

## Setup

1. Add a `KUBECONFIG` repository secret holding a kubeconfig for your cluster.
   Use a service account that can only manage the namespaces you deploy to.
2. Describe the release in each target's `payload` in `.github/deploy.yml`.
   The workflow reads the payload, so one workflow serves every target:

```yaml
# .github/deploy.yml
staging:
  auto_deploy_on: refs/heads/master
  required_contexts: ["build"]
  environment: staging
  payload:
    release: myapp-staging
    namespace: myapp-staging
    values_file: deploy/values-staging.yaml

production:
  production_environment: true
  required_contexts: ["build"]
  environment: production
  payload:
    release: myapp
    namespace: myapp-production
    values_file: deploy/values-production.yaml
```

3. Add the workflow:

```yaml
# .github/workflows/deploy.yml
name: Deploy
on: [deployment]

jobs:
  deploy:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      deployments: write
    concurrency:
      group: deploy-${{ github.event.deployment.environment }}
    env:
      RELEASE: ${{ github.event.deployment.payload.release }}
      NAMESPACE: ${{ github.event.deployment.payload.namespace }}
      VALUES_FILE: ${{ github.event.deployment.payload.values_file }}
      SHA: ${{ github.event.deployment.sha }}
    steps:
      - uses: actions/checkout@v7
        with:
          ref: ${{ github.event.deployment.sha }}

      - uses: deliverybot/deployment-status@v2
        with:
          state: in_progress

      - uses: azure/setup-helm@v5

      - name: Deploy
        env:
          KUBECONFIG_DATA: ${{ secrets.KUBECONFIG }}
        run: |
          export KUBECONFIG="$RUNNER_TEMP/kubeconfig"
          printf '%s' "$KUBECONFIG_DATA" > "$KUBECONFIG"
          helm upgrade "$RELEASE" ./chart \
            --install --rollback-on-failure \
            --namespace "$NAMESPACE" --create-namespace \
            --values "$VALUES_FILE" \
            --set image.tag="$SHA"

      - if: success()
        uses: deliverybot/deployment-status@v2
        with:
          state: success

      - if: failure()
        uses: deliverybot/deployment-status@v2
        with:
          state: failure
```

`--rollback-on-failure` waits for the release to become ready and rolls it
back if it doesn't, so a failed deployment leaves the previous version running. Replace `./chart` with the path
to your chart, or with a chart from a repository.

## Pull request environments

A target with a [variable](/docs/configuration/#variables) in its payload gives
every pull request its own release. Deploy it with `/deploy review` in the pull
request, or set `auto_deploy_on: pr` to deploy on every push:

```yaml
# .github/deploy.yml
review:
  transient_environment: true
  environment: pr${{ pr }}
  payload:
    release: myapp-pr${{ pr }}
    namespace: myapp-review
    values_file: deploy/values-review.yaml
```

Remove the release when the pull request closes:

```yaml
# .github/workflows/pr-cleanup.yml
name: PR cleanup
on:
  pull_request:
    types: [closed]

jobs:
  cleanup:
    runs-on: ubuntu-latest
    steps:
      - uses: azure/setup-helm@v5
      - env:
          KUBECONFIG_DATA: ${{ secrets.KUBECONFIG }}
          RELEASE: myapp-pr${{ github.event.pull_request.number }}
        run: |
          export KUBECONFIG="$RUNNER_TEMP/kubeconfig"
          printf '%s' "$KUBECONFIG_DATA" > "$KUBECONFIG"
          helm uninstall "$RELEASE" --namespace myapp-review --ignore-not-found
```

## Canary deployments

A canary is a second, smaller release of the new version next to the stable
one. Give it its own target that deploys to the same environment with a
different release and values, and let your chart route a share of the traffic
to it:

```yaml
# .github/deploy.yml
canary:
  production_environment: true
  required_contexts: ["build"]
  environment: production
  description: Canary
  payload:
    release: myapp-canary
    namespace: myapp-production
    values_file: deploy/values-canary.yaml
```

{% endraw %}
