---
layout: page
title: deploy.yml
description: Reference for .github/deploy.yml, the file that tells Deliverybot which environments to deploy to, when, and with which checks and payloads.
---

# Configuration (`.github/deploy.yml`)

Deliverybot controls deployments based on a configuration file. Targets are the
top level resource for this file which house configuration to trigger a list of
deployments depending on specific conditions. Documentation for those conditions
and fields is provided below.

Deliverybot only reads `.github/deploy.yml`; other paths such as
`.github/deploy.yaml` are ignored.

```yaml {% raw %}
# .github/deploy.yml
production:
  environment: name {% endraw %}
```

- [`<target>.auto_deploy_on`](#targetauto_deploy_on)
- [`<target>.transient_environment`](#targettransient_environment)
- [`<target>.production_environment`](#targetproduction_environment)
- [`<target>.required_contexts`](#targetrequired_contexts)
- [`<target>.environment`](#targetenvironment)
- [`<target>.description`](#targetdescription)
- [`<target>.task`](#targettask)
- [`<target>.auto_merge`](#targetauto_merge)
- [`<target>.payload`](#targetpayload)

##### `<target>.auto_deploy_on`

Deploys automatically when a push matches this ref. Use the full ref name, such
as `refs/heads/master` for a branch or `refs/tags/v1.0.0` for a tag; a short
name like `master` never matches.

```yaml
# .github/deploy.yml
production:
  auto_deploy_on: refs/heads/master
```

The ref is matched as a glob. A `*` matches any characters, `?` matches a
single character and `[0-9]` matches one character from a set (`[^0-9]` one
character outside it). So `refs/tags/*` deploys every tag, `refs/heads/*`
deploys every branch and `refs/tags/v*-rc*` deploys release candidate tags such
as `v1.2.0-rc1`:

```yaml
  auto_deploy_on: refs/tags/v*-rc*
```

It also takes a list of patterns. A ref deploys when it matches any pattern,
unless it matches a pattern starting with `!`. This deploys every version tag
except release candidates:

```yaml
  auto_deploy_on:
    - refs/tags/v*
    - "!refs/tags/v*-rc*"
```

To deploy when a release is published, match its tag. Publishing a release
with a new tag pushes that tag, so `refs/tags/*` (or a narrower pattern) deploys
it.

Set it to `pr` to deploy automatically when a pull request is opened and on
every push to it.

An automatic deployment waits for the
[`required_contexts`](#targetrequired_contexts) to pass. If a newer commit is
pushed to the ref in the meantime, only the newer commit is deployed.

##### `<target>.transient_environment`

Specifies if the given environment is specific to the deployment and will no
longer exist at some point in the future. Default: false

If this value is `true`, Deliverybot marks the deployments of a pull request
inactive when the pull request is closed.

##### `<target>.production_environment`

Specifies if the given environment is one that end-users directly interact with.
Default: false

##### `<target>.required_contexts`

The commit statuses and check runs that must pass before GitHub accepts the
deployment, for example `["ci"]`. Default: `[]`, which means nothing is checked
and every deployment goes out straight away.

Automatic deployments wait until these pass. A manual deployment from the
dashboard or a `/deploy` comment is refused while they haven't passed; the
dashboard's Force option deploys anyway.

##### `<target>.environment`

The name of the environment to deploy to (e.g., staging or production). It can
use [variables](#variables). Default: production

##### `<target>.description`

A short description shown with the deployment on GitHub. It can use
[variables](#variables). Default: none

##### `<target>.task`

The name of the task for the deployment (e.g., deploy or deploy:migrations).
Default: deploy

##### `<target>.auto_merge`

Attempts to automatically merge the default branch into the requested ref, if
it's behind the default branch. Default: false

##### `<target>.payload`

Payload with extra information about the deployment. It can use
[variables](#variables). Deliverybot always adds a `target` field with the
target's name. Default: {}

## Variables

The following variables are available using `{% raw %}${{ }}{% endraw %}` syntax
when evaluating deployment targets:

- `ref`: The ref being deployed: the branch name for a `/deploy` comment, the
  pushed ref (such as `refs/heads/master`) for an automatic deployment
  (`heads/<branch>` with `auto_deploy_on: pr`), or the commit sha for a
  deployment from the dashboard.
- `short_sha`: Short git sha. The full sha is `commit.sha`.
- `pr`: Pr number, if this deployment is kicked off in a PR.
- `target`: Current target name.
- `owner`: Owner name.
- `repo`: Repo name.
- `pull_request`: [GitHub pull request object.][pr]
- `commit`: [GitHub commit object.][commit]

An example usage of this:

```yaml {% raw %}
# .github/deploy.yml
review:
  # Dynamic environment name. The environment will look like pr123.
  environment: pr${{ pr }} {% endraw %}
```

[pr]: https://developer.github.com/v3/pulls/#response-1
[commit]: https://developer.github.com/v3/git/commits/#response
