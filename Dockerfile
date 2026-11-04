# Caddy for the app hosts of digital-organizing: the official image plus the
# modules it does not have. Versions are pinned here; to change one, change it
# here and push a new tag (see README.md).
ARG CADDY_VERSION=2.11.7

FROM caddy:${CADDY_VERSION}-builder AS build
# replace-response rewrites text in pages the proxy passes on from another
# site (campaign pages mirrored from Webflow under their own domain).
# caddy-dns/infomaniak lets Caddy prove a domain through DNS, which a wildcard
# certificate needs; the API token is given to the container, not kept here.
# caddy-ratelimit limits how many requests one visitor may make to a site or
# to a path of it.
RUN xcaddy build \
    --with github.com/caddyserver/replace-response@v0.0.0-20250618171559-80962887e4c6 \
    --with github.com/caddy-dns/infomaniak@v1.0.2 \
    --with github.com/mholt/caddy-ratelimit@5625512f24f6f59d6f64fb3aafe5eecff0b286db

FROM caddy:${CADDY_VERSION}
# The official image is not rebuilt for every Alpine fix (brotli-libs 1.2.1,
# 2026-11); take the package updates of its Alpine release at build time.
RUN apk upgrade --no-cache
COPY --from=build /usr/bin/caddy /usr/bin/caddy
