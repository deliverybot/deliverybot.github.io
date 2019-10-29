---
layout: page
title: Delivering deployments
group: Guide
---

# Delivering deployments

{% raw %}

Deliverybot works by triggering deployments via GitHub api's. To actually
trigger those deployments your code responds to the deployment event and reads
the provided parameters and ships your code off to wherever it needs to go.

```
+-------------+         +--------+         +----------------+        +-------------+
| Deliverybot |         | GitHub |         | GitHub Actions |        | Your Server |
+-------------+         +--------+         +----------------+        +-------------+
     |                      |                       |                     |
     |  Create Deployment   |                       |                     |
     |--------------------->|                       |                     |
     |                      |                       |                     |
     |  Deployment Created  |                       |                     |
     |<---------------------|                       |                     |
     |                      |                       |                     |
     |                      |   Deployment Event    |                     |
     |                      |---------------------->|                     |
     |                      |                       |     SSH+Deploys     |
     |                      |                       |-------------------->|
     |                      |                       |                     |
     |                      |   Deployment Status   |                     |
     |                      |<----------------------|                     |
     |                      |                       |                     |
     |                      |                       |   Deploy Completed  |
     |                      |                       |>--------------------|
     |                      |                       |                     |
     |                      |   Deployment Status   |                     |
     |                      |<----------------------|                     |
     |                      |                       |                     |
```

You can view the workflow in the diagram above. The part we're filling out
right now is the 'GitHub Actions' component. We're stubbing the behaviour to
execute a deployment and mark it with the correct status.

Below is the example action that we can copy into
`.github/workflows/deployment.yml` which listens to a GitHub deployment event
and then writes deployment status events depending on where the deployment ends
up.

```yaml
# .github/workflows/deployment.yml
name: Deployment

on: ['deployment']

jobs:
  deployment:
    runs-on: 'ubuntu-latest'

    steps:
    - name: 'deployment pending'
      uses: 'deliverybot/deployment-status@master'
      with:
        state: 'pending'
        token: '${{ github.token }}'

    - name: deploy
      run: |
        echo "environment - ${{ github.event.deployment.task }}"
        echo "payload - ${{ github.event.deployment.payload }}"

    - name: 'deployment success'
      if: success()
      uses: 'deliverybot/deployment-status@master'
      with:
        state: 'success'
        token: '${{ github.token }}'

    - name: 'deployment failure'
      if: failure()
      uses: 'deliverybot/deployment-status@master'
      with:
        state: 'failure'
        token: '${{ github.token }}'
```


{% endraw %}

## Compatible integrations

Follow the guides in these integrations below for implementing real
deployments.

{% for integration in site.data.integrations %}
{% if integration.labels contains "ACTION"%}
- [{{ integration.name }}](/docs/integrations/{{integration.id}})
{% endif %}
{% endfor %}

## Next

[Deploy on master >>](/docs/guide/3-deploy-on-master/)
