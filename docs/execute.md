---
layout: page
title: 3 Executing Deployments
---


# Deployment Execution

How to actually run deployments. Executors are docker containers that implement
a specification and are executed to deliver your deployments.

```yaml
# .github/deploy.yml
production:
  ...
  exec:
    # A docker image is required to execute.
    image: <image>
    # Paramters are passed to the executing image as arguments.
    params:
      image:
        repository: "foo"
        tag: "foo"
```

## Executors

- [Kubernetes](kubernetes.html)
- [Cloud Run](cloud-run.html)

For documentation on building your own executor, see [here](../executors).
