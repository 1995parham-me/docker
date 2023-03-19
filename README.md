# Docker Image

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/1995parham-me/docker/build.yaml?label=build&logo=github&style=flat-square&branch=main)

## Introduction

1995parham's docker image contains tools I use them more for debugging and etc.

# How to 

You can run the debug pod as follow on Kubernetes:

```sh
kubectl run 1995parham --image=ghcr.io/1995parham-me/docker:latest --image-pull-policy=Always --rm -it --restart=Never --command --timeout 10m -- <command>
```
