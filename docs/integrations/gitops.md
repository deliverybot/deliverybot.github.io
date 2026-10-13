---
layout: page
title: GitOps
group: Integrations
description: "Use Deliverybot with GitOps and Flux: commit new image tags to a config repository on each deployment and report back when Flux applies them."
---

# GitOps

{% raw %}

GitOps keeps the desired state of your cluster in a Git repository. A GitOps
operator such as [Flux](https://fluxcd.io){:target="_blank"} or
[Argo CD](https://argo-cd.readthedocs.io){:target="_blank"} runs in the
cluster, watches that repository and applies what's in it. Your CI system
never needs access to the cluster: deploying means committing to the
repository.

![Flux diagram](/assets/images/integrations/flux.svg)

Deliverybot fits in front of this. It decides when a deployment happens, and a
GitHub Actions workflow on the `deployment` event commits the new version to
the config repository. This page uses Flux and Kustomize; the workflow works
the same way for Argo CD.

## Setup

1. Set up Flux on your cluster with a config repository, following the
   [Flux getting started guide](https://fluxcd.io/flux/get-started/){:target="_blank"}.
   This guide assumes the repository holds a Kustomize overlay per
   environment, such as `apps/myapp/staging/kustomization.yaml`, and a Flux
   `Kustomization` for each.
2. Give the app repository write access to the config repository: add a
   [deploy key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/managing-deploy-keys#deploy-keys){:target="_blank"}
   with write access to the config repository, and its private key as a
   `CONFIG_REPO_KEY` secret in the app repository.
3. Put the overlay path in each target's payload in `.github/deploy.yml`:

```yaml
# .github/deploy.yml
staging:
  auto_deploy_on: refs/heads/master
  required_contexts: ["build"]
  environment: staging
  payload:
    path: apps/myapp/staging

production:
  production_environment: true
  required_contexts: ["build"]
  environment: production
  payload:
    path: apps/myapp/production
```

4. Add a workflow that sets the image tag in that overlay and pushes it to the
   config repository. It assumes your CI pushes an image tagged with the
   commit sha:

```yaml
# .github/workflows/deploy.yml
name: Deploy
on: [deployment]

jobs:
  deploy:
    runs-on: ubuntu-latest
    permissions:
      deployments: write
    concurrency:
      group: deploy-${{ github.event.deployment.environment }}
    env:
      OVERLAY: ${{ github.event.deployment.payload.path }}
      IMAGE: ghcr.io/${{ github.repository }}:${{ github.event.deployment.sha }}
    steps:
      - uses: deliverybot/deployment-status@v2
        with:
          state: in_progress

      - uses: actions/checkout@v7
        with:
          repository: acme/config
          ssh-key: ${{ secrets.CONFIG_REPO_KEY }}

      - name: Commit the new image
        run: |
          cd "$OVERLAY"
          kustomize edit set image "ghcr.io/${{ github.repository }}=$IMAGE"
          cd "$GITHUB_WORKSPACE"
          git config user.name "github-actions[bot]"
          git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
          git commit -am "Deploy $IMAGE to ${{ github.event.deployment.environment }}"
          git pull --rebase
          git push

      - if: failure()
        uses: deliverybot/deployment-status@v2
        with:
          state: failure
```

Replace `acme/config` with your config repository. The deployment stays
`in_progress` after the push, because Flux hasn't applied the change yet. The
next section marks it successful once Flux has. If you'd rather not set that up,
add a step that sets the state to `success` after the push instead.

## Report when Flux has applied the change

Flux's notification controller can send a
[`repository_dispatch` event](https://fluxcd.io/flux/components/notification/providers/#github-dispatch){:target="_blank"}
to the app repository when a `Kustomization` has been applied. Create a
`githubdispatch` provider pointing at the app repository, and an alert per
environment:

```yaml
apiVersion: notification.toolkit.fluxcd.io/v1beta3
kind: Provider
metadata:
  name: myapp
  namespace: flux-system
spec:
  type: githubdispatch
  address: https://github.com/acme/myapp
  secretRef:
    name: myapp-github-token # a token that can create repository dispatches
---
apiVersion: notification.toolkit.fluxcd.io/v1beta3
kind: Alert
metadata:
  name: myapp-staging
  namespace: flux-system
spec:
  providerRef:
    name: myapp
  eventSeverity: info
  eventMetadata:
    env: staging
  eventSources:
    - kind: Kustomization
      name: myapp-staging
```

Then mark the latest deployment to that environment as successful:

```yaml
# .github/workflows/deployed.yml
name: Deployed
on:
  repository_dispatch:
    types: [Kustomization/myapp-staging.flux-system]

jobs:
  deployed:
    runs-on: ubuntu-latest
    permissions:
      deployments: write
    steps:
      - id: latest
        env:
          GH_TOKEN: ${{ github.token }}
          ENVIRONMENT: ${{ github.event.client_payload.metadata.env }}
        run: |
          id=$(gh api "repos/$GITHUB_REPOSITORY/deployments?environment=$ENVIRONMENT&per_page=1" --jq '.[0].id')
          echo "id=$id" >> "$GITHUB_OUTPUT"

      - uses: deliverybot/deployment-status@v2
        with:
          deployment-id: ${{ steps.latest.outputs.id }}
          state: success
```

{% endraw %}
