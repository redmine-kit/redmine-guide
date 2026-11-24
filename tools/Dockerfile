# syntax=docker/dockerfile:1
# The tools of bin/fetch, bin/convert and bin/check: pandoc, with Debian's
# Ruby (the scripts use Ruby's standard library only).
FROM pandoc/core:3.14.0-debian@sha256:868ad590bebc35eba51031548c5344138ea1ead0ab75f379208994e982fec28e
RUN apt-get update && apt-get install -y --no-install-recommends ruby ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /work
ENTRYPOINT []
