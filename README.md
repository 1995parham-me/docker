# The 1995parham's Docker Image

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/1995parham-me/docker/build.yaml?label=build&logo=github&style=flat-square&branch=main)

## Introduction

There are some times that I need to debug an issue on Kubernetes (on Cloud)
and those times I need a pod with some networking/debugging utilities to I can run it,
attach to it and start investigating. This image is create for those hard times.

## How to

You can run the debug pod as follows on Kubernetes:

```bash
kubectl run 1995parham --image=ghcr.io/1995parham-me/docker:latest --image-pull-policy=Always --rm -it --restart=Never --command --timeout 10m -- <command>
```
