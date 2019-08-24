---
layout: page
title: Helm
group: Actions
---

# Helm

Example helm workflow that handles deploying to a Kubernetes cluster. The secret
`KUBECONFIG` is expected to be a Kubeconfig file with access to a Kubernetes
cluster with helm pre-installed.

[Read more about the helm action](https://github.com/deliverybot/helm).

```yaml {% raw %}
name: 'Deploy'
on: ['deployment']

jobs:
  deployment:
    runs-on: 'ubuntu-latest'
    steps:
    - name: 'Checkout'
      uses: 'actions/checkout@v1'

    - name: 'Deploy ${{ github.event.deployment.environment }}'
      uses: 'deliverybot/helm@master'
      with:
        release: '${{ github.event.deployment.environment }}-example'
        namespace: '${{ github.event.deployment.environment }}'
        chart: './charts/example'
        token: '${{ github.token }}'
        values: |
          sha: '${{ github.sha }}'
      env:
        KUBECONFIG_FILE: '${{ secrets.KUBECONFIG }}'
{% endraw %}
```
