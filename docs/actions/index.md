---
layout: page
title: Actions
group: Actions
---

# Actions

Example action workflows for deliverying deployments:

- [Helm](helm)
- [Firebase](firebase)

## About actions

GitHub actions are one of the simplest ways to trigger your deployments. Actions
run on GitHub infrastructure in response to GitHub events. The basic format for
setting up a GitHub action to handle a deployment looks like this:

```yaml
# .github/workflows/deploy.yml
name: 'Deploy'
on: ['deployment']

jobs:
  deployment:
    runs-on: 'ubuntu-latest'
    steps: []
    # Steps to execute your deployment.
```

The above instantiates a workflow that will run on `deployment` events triggered
in your specific repository. Deliverybot triggers these events and your code
does the work of shipping the actual deployments onto your infrastructure.

If you are building your own actions, one important thing that you may notice
is that the deployment status is always sitting in 'pending' or 'waiting'. For
GitHub and Deliverybot to be able to track your deployment you need to send back
`deployment_status` events. Below is a template for doing just that, we have
actions that run before and after your main deployment block which set the
correct status:

```yaml
# .github/workflows/deploy.yml
name: 'Deploy'
on: ['deployment']

jobs:
  deployment:
    runs-on: 'ubuntu-latest'
    steps:
    - name: 'Checkout'
      uses: 'actions/checkout@v1'

    - name: 'Deployment pending'
      uses: 'deliverybot/status@master'
      with:
        state: 'pending'
        token: '${{ github.token }}'

    - name: 'Deploy ${{ github.event.deployment.environment }}'
      run: |
        echo 'YOUR CODE HERE'

    - name: 'Deployment success'
      if: success()
      uses: 'deliverybot/status@master'
      with:
        state: 'success'
        token: '${{ github.token }}'

    - name: 'Deployment failure'
      if: failure()
      uses: 'deliverybot/status@master'
      with:
        state: 'failure'
        token: '${{ github.token }}'
```

## Next

Check out examples for specific actions:

- [Helm](helm)
- [Firebase](firebase)

Read more about actions from [GitHub](https://github.com/features/actions).
