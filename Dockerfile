# Caddy for the app hosts of digital-organizing: the official image plus the
# modules it does not have. Versions are pinned here; to change one, change it
# here and push a new tag (see README.md).
ARG CADDY_VERSION=2.11.7

FROM caddy:${CADDY_VERSION}-builder AS build
# replace-response rewrites text in pages the proxy passes on from another
# site (campaign pages mirrored from Webflow under their own domain).
RUN xcaddy build \
    --with github.com/caddyserver/replace-response@v0.0.0-20250618171559-80962887e4c6

FROM caddy:${CADDY_VERSION}
COPY --from=build /usr/bin/caddy /usr/bin/caddy
