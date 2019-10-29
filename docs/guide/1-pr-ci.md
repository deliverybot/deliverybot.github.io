---
layout: page
title: Pull request setup
group: Guide
---

# Pull request setup

{% raw %}

We need to setup the basic continuous integration parts of our workflow first.
This provides a green check to let deliverybot know whether a commit is safe to
deploy to an environment. Usually these are your unit and integration tests
that are run as part of every commit.

Copy the below code into your repository at the path `.github/workflows/ci.yml`.

```yaml
# .github/workflows/ci.yml
name: CI
on: [push]

jobs:
  ci:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: install, build, and test
      run: |
        echo 'ok'
```

This means that on push we'll run this stage to install, build and test the app
to notify us whether our code passed it's checks. For concrete examples of
what to put into this you can take a look at the starter workflows
[repository][starter-actions] for different examples.

The important thing to note for our purposes is the `ci` tag is the key that
we'll use to ensure that this check is passed before merging into master.
Add this check to your required contexts when merging into master. This will
prevent merges into master without your CI pipeline passing.

<https://help.github.com/en/github/administering-a-repository/about-required-status-checks>

[starter-actions]: https://github.com/actions/starter-workflows

## Next

[Deliverying deployments >>](/docs/guide/2-deploy-action/)

{% endraw %}

