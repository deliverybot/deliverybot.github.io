---
layout: page
title: Firebase action
group: Delivering
---

# Firebase

Example firebase workflow that handles deploying a repository to Firebase. Doesn't
handle 'removal' deployments or dynamic environment names as this is tricky with
firebase.

```yaml {% raw %}
name: Deploy

on: ['deployment']

jobs:
  deployment:

    runs-on: 'ubuntu-latest'

    steps:
    - uses: actions/checkout@v1
    - name: 'use node 8.x'
      uses: actions/setup-node@v1
      with:
        node-version: 8.x

    - name: 'Deployment pending'
      uses: 'deliverybot/status@master'
      with:
        state: 'pending'
        token: '${{ github.token }}'

    # Note: Doesn't support 'remove' deployments.
    - name: 'Deploy ${{ github.event.deployment.environment }}'
      env:
        SERVICE_ACCOUNT: '${{ secrets.SERVICE_ACCOUNT }}'
      run: |
        npm install
        echo $SERVICE_ACCOUNT > service-account.json
        GOOGLE_APPLICATION_CREDENTIALS=./service-account.json npm run deploy

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
{% endraw %}
```
