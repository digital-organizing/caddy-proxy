# caddy-proxy

The Caddy image the app hosts of digital-organizing run as their proxy: the
official `caddy` image with one extra module,
[replace-response](https://github.com/caddyserver/replace-response).

It holds no configuration. Which app host runs which tag, and the proxy's
config, are in the `infra` repository (role `caddy_proxy`).

## Images

`ghcr.io/digital-organizing/caddy-proxy`, public.

| Tag | Built from |
|---|---|
| `2.11.7-1`, and so on | the git tag `v2.11.7-1`: Caddy's version, then our own count |
| `main` | the latest commit on `main`; for trying, not for the app hosts |

## Changing the Caddy version or a module

1. Change `CADDY_VERSION` or the module line in the `Dockerfile` and merge.
2. Tag the commit: `git tag v<caddy version>-<count>` and push the tag. The
   count starts again at 1 with a new Caddy version.
3. In `infra`, set `caddy_proxy_image_tag` to the new tag and apply.

A pull request builds the image without pushing it, so a module that does not
build against the Caddy version shows before the merge.
