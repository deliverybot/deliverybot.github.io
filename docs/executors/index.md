---
layout: page
title: Executors
group: Executors
---

# Executors

Executors are docker containers that implement a specification and are
executed to deliver your deployments. This is configured by what goes in the
`exec` field in your configuration file. If this field is not present,
deliverybot will not attempt to actually deliver your deployment.

```yaml
# .github/deploy.yml
production:
  exec: ...
```

An executor configuration looks as follows. The image name currently may only
be one of two types:

- [`helm`](helm)
- [`cloud-run`](cloud-run)

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

Everything in `params` is passed to the executor and follows the format that
the individual executor specifies.

## Next

Read documentation for the individual executors to learn about what parameters
are available for use.

- [Helm](helm)
- [Cloud Run`](cloud-run)

