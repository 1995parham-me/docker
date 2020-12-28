# Kubernetes tools for OKD (Openshift Kubernetes Distribution)

## Introduction
docker build for Openshift Kubernetes Distribution, it can be used as normal kubectl tool as well.
based on [alpine/k8s](https://github.com/alpine-docker/k8s).

## Installed tools

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (eks versions: https://docs.aws.amazon.com/eks/latest/userguide/kubernetes-versions.html)
- [origin-client](https://github.com/openshift/okd) (latest release: https://github.com/openshift/okd/releases)
- [helm](https://github.com/helm/helm) (latest release: https://github.com/helm/helm/releases/latest)
- General tools, such as bash, curl

## Why we need it

Mostly it is used during CI/CD (continuous integration and continuous delivery) or as part of an automated build/deployment
