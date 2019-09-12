---
layout: page
title: Kubernetes
group: Guides
---

# Kubernetes guide

DRAFT

*This requires having GitHub actions enabled.*

> Note, if you want to just look at an example repo head over to [github.com/deliverybot/example-helm.](https://github.com/deliverybot/example-helm.)

GitHub actions are a fantastic new way of running code based on events from GitHub’s servers. Actions are simple workflows configured as Yaml files which run configurable steps of code. Useful for CI/CD pipelines and since they come bundled with GitHub, they reduce significantly the overhead in getting a CI/CD pipeline setup.

This tutorial will go through the basics of GitHub actions as well as deploying to Kubernetes using a pre-built Helm action. For this guide we’re assuming some basic knowledge of Helm but you’ll probably be able to follow along regardless. Let’s get started with some of the basic concepts of GitHub actions.

### The basics

The first concept to introduce is a workflow file. This is a pipeline similar to a Jenkinsfile that describes in Yaml format a set of steps to execute given a GitHub event. Workflow files contain jobs which are a set of steps run in parallel. Steps contain scripts and re-usable action code to actually run our automation. Let’s take a look at a basic workflow file below:

```yaml
name: 'Deploy'     # Name of the action.
on: ['deployment'] # Listen for deployment events.

jobs:
  deployment:
    runs-on: 'ubuntu-latest'
    steps:
    - name: 'Checkout'  # Checkout the repository code.
      uses: 'actions/checkout@v1'
```

The above GitHub action listens for a deployment event from GitHub and checks out the repository code. We don’t actually do any deployments in this step, that’s next.

Note that the uses directive actually refers to a GitHub repository. GitHub will actually clone that repository and run the code inside that repository as part of our job. This is one of the best parts about actions. Sharing modules is simple, straightforwards and built in right out of the box. There are already many modules available to do what you need.

### Helm action

We have an action that specifically deploys to Kubernetes using Helm which is one of the most common packaging formats for deploying your applications to Kubernetes.

This action is coming from the repository [github.com/deliverybot/helm](https://github.com/deliverybot/helm). Take a look for a full example of arguments that can be used in the Helm action.

```yaml {% raw %}
name: 'Deploy'     # Name of the action.
on: ['deployment'] # Listen for deployment events.

jobs:
  deployment:
    runs-on: 'ubuntu-latest'
    steps:
    - name: 'Checkout'  # Checkout the repository code.
      uses: 'actions/checkout@v1'

    - name: 'Deploy'
      uses: 'deliverybot/helm@master'
      with:
        token: '${{ github.token }}'
        chart: 'app'
      env:
        KUBECONFIG_FILE: '${{ secrets.KUBECONFIG }}' {% endraw %}
```

Now, what is this actually deploying you may be wondering? Helm, as you may know, is based on charts. Charts are modules that apply multiple Kubernetes resources under the hood. In the above code we’re using the “app” chart which is defined at [deliverybot/helm/charts/app](https://github.com/deliverybot/helm/tree/master/charts/app). This chart deploys the common resources needed for an http based application. The default image is set to nginx if you want to experiment with deploying a bare application.

We supply arguments to the action using the with directive. This actually, under the hood, translates these values into environment variables that are available for us to use inside the action code to execute our deployment. Let’s look at an example with some more arguments in the with parameter.

```yaml {% raw %}
...
- name: 'Deploy'
  uses: 'deliverybot/helm@master'
  with:
    token: '${{ github.token }}'
    chart: 'app'
    secrets: '${{ toJSON(secrets) }}'
    chart: 'app'
    namespace: production
    release: production-myapp
    value-files: './config/production.yml'
  env:
    KUBECONFIG_FILE: '${{ secrets.KUBECONFIG }}' {% endraw %}
```

These arguments specify some new variables that will be familiar to Helm users. One of the most interesting ones to call out is the value file argument. Since Helm charts often need to be customized for specific environments we can easily provide a value file which will be used as arguments for that specific deployment. Simply provide different value files per environment to keep your configuration consistent and clean. All of the values are defined in whatever chart you are using, for this example it is the [app](https://github.com/deliverybot/helm/tree/master/charts/app) chart that defines the values for us.

### Important variables

Now, at this point we’ve gone through and introduced a few concepts like value files and

### Secret management

Secret management is tricky to get right with Kubernetes. The above Helm action doesn’t try and solve all problems related to secret management but it does have a feature which can get you up and running quickly. The chart allows template variables inside your value files. One of the objects available for use is a secrets object. You define this when running the Helm action by setting the following variable:

```yaml {% raw %}
with:
  secrets: '${{ toJSON(secrets) }}' {% endraw %}
```

This is actually setting the secrets value to all secrets defined in our GitHub repository. Secrets are a new GitHub feature coming to all repositories for use with actions. Now, inside my value file, I can use the secrets key to create a Kubernetes application secret:

```yaml {% raw %}
    # config/values.yml
    secrets:
    - name: API_KEY
      value: '${{ secrets.API_KEY }}' {% endraw %}
```

The environment variable API_KEY will now be available inside my application after deployment. This is a simple, straightforward and relatively secure way of getting started with secret management on Kubernetes.

### Triggering deployments

Since this example presented so far relies on the GitHub deployments API we need a way of either manually or automatically triggering these deployments.
