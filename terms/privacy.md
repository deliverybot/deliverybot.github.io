---
layout: basic
title: Privacy Policy
description: What data the hosted Deliverybot service stores, why, and how to have it removed.
---

# Privacy Policy

## The short version

We store only what we need to run deployments for the repositories you give
{{ site.service_name }} access to. We don't sell your data, we don't show ads
and we don't use tracking or analytics cookies.

Updated October 12, 2026

__Who we are__

This policy covers the hosted {{ site.service_name }} service at
[{{ site.deliverybot_url }}]({{ site.deliverybot_url }}), the
{{ site.service_name }} GitHub App and Slack app, and this website
(together, the “Service”), operated by {{ site.corp_name }} (“we”, “us” or
“our”). {{ site.service_name }} is also open source; if you run it yourself,
this policy doesn't apply to your installation, and you are responsible for
the data it processes.

__What we collect__

- **GitHub account details.** When you sign in with GitHub we store your
  GitHub user id and username. GitHub sends us an access token so we can act
  on your behalf (for example, to start a deployment you asked for). That token
  is kept in your session, encrypted, and the session expires after a day.
- **Installation details.** When you install the GitHub App we store the
  installation id, the account it was installed on, which repositories it can
  access and whether the installation is suspended.
- **Repository data.** To run deployments we read the repositories you give
  the app access to, including the deployment configuration file, commits,
  pull requests, comments that mention {{ site.service_name }} and deployment
  statuses. We store the repository name and id, the last event we received
  for it, and the deployment state we need between events, such as locks and
  pending jobs. We don't copy your source code.
- **Slack details.** If you connect Slack, we store your Slack user id linked
  to your GitHub account and the GitHub token used to run your Slack commands.
- **Logs.** Our servers keep short-lived technical logs (such as request
  paths, IP addresses and errors) to operate and secure the Service.

We don't ask for your name, address or payment details. If we later offer
paid plans through GitHub Marketplace, GitHub handles the payment and shares
only the plan you chose with us; we'll update this policy before that
happens.

__How we use it__

We use this information only to provide, secure and support the Service:
running the deployments you or your configuration ask for, showing you your
repositories and deployments, answering your support requests, and
preventing abuse. The legal basis is that the processing is necessary to
provide the Service you asked for, and our legitimate interest in keeping it
secure and working.

__Cookies__

We set one cookie, `deliverybot.sid`, which keeps you signed in. It holds
only a signed session id. We don't use advertising, analytics or tracking
cookies, on the Service or on this website.

__Who we share it with__

We don't sell or rent your information. We share it only with:

- **GitHub** and, if you connect it, **Slack**, because the Service works by
  calling their APIs on your behalf. Their own privacy policies apply to the
  data they hold.
- **Our hosting provider**, DigitalOcean, which runs our servers and database
  in the European Union.
- **Authorities**, when the law requires it.

__How long we keep it__

Session data is deleted when the session expires. When you uninstall the
GitHub App, we delete the installation and the stored data for its
repositories; removing a repository from the installation deletes that
repository's data. Account details
are kept while you use the Service; ask us and we'll delete them.

__Your rights__

You can ask us for a copy of your data, to correct it, to delete it or to stop
processing it, and, if you are in the EU/EEA or UK, you can complain to your
data protection authority. Uninstalling the GitHub App and revoking its
access in your GitHub settings stops all processing for those repositories.

__Children__

The Service is not intended for anyone under 16, and we don't knowingly
collect their information.

__Security__

Data is encrypted in transit, and sessions are encrypted at rest. If you find
a security problem, please follow our [security policy]({{ site.security_url }}).

__Changes__

If we change this policy, we'll post the new version here and update the date
above. For significant changes we'll also announce them on this website.

__Contact__

Questions or requests about your data can go to
[{{ site.privacy_email }}](mailto:{{ site.privacy_email }}).
