---
layout: page
title: deploy.yml
---

# Configuration (`.github/deploy.yml`)

Deliverybot controls deployments based on a configuration file. Targets are the
top level resource for this file which house configuration to trigger a list of
deployments depending on specific conditions. Documentation for those conditions
and fields is provided below.

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
- [`<target>.task`](#targettask)
- [`<target>.auto_merge`](#targetauto_merge)
- [`<target>.payload`](#targetpayload)

##### `<target>.auto_deploy_on`

Controls auto deployment behaviour given a ref. If any new push events are
detected on this event, the deployment will be triggered.

```yaml {% raw %}
# .github/deploy.yml
production:
  auto_deploy_on: refs/heads/master {% endraw %}
```

##### `<target>.transient_environment`

Specifies if the given environment is specific to the deployment and will no
longer exist at some point in the future. Default: false

If this value is `true` all deployments triggered on a pr will be marked
inactive and a removal deployment will be fired to clean up all unique
environments.

##### `<target>.production_environment`

Specifies if the given environment is one that end-users directly interact with.
Default: true when environment is production and false otherwise.

##### `<target>.required_contexts`

The status contexts to verify against commit status checks. Default: []

##### `<target>.environment`

The name of the environment that was deployed to (e.g., staging or production).
Default: none


##### `<target>.task`

The name of the task for the deployment (e.g., deploy or deploy:migrations).
Default: none

Removal deployments are a special type of deployment that is fired by
deliverybot when a PR is closed and resources need to be cleaned up. This type
of deployment can be detected because task will equal `remove` in this case.
Use this as a hook to clean up resources not needed anymore.

##### `<target>.auto_merge`

Attempts to automatically merge the default branch into the requested ref, if
it's behind the default branch. Default: false

##### `<target>.payload`

Payload with extra information about the deployment. Default: {}

## Variables

The following variables are available using `{% raw %}${{ }}{% endraw %}` syntax
when evaluating deployment targets:

- `ref`: Deployment ref, ie: `master`.
- `sha`: Full git sha.
- `short_sha`: Short git sha.
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
