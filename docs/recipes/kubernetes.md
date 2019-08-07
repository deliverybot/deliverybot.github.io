---
layout: page
title: Deploy to Kubernetes
group: Recipes
---

# Deploy to Kubernetes

To get a fully working setup on Kubernetes using an example application, follow
these steps below.

## Repo setup

First clone the [example repository](https://github.com/deliverybot/example).
This repo is setup with a base Kubernetes deployment ready to go. Second,
install deliverybot in your cloned repo <{{site.github_app_url}}>.

## Kubernetes setup

Setup a working Kubernetes cluster. On GKE the following command will work to
setup a cluster:

    gcloud container clusters create [CLUSTER_NAME]

You will also need access to the Kubernetes cluster:

    gcloud container clusters get-credentials [CLUSTER_NAME]

Now - we should have `kubectl` access to a Kubernetes cluster. We can then setup
a service account. Copy [the script](/docs/create-serviceaccount) and run it below to
create a kubeconfig output to `./kubeconfig` with credentials to your cluster.

    ./create-serviceaccount.sh deliverybot

We can now visit the [deliverybot app]({{site.deliverybot_url}}) and add the
file `./kubeconfig` as a secret named `KUBECONFIG`. To do this, visit the
secrets tab and click "Add variable." Then, add the name and paste in the value
from the file.

![secrets](/assets/images/secrets.png)

## Verification

Now, to test that the workflow is complete we can visit
[deliverybot]({{site.deliverybot_url}}) and navigate to the cloned example app.
Click the latest commit to deploy it.
