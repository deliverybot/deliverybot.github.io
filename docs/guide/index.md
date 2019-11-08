---
layout: page
title: Guide
group: Guide
---

# Guide

The official Deliverybot guide over the next sections will go through setting
up a production grade deployment pipeline for an organization using Deliverybot
and other GitHub tools.

{%- for page in site.pages %}
{%- if page.group == "Guide" and page.title != "Guide" %}
1. [{{ page.title }}]({{page.url}})
{%- endif %}
{%- endfor %}

## What we'll be doing

We'll be setting up a pipeline that deploys code using the following workflow:

```
+--------------+       +-------------+       +------------+
| Pull request | ----> |   Staging   | ----> | Production |
+--------------+       +-------------+       +------------+

  √ Build                √ Deploy              √ Deploy
  √ Test                 √ Approve             √ Rollback
  √ Lint                                       √ Locking
  √ PR Deploy                                  √ Canary
  √ Approve
```

At the end of this we'll have a repository that looks like this example
<https://github.com/deliverybot/example> if you want to jump ahead.

This is a typical and safe workflow for most organizations to follow. When a
developer spins up a pull request we'll do the typical CI workflows with
lint, test and build stages. We'll also additionally deploy this code to a PR
environment like `pr123.example.com` that you can use for acceptance testing
and checks that require a version of the app running.

When the pull request is deemed ready and the code is approved this code will
be merged into master. Deliverybot then deploys to a staging environment with
more resources available where we can validate the code. We can also run some
end to end tests here and we'll require that this code is checked off by a QA
as well.

Finally, once those steps are passed we can deploy this commit to production.
this will happen manually so that the developer is aware and can rollback if
any errors do occur. We'll also discuss strategies for monitoring during this
phase and also automated rollbacks.

## How this guide works

This guide is agnostic to where you are deploying to and instead focuses on the
processes around your deployment practices. Deliverybot decouples the
deployment processes from the underlying technology, so anything in this guide
is compatible with all of the available [integrations](/docs/integrations) or
your own deployment methods.

All of the integrations will use stubbed GitHub actions since this is the
simplest way to get up and running. However, since everything is just responding
to a GitHub webhook, your own code is fully capable of executing all of these
workflows.

We will also link in the footer of the guide to the available integrations
and recipes that will allow you to wire up actual deployments and tests
throughout the process.

Let's get started :)

## First steps

1. Create a blank GitHub repository that we can use for the guide.
2. [Install the Deliverybot GitHub app][app]{:target="_blank"} on the repo.

## Next

[Start with PR configuration >>](/docs/guide/1-pr-ci)

[app]: {{site.start_url}}
