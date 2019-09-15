---
layout: post
title:  "Kustomize: Deploying applications using the new Kubernetes templating system"
description: Kustomize is a new way of templating in Kubernetes. It's not strictly a templating system — a better way to describe it is “customization for your Kubernetes yaml files” — but achieves the same goal for most of us. This post explores this new system.
---

# Kustomize: Deploying applications using the new Kubernetes templating system

{% raw %}
I recently went to survey some of the Kubernetes landscape in deployment automation to find out what’s been newly developed in the community. I quickly came across a new templating system Kustomize. It’s not strictly a templating system in the way we think about it — a better way to describe it is “customization for your Kubernetes yaml files” — but achieves the same goal for most of us.

First, what is this Kustomize thing? Effectively, Kustomize is an overlay system that let’s you override values in your Kubernetes manifests. It gives us a directory structure that looks something like the following:

    ~/app
    ├── base
    │   ├── deployment.yaml
    │   └── kustomization.yaml
    └── overlays
        ├── development
        │   ├── deployment.yaml
        │   ├── kustomization.yaml
        └── production
            ├── deployment.yaml
            └── kustomization.yaml

Overlays provide the mechanism to change values across your core Kubernetes manifests. One of the main differences with something like Helm is that the overrides are specified in regular Kubernetes yaml syntax. This is the key innovation with Kustomize. I may have a very simple “base” Kubernetes manifest that looks like this (some yaml omitted for brevity):

```yaml
# ~/app/base/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app
spec:
  replicas: 1
  ...
```

Now, in my environment specific override files, I can include an override that bumps replicas for a specific environment. For example:

```yaml
# ~/app/overlays/production/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app
spec:
  replicas: 3
  ...
```

Now, when I apply my manifests into Kubernetes I can select the production overlay. Kustomize figures out the differences and merges the configuration together. This results in 3 replicas of my deployment resource running in production. On my staging server, I may specify only a single replica or vary labels or names of resources.

This is the first powerful feature of Kustomize that is probably the most useful. The overlays feature allows working with bare Kubernetes yaml but changing values between environments.

### Applying Kustomize configurations

The Kustomization files in the tree shown above are relatively simple. They simply describe the manifests that they are responsible for. The base Kustomize file looks like:

```yaml
# ~/app/base/kustomization.yaml
resources:
- ./deployment.yaml
```

And the overlay file simply specifies the base:

```yaml
# ~/app/base/kustomization.yaml
resources:
- deployment.yaml
bases:
- ../../base
```

Actually applying these files is simple:

    kubectl apply -k overlays/production

Kustomize comes as a separate CLI that you can work with. Here, with the latest version of kubectl, we can use this simply as a flag to trigger the new behaviour. At this stage we’ve successfully applied manifests into Kubernetes with slight differences between production and staging using only Kubernetes manifests and tooling built into kubectl.

### More complex transformations

Let’s explore a few more powerful features of Kustomize. One of the core ideas behind Kustomize is the concept of a “transformer.” This is code built in to Kustomize that transforms your Kubernetes manifests given a declarative and simple set of rules. You can customize these transformer’s but some of the built in ones are incredibly useful. Below is an example of some of the most common transformations available:

```yaml
# kustomization.yaml
namespace: production
namePrefix: production-
nameSuffix: -v1
```

For every resource we load we can prefix and suffix the name of that resource with the string provided. This is very useful for deploying the same group of manifests within the same namespace. We can also apply a namespace to all resources, simply by specifying the namespace parameter.

Probably one of the most useful transformations for every day is the image transformer. This changes image tags that exist in Kubernetes manifests to new versions:

```yaml
# kustomization.yaml
images:
- name: nginx
  newTag: v1
```

If we have a deployment that specifies the nginx image, after Kustomize has completed it’s work, this new image will now have the tag “v1” applied. This is a very useful transformation to apply in a CI pipeline right before deployment. The [Kustomize CLI](https://github.com/kubernetes-sigs/kustomize) has edit commands that can add statements like this to your Kustomization file on the fly.

## Why use Kustomize?

For a lot of companies, working with Kubernetes means diving into helm charts. Helm charts have become somewhat of a defacto standard for shipping applications on top of Kubernetes. For a lot of use cases Helm has some unneeded complexity. Some of the common problems with helm:

* Server side tiller component has too much power inside the Kubernetes cluster.

* The way helm applies resources sometimes leads to a difference between desired and actual states.

It’s common for smaller Kubernetes deployments to move towards a deployment system just using helm as a templating language, with deployment steps that look like this:

    helm template ./charts/my-chart | kubectl apply -f -

This is very similar to the goals of Kustomize. If you need to simply replace variables and overlay simple values in your Kubernetes manifests then Kustomize may offer better flexibility in this area.

### Some of the problems

One of the first roadblocks I hit with Kustomize was a lack of literal variables. If you are looking to do something similar to this:

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: app
spec:
  rules:
  - host: "{{ host }}"
```

You are pretty much out of luck with Kustomize. The recommended way of doing this is to manage these with JSON patch, inside the configuration file this would look like:

```yaml
- op: replace
  path: /spec/rules/0/host
  value: foo.bar.io
```

Unfortunately I think that for a lot of teams this method of maintaining configuration will get unwieldy quite quickly. It can actually be a very serious configuration issue if you have an undefined host variable. The official recommendation from the Kustomize team is to use something like envsubst or another templating language alongside your Kustomize configurations.

## Summary

In essence, Kustomize is a useful addition to your Kubernetes toolkit. It can wire up some of the more tedious templating issues that you may face but it’s definitely not the full answer. For teams looking to ship applications, Helm is probably going to be the simplest and most tried and tested solution at this point.

[I put together a few scripts for deploying using Kustomize](https://gist.github.com/colinjfw/58ec321708b761b79c0fd9c33eec8716) that I may use down the road for deploying to Kubernetes. Check them out and feel free to comment on your improvements.

{% endraw %}
