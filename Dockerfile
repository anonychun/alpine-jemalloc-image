ARG ALPINE_VERSION=0
FROM alpine:${ALPINE_VERSION} AS base
RUN apk add --no-cache libstdc++

FROM base AS build
RUN apk add --no-cache alpine-sdk
ARG JEMALLOC_VERSION=0
RUN wget -O - https://github.com/jemalloc/jemalloc/releases/download/${JEMALLOC_VERSION}/jemalloc-${JEMALLOC_VERSION}.tar.bz2 | tar -xj && \
    cd jemalloc-${JEMALLOC_VERSION} && \
    ./configure && \
    make && \
    make install

FROM base
COPY --from=build /usr/local/lib/libjemalloc* /usr/local/lib/
ENV LD_PRELOAD=/usr/local/lib/libjemalloc.so.2
CMD ["/bin/sh"]
