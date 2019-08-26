---
layout: page
title: Build promotion
group: Deploying
---

# Build promotion

This recipe goes over how to setup build promotion with tests or manual approval
that promote a build by marking a specific commit as promoted. The deployment
configuration file references the "promoted" status for production deploys to
go out.

```yaml {% raw %}
# .github/deploy.yml
production:
  auto_deploy_on: refs/heads/master
  deployments:
  - environment: production
    # Wait for builds to finish for auto deploys to kick in. Additionally wait
    # for a "promoted" check to be applied from the commit.
    required_contexts: ["ci/build", "promoted"]
staging:
  auto_deploy_on: refs/heads/master
  deployments:
  - environment: staging
    required_contexts: ["ci/build"]
{% endraw %}
```

Marking a build as promoted could be as simple as a curl command in a script
that is run after a deployment:

```bash
curl "https://api.github.com/repos/my-org/my-repo/statuses/$GIT_COMMIT?access_token=$TOKEN" \
  -H "Content-Type: application/json" \
  -X POST \
  -d "{\"state\": \"success\", \"context\": \"promoted\"}"
```
