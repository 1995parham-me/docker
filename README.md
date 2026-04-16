<h1 align="center"> The 1995parham's Handy Docker Image </h1>

<p align="center">
  <img alt="GitHub Workflow Status" src="https://img.shields.io/github/actions/workflow/status/1995parham-me/docker/build.yaml?logo=github&style=for-the-badge">
  <img alt="GitHub License" src="https://img.shields.io/github/license/1995parham-me/docker?logo=gnu&style=for-the-badge">
  <img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/1995parham-me/docker?logo=github&style=for-the-badge">
  <img alt="GitHub repo size" src="https://img.shields.io/github/repo-size/1995parham-me/docker?logo=github&style=for-the-badge">
  <img alt="Alpine Linux" src="https://img.shields.io/badge/Alpine-3.23-0D597F?logo=alpinelinux&style=for-the-badge">
</p>

<p align="center">
  <img alt="Image Version" src="https://ghcr-badge.egpl.dev/1995parham-me/docker/latest_tag?label=version&color=%2344cc11">
  <img alt="Image Size" src="https://ghcr-badge.egpl.dev/1995parham-me/docker/size?label=image+size&color=%2344cc11">
</p>

## Introduction

There are some times that I need to debug an issue on Kubernetes (on Cloud)
and those times I need a pod with some networking/debugging utilities to I can run it,
attach to it and start investigating. This image is created for those hard times.

## How to?

You can run the debug pod as follows on Kubernetes:

```bash
kubectl run 1995parham --image=ghcr.io/1995parham-me/docker:latest --image-pull-policy=Always --rm -it --restart=Never --command -- <command>
```

## Alternatives

- [@nicolaka/netshoot](https://github.com/nicolaka/netshoot)
