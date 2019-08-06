---
layout: page
title: Kubernetes
group: Executors
---

# Helm

Deploys services to Kubernetes.

## Secrets

- `KUBECONFIG` (Required): A Kubeconfig file with access to a Kubernetes
  cluster.

## Parameters

```yaml {% raw %}
# .github/deploy.yml
mytarget:
  exec:
    image: helm
    params:
      namespace: default # required, namespace
      chart: my-chart # chart name, defaults to "charts/default"
      release: my-release # required, helm release name
      image:
        repository: gcr.io/project/service # required, image name
        tag: "{{short_sha}}" # required, image tag
{% endraw %}
```

For a preview environment in a pull request:

```yaml {% raw %}
# .github/deploy.yml
mytarget:
  exec:
    image: helm
    params:
      namespace: default
      release: my-release-{{pr}} # dynamic release name
      image:
        repository: gcr.io/project/service
        tag: "{{short_sha}}"
{% endraw %}
```

### Repository Chart

You can load a chart from your apps repository by specifying a relative path to
the  chart with the repository name included in the path.

```yaml
chart: "./<my-repo>/charts/<name>"
```

### Default Chart Parameters

The default chart is selected if you do not specify the `exec.params.chart`
field. This chart is stored at:
<https://github.com/deliverybot/deliverybot/tree/master/executors/helm/charts/deliverybot-default>

This chart is originally adopted from the GitLab auto devops chart as this is a
good base.
<https://gitlab.com/gitlab-org/charts/auto-deploy-app>

The parameters listed below may be specified in `exec.params`:

| Parameter                     | Description | Default                            |
| ---                           | ---         | ---                                |
| replicaCount                  |             | `1`                                |
| image.repository              |             | `""` |
| image.tag                     |             | `""`                           |
| image.pullPolicy              |             | `Always`                           |
| image.secrets                 |             | `[]`          |
| podAnnotations                | Pod annotations | `{}`                           |
| application.track             |             | `stable`                           |
| application.tier              |             | `web`                              |
| application.migrateCommand    | If present, this variable will run as a shell command within an application Container as a Helm pre-upgrade Hook. Intended to run migration commands. | `nil` |
| application.initializeCommand | If present, this variable will run as shall command within an application Container as a Helm post-install Hook. Intended to run database initialization commands. | `nil` |
| application.secretName        | Pass in the name of a Secret which the deployment will [load all key-value pairs from the Secret as environment variables](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#configure-all-key-value-pairs-in-a-configmap-as-container-environment-variables) in the application container. | `nil` |
| application.secretChecksum    | Pass in the checksum of the secrets referenced by `application.secretName`. | `nil` |
| hpa.enabled                   | If true, enables horizontal pod autoscaler. A resource request is also required to be set, such as `resources.requests.cpu: 200m`.| `false` |
| hpa.minReplicas               |             | `1`                                |
| hpa.maxReplicas               |             | `5`                                |
| hpa.targetCPUUtilizationPercentage | Percentage threshold when HPA begins scaling out pods | `80` |
| service.enabled               |             | `true`                             |
| service.annotations           | Service annotations | `{}`                       |
| service.name                  |             | `web`                              |
| service.type                  |             | `ClusterIP`                        |
| service.url                   |             | `http://my.host.com/`              |
| service.additionalHosts       | If present, this list will add additional hostnames to the server configuration. | `nil` |
| service.commonName            | If present, this will define the ssl certificate common name to be used by CertManager. `service.url` and `service.additionalHosts` will be added as Subject Alternative Names (SANs) | `nil` |
| service.externalPort          |             | `5000`                             |
| service.internalPort          |             | `5000`                             |
| ingress.tls.enabled           | If true, enables SSL | `true`                    |
| ingress.tls.secretName        | Name of the secret used to terminate SSL traffic | `""` |
| ingress.annotations           | Ingress annotations | `{kubernetes.io/tls-acme: "true", kubernetes.io/ingress.class: "nginx"}` |
| livenessProbe.path            | Path to access on the HTTP server on periodic probe of container liveness. | `/`                                |
| livenessProbe.scheme          | Scheme to access the HTTP server (HTTP or HTTPS). | `HTTP`                                |
| livenessProbe.initialDelaySeconds | # of seconds after the container has started before liveness probes are initiated. | `15`                               |
| livenessProbe.timeoutSeconds  | # of seconds after which the liveness probe times out. | `15`                               |
| readinessProbe.path           | Path to access on the HTTP server on periodic probe of container readiness. | `/`                                |
| readinessProbe.scheme         | Scheme to access the HTTP server (HTTP or HTTPS). | `HTTP`                                |
| readinessProbe.initialDelaySeconds | # of seconds after the container has started before readiness probes are initiated. | `5`                                |
| readinessProbe.timeoutSeconds | # of seconds after which the readiness probe times out. | `3`                                |
| postgresql.enabled            |             | `true`                             |
| podDisruptionBudget.enabled   |             | `false`                            |
| podDisruptionBudget.maxUnavailable |             | `1`                            |
| podDisruptionBudget.minAvailable | If present, this variable will configure minAvailable in the PodDisruptionBudget. :warning: if you have `replicaCount: 1` and `podDisruptionBudget.minAvailable: 1` `kubectl drain` will be blocked.              | `nil`                            |
