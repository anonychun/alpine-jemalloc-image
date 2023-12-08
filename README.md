# alpine-jemalloc-image

[![Docker Hub](https://img.shields.io/badge/%20-DockerHub-blue?logo=docker)](https://hub.docker.com/r/anonychun/alpine-jemalloc)
[![Docker Pulls](https://img.shields.io/docker/pulls/anonychun/alpine-jemalloc.svg)](https://hub.docker.com/r/anonychun/alpine-jemalloc/)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/anonychun/alpine-jemalloc?sort=date)](https://hub.docker.com/r/anonychun/alpine-jemalloc/)

This repository contains scripts for creating docker images that are available in multiple variants. The goal is to publish docker images with operational jemalloc libraries, maintaining minimal size while providing full functionality.

Older versions of alpine do not include a jemalloc package in the official repositories. If you are using a newer version of alpine, you can install jemalloc with `apk add jemalloc`, and this image becomes unnecessary.

Jemalloc is a general-purpose malloc(3) implementation that focuses on minimizing fragmentation and supporting scalable concurrency. It is especially efficient in managing dynamic memory allocation and deallocation in concurrent environments.

## Naming

The published images adhere to a naming convention.

### Image Name

The image name follows the format:

`anonychun/alpine-jemalloc`

### Tags

The tags represent version numbers and follow the format:

`<1>-<2>`

- `<1>` corresponds to the version of the alpine image.
- `<2>` corresponds to the jemalloc version.

For example: `3.16-5.3.0`

## Available Images

### anonychun/alpine-jemalloc

You can use this image as a base for your projects. If a version you require is missing, please open an issue in this repository.

#### Docker Hub

```yaml
FROM anonychun/alpine-jemalloc:<version>
```

```bash
docker pull anonychun/alpine-jemalloc:<version>
```

## Other Images

If you are using another image based on alpine, you can use the following Dockerfile as a starting point. Simply replace `ruby:3.2.2-alpine3.16` with the alpine-based image you wish to use.

```Dockerfile
FROM anonychun/alpine-jemalloc:3.16-5.3.0 AS jemalloc
FROM ruby:3.2.2-alpine3.16 AS base

# Copy the jemalloc libraries
COPY --from=jemalloc /usr/local/lib/libjemalloc* /usr/local/lib/

# Set jemalloc as the default allocator
ENV LD_PRELOAD=/usr/local/lib/libjemalloc.so.2
```

## Contribute

Feel free to open an issue or a pull request with suggestions.

Please note that the build process for these images can be quite time-consuming.
