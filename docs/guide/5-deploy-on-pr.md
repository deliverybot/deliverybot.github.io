---
layout: page
title: Deploy a PR environment
group: Guide
---

# Deploy a PR environment

<div class="flash mb-4">
  <p>New! Automatic deployments to a pull request now available. Configured by adding:</p>
  <p><code>auto_deploy_on: pr</code></p>
</div>

{% raw %}

Deploying our code in a pull request is a great way of quickly giving
developers or designers an easy way of seeing their changes live before they
merge them into master and deploy them to production.

Here we are going to create a `review` target which will deploy to a dynamic
environment name using a PR number. Previously we used static environment names
the dynamic environment name should trigger our deployment automation to spin
up a new environment and deploy our code to this.

```yaml
# .github/deploy.yml
review:
  # Set the transient environment flag to let GitHub and Deliverybot know that
  # this environment should be destroyed when the PR is closed.
  transient_environment: true
  production_environment: false

  # Dynamic environment name. The environment will look like pr123.
  environment: pr${{ pr }}
```

Using this we can then trigger a deployment inside a pull request by typing the
below command into the pull request comments.

    /deploy review

Or, optionally, to trigger automatic deploys when a pull request is opened or
synchronized you can add the following to the configuration file:

```yaml
# .github/deploy.yml
review:
  transient_environment: true
  production_environment: false
  environment: pr${{ pr }}
  auto_deploy_on: pr
```

An example of what a pr environment deploy looks like:

![Deploy on pr environments](/assets/images/pr-deploy.png)

### Cleanup

One thing we'll also want to include at this point is configuration to delete
our dynamic pull request environment when the pull request is closed. We listen
for the closed pull request event in GitHub actions and trigger code to remove
this environment.

Copy the below file into `.github/workflows/pr-cleanup.yml` to setup this
workflow.

```yaml
# .github/workflows/pr-cleanup.yml
name: PRCleanup
on:
  pull_request:
    types: [closed]

jobs:
  pr-close:
    runs-on: 'ubuntu-latest'
    steps:
    - name: 'remove'
      run: |
        echo 'remove pr${{ github.event.pull_request.number }}'
```

{% endraw %}

## Compatible integrations

Follow the guides in these integrations below for implementing pull request
deployments.

{%- for integration in site.data.integrations %}
{%- if integration.labels contains "PR"%}
- [{{ integration.name }}](/docs/integrations/{{integration.id}})
{%- endif %}
{%- endfor %}

## Next

[Promote a commit >>](/docs/guide/6-promotion/)
