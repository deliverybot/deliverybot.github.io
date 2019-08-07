---
layout: basic
title: Documentation
---

```bash
#!/bin/bash
# Usage: ./create-serviceaccount.sh [account-name: main]
# [context: main] [kubeconfig: kubeconfig] [namespace: kube-system]
# [clusterrole: cluster-admin]
#
# Creates a service account and assigns it to the specified cluster role.

SERVICEACCOUNT="${1:-main}"
echo "ServiceAccount: ${SERVICEACCOUNT}"

NAME="${2:-main}"
echo "Context:        ${NAME}"

CONFIG="${3:-kubeconfig}"
echo "Kubeconfig:     ${CONFIG}"

NAMESPACE="${4:-kube-system}"
echo "Namespace:      ${NAMESPACE}"

CLUSTERROLE="${5:-cluster-admin}"
echo "ClusterRole:    ${CLUSTERROLE}"

CONTEXT=$(kubectl config current-context)
echo "Context:        ${CONTEXT}"

CLUSTER=$(kubectl config get-contexts "$CONTEXT" | awk '{print $3}' | tail -n 1)
echo "Cluster:        ${CLUSTER}"

ENDPOINT=$(kubectl config view -o jsonpath="{.clusters[?(@.name == \"${CLUSTER}\")].cluster.server}")
echo "Endpoint:       ${ENDPOINT#*//}"

echo ""

echo "Creating service account..."
kubectl -n $NAMESPACE create serviceaccount ${SERVICEACCOUNT}

echo "Creating cluster role binding..."
kubectl -n $NAMESPACE create clusterrolebinding ${SERVICEACCOUNT} \
  --clusterrole=${CLUSTERROLE} \
  --serviceaccount=${NAMESPACE}:${SERVICEACCOUNT}

echo "Getting service account secret..."
SECRET=$(kubectl -n $NAMESPACE get sa/${SERVICEACCOUNT} -o json | jq -r '.secrets[0].name')

echo "Getting ca..."
CA=$(kubectl get secret -n $NAMESPACE $SECRET -o json | jq -r '.data["ca.crt"]')

echo "Getting token..."
TOKEN=$(kubectl get secret -n $NAMESPACE $SECRET -o json | jq -r '.data["token"]' | base64 --decode)

echo "Writing kubeconfig to $CONFIG..."
cat > $CONFIG <<EOF
apiVersion: v1
kind: Config
current-context: ${NAME}
clusters:
- name: ${NAME}
  cluster:
    server: ${ENDPOINT}
    certificate-authority-data: ${CA}
users:
- name: ${NAME}
  user:
    token: ${TOKEN}
contexts:
- name: ${NAME}
  context:
    cluster: ${NAME}
    user: ${NAME}
EOF
```
