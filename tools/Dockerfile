# syntax=docker/dockerfile:1
# The tools of bin/fetch, bin/convert and bin/check: pandoc, with Debian's
# Ruby (the scripts use Ruby's standard library only).
FROM pandoc/core:3.11.0-debian@sha256:18c3f4353a1326976bade7fb655747a83c7825db712968f8244d2c49d6a302bd
RUN apt-get update && apt-get install -y --no-install-recommends ruby ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /work
ENTRYPOINT []
