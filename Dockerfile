ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION} AS base
RUN apk add --no-cache libstdc++

FROM base AS build
RUN apk add --no-cache alpine-sdk
ARG JEMALLOC_VERSION
RUN wget -O - https://github.com/facebook/jemalloc/releases/download/${JEMALLOC_VERSION}/jemalloc-${JEMALLOC_VERSION}.tar.bz2 | tar -xj && \
	cd jemalloc-${JEMALLOC_VERSION} && \
	./configure && \
	make && \
	make install

FROM base
COPY --from=build /usr/local/lib/libjemalloc* /usr/local/lib/
ENV LD_PRELOAD=/usr/local/lib/libjemalloc.so.2
CMD ["/bin/sh"]
