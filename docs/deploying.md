---
layout: page
title: Deploying
---

# Deploying

Deliverybot is a [Probot](https://probot.github.io){:target="_blank"}
application that responds to events from GitHub and triggers deployments based
on actions in the application and check status events from GitHub.

It requires storage providers to be implemented as well as deployment
infrastructure to deploy the code. The following deployment targets are
implemented already to get you started quickly:

## Deployment targets

- [Firebase][firebase]
- [Kubernetes][kubernetes]

## Building A deployment target

Building a deployment target requires implementing a set of services defined in
[`@deliverybot/core`][core] and then providing an HTTP server implementation
that allows Deliverybot to receive HTTP traffic.

The [`@deliverybot/run`][run] package provides a local implementation for
spinning up services and the HTTP interface for local development. Use this
package as a starting point.

The `load` function exported from [`@deliverybot/core`][core] takes the services
you implement along with the apps which provide the main functionality to give
back a probot and express object to wire up to your infrastructure. A basic
example of booting Deliverybot:

```javascript
import { load, Options, localServices } from "@deliverybot/core";
import { apps } from "@deliverybot/app";

const options: Options = { ... };
load(localServices(), apps, options);
```

The main thing that you will need to replace when deploying the application is
the services implementation. The [services][services] file provides the
interfaces required by Deliverybot for your infrastructure.

### Extending functionality

As mentioned the `apps` argument is where all of the functionality is wired up.
You can easily extend Deliverybot with your own implementations and services
by adding an app into the load array.

[`@deliverybot/core`][core] provides information and documentation on wiring up
a new app for providing additional functionality.


[firebase]: https://github.com/deliverybot/deliverybot/tree/master/packages/firebase
[kubernetes]: https://github.com/deliverybot/deliverybot/tree/master/packages/kubernetes
[run]: https://github.com/deliverybot/deliverybot/tree/master/packages/run
[core]: https://github.com/deliverybot/deliverybot/tree/master/packages/core
[services]: https://github.com/deliverybot/deliverybot/blob/master/packages/core/src/services.ts
