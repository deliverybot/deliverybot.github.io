---
layout: basic
title: Security
description: How to report a security issue in Deliverybot, and how the hosted service handles access, sessions and GitHub permissions.
---

# Security

Any significant updates to this document will be communicated via email.

## Reporting security issues

If you discover a security issue in Deliverybot, please report it by sending an
email to [{{site.security_email}}](mailto:{{site.security_email}}).

This will allow us to assess the risk, and make a fix available before we add a
public bug report or CVE. We will notify users via email of any critical
security vulnerabilities that may affect them.

## Patch management

Deliverybot runs as containers on a managed Kubernetes service, so the
underlying servers are patched by the provider. Security issues in
Deliverybot's dependencies will be patched as soon as is reasonably possible.
For critical issues we will issue a patch within 24 hours.

## Access management

Deliverybot operates under a principle of least privilege and aims to read the
least amount from your GitHub repository as possible. Deliverybot is focused
primarily on triggering GitHub events. GitHub only offers read access to
repository contents as a whole, but the only file Deliverybot reads is
`.github/deploy.yml`.

There are two access modes to Deliverybot:

- Web access (using oauth).
- Server access (using GitHub app JWT).

OAuth access handles any page that you access in your browser at
`app.deliverybot.dev`. Any API calls to GitHub are made using the current users
access token and we simply delegate to GitHub's access policies in this case for
controlling deployment access and other features.

Slack also uses the web access method. We simply associate a Slack user with a
GitHub user and store the access token connecting those accounts. **We do not
use this access token offline.**

Server access is for handling automatic deployments and other features where
Deliverybot needs to process events from your repository and respond with a
message to GitHub. This is handled using the GitHub app json web token.

## Account information

Account information is processed in adherence to our
[privacy policy](/terms/privacy). We always aim to store the minimum amount of
information required to process deployments across your repositories.

## Sessions

Sessions at `app.deliverybot.dev` are stored on the server and expire within
24 hours. The browser cookie only holds a signed session id. The session data,
including your GitHub OAuth token, is encrypted before it is stored.

## Access control

As mentioned, all access to deployments and other features is governed by a
users permissions on GitHub. A read only user on a repository will not have
the ability to deploy code using the web interface.

## Scopes

The following are the current permissions and events required with a short
description of why. You can confirm this by viewing permissions requested when
you install Deliverybot:

#### Checks `read`

https://developer.github.com/v3/apps/permissions/#permission-on-checks

Deliverybot must know when checks have changed state to trigger different
automatic deployment workflows.

#### Contents `read`

https://developer.github.com/v3/apps/permissions/#permission-on-contents

Deliverybot must know when push events occur to trigger automatic deployments,
and reads `.github/deploy.yml` and commit details to create them.

Note: We do not store your code. Unfortunately this is the only way we can
get access to push and commit events.

#### Deployments `write`

https://developer.github.com/v3/apps/permissions/#permission-on-deployments

Deliverybot triggers deployments :)

#### Issues `write`

https://developer.github.com/v3/apps/permissions/#permission-on-issues

Deliverybot reacts to `/deploy` comments and replies when a deployment fails.

#### Metadata `read`

https://developer.github.com/v3/apps/permissions/#metadata-permissions


#### Pull requests `write`

https://developer.github.com/v3/apps/permissions/#permission-on-pull-requests

Deliverybot reads pull requests to deploy them with `/deploy` commands, and
reacts and replies to those commands. GitHub requires this permission for
replies and reactions on pull requests in repositories with issues turned off.

#### Commit statuses `write`

https://developer.github.com/v3/apps/permissions/#permission-on-statuses

Deliverybot will write status checks for promoted builds or other step changes.
