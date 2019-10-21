---
layout: page
title: Documentation
---

# Getting started

Deliverybot is a GitHub app, to get started with deployments we need a
repository and to install the Deliverybot app onto that repo. The below guide
will walk you through getting an example repository setup.

### 1. [Fork the example repository][example]{:target="_blank"}

Visit one of the example repositories and create a new fork:

- [Basic example that doesn't actually deploy][example]{:target="_blank"}.
- [GitOps example with FluxCD][example-gitops]{:target="_blank"}.
- [Helm example with actions and pr environments][example-helm]{:target="_blank"}.

### 2. [Install the Deliverybot GitHub app][app]{:target="_blank"}

Sign up and connect the application to your GitHub
repository.

### 3. Push a commit to watch the workflows kick off!

Go to your repository and push a commit.

<hr>

Once you have a working example you can read more [recipes][recipes] to get you
started. Read about [how it works][how] for a more in depth perspective on how
Deliverybot deploys your code. If you are trying to get deployments running for
a specific platform, look at [our guides.][guides]

[app]: {{site.start_url}}
[how]: /docs/how-it-works
[recipes]: /docs/recipes
[guides]: /docs/integrations
[example]: https://github.com/deliverybot/example
[example-helm]: https://github.com/deliverybot/example-helm
[example-gitops]: https://github.com/deliverybot/example-gitops
