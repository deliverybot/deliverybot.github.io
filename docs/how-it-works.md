---
layout: page
title: How it works
---

# How it works

Deliverybot is built around the GitHub [deployments api][1]. It's an event
driven decoupled way to deploy your code. Deliverybot is responsible for
figuring out when to trigger a deployment. When conditions are met it triggers
a deploy to the environment that you've specified in the [configuration file][2].
Once the deployment is triggered, your code picks up the deployment event and
runs the actual deploy to your infrastructure.

The diagram below details what a deployment looks like:

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

The benefit to this architecture is that your deployments are separate from
the platform that you are deploying to. If you change platforms or use multiple
platforms within a team you can still enforce the same continous delivery
processes.

This architecture is well suited for [GitHub Actions][3] which is the GitHub
supported system for running your code in response to GitHub events. It means
that setting up Deliverybot is much simpler since you don't also have to manage
infrastructure to listen to events. The next sections go through guides on how
to deliver deployments.

[1]: https://developer.github.com/v3/repos/deployments/
[2]: /docs/configuration/
[3]: https://github.com/features/actions/

## Deliverying deployments with GitHub actions

GitHub actions are one of the simplest ways to handle your deployments. Actions
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
is that the deployment is always sitting in 'pending' or 'waiting'. For
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
      uses: 'deliverybot/deployment-status@master'
      with:
        state: 'pending'
        token: '${{ github.token }}'

    - name: 'Deploy ${{ github.event.deployment.environment }}'
      run: |
        echo 'YOUR CODE HERE'

    - name: 'Deployment success'
      if: success()
      uses: 'deliverybot/deployment-status@master'
      with:
        state: 'success'
        token: '${{ github.token }}'

    - name: 'Deployment failure'
      if: failure()
      uses: 'deliverybot/deployment-status@master'
      with:
        state: 'failure'
        token: '${{ github.token }}'
```

## Deliverying deployments with external tooling

Since it's just listening to GitHub events to execute a deployment you can use
a wide variety of tooling to actually ship deployments. The following guide
includes details on how to write code to handle deployments:

<https://developer.github.com/v3/guides/delivering-deployments/>
