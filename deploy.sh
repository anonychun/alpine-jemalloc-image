#!/bin/bash

read -p "ALPINE VERSION: " ALPINE_VERSION
read -p "JEMALLOC VERSION: " JEMALLOC_VERSION

IMAGE_NAME=anonychun/alpine-jemalloc
TAG=$ALPINE_VERSION-$JEMALLOC_VERSION

docker buildx build \
	--build-arg ALPINE_VERSION=$ALPINE_VERSION \
	--build-arg JEMALLOC_VERSION=$JEMALLOC_VERSION \
	--platform linux/amd64,linux/arm64 \
	-t $IMAGE_NAME:$TAG \
	--push .
