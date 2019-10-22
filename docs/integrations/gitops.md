---
layout: page
title: GitOps
group: Integrations
---

# GitOps

GitOps is a pattern for deploying to Kubernetes through a GitHub repository as
an intermediary. This works well with a system like Deliverybot. Instead of
running the actual deployment inside GitHub actions, we can run a script to edit
our Kubernetes manifests. This implements the "push" GitOps workflow. There's
an extra layer of security to this model since our Kubernetes cluster is pulling
from a protected GitHub repository which removes certain types of attacks by
ensuring that our CI system doesn't have access to Kubernetes.

![Flux diagram](/assets/images/integrations/flux.svg)

This example sets up a GitHub repository as a source of truth for [Flux][flux]
to read and to apply manifests into your Kubernetes cluster. It also has a
corresponding GitHub action which can push manifests to this repository to
deploy your code.

This brings the benefits of GitOps together with the ease of managing deployment
automation with Deliverybot. Click a button and watch manifests be updated and
deployed to your Kubernetes cluster!

**This is currently in beta and the API around this may change.**

## Getting started

Requires `cfssl` to be installed along with `helm` and `kubectl`.

1. Copy the https://github.com/deliverybot/example-gitops repository into your
   organization.

2. Run the [`./install.sh`](install.sh) script to setup FluxCD or follow this
   guide [here][flux-guide]. This will add the Flux operator along with the Flux
   Helm operator to deploy your manifests from the example repository.

```bash
GIT_REPO=git@github.com:myrepo/example-gitops.git GIT_PATH=deploy NAMESPACE=kube-system ./install.sh
```

3. You will then have to follow the [Flux guide][flux-key] for adding a deploy
   key to your example repository.

4. Create a new repository to emulate an application that you want to deploy to
   Kubernetes and install the GitOps action https://github.com/deliverybot/gitops

5. [Install the repository][deliverybot] on Deliverybot.

6. Trigger a deployment and watch the action push a change to your flux repo!

[flux]: https://fluxcd.io
[flux-guide]: https://docs.fluxcd.io/projects/helm-operator/en/latest/tutorials/get-started.html
[flux-key]: https://docs.fluxcd.io/projects/flux/en/latest/tutorials/get-started.html#giving-write-access
[deliverybot]: https://github.com/apps/deliverybot/installations/new
