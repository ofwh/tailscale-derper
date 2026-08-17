# Derper

[![docker workflow](https://github.com/ofwh/tailscale-derper/actions/workflows/docker-image.yml/badge.svg)](https://hub.docker.com/r/ghcr.io/ofwh/derper)
[![docker pulls](https://img.shields.io/docker/pulls/ofwh/derper.svg?color=brightgreen)](https://hub.docker.com/r/ofwh/derper)
[![platfrom](https://img.shields.io/badge/platform-amd64%20%7C%20arm64-brightgreen)](https://hub.docker.com/r/ghcr.io/ofwh/derper/tags)

# Setup

> required: set env `DERP_DOMAIN` to your domain

```bash
docker run -e DERP_DOMAIN=derper.example.com -p 80:80 -p 443:443 -p 3478:3478/udp ghcr.io/ofwh/derper
```

| env                              | required | description                                                                        | default value     |
| -------------------------------- | -------- | ---------------------------------------------------------------------------------- | ----------------- |
| DERP_DOMAIN                      | true     | derper server hostname                                                             | your-hostname.com |
| DERP_CERT_DIR                    | false    | directory to store LetsEncrypt certs(if addr's port is :443)                       | /app/certs        |
| DERP_CERT_MODE                   | false    | mode for getting a cert. possible options: manual, letsencrypt                     | letsencrypt       |
| DERP_ADDR                        | false    | listening server address                                                           | :443              |
| DERP_STUN                        | false    | also run a STUN server                                                             | true              |
| DERP_STUN_PORT                   | false    | The UDP port on which to serve STUN.                                               | 3478              |
| DERP_HTTP_PORT                   | false    | The port on which to serve HTTP. Set to -1 to disable                              | 80                |
| DERP_VERIFY_CLIENTS              | false    | verify clients to this DERP server through a local tailscaled instance             | false             |
| DERP_VERIFY_CLIENT_URL           | false    | if non-empty, an admission controller URL for permitting client connections        | ""                |
| DERP_VERIFY_CLIENT_URL_FAIL_OPEN | false    | whether to fail open (allow access) if the `DERP_VERIFY_CLIENT_URL` is unreachable | true              |

# Usage

Fully DERP setup offical documentation: https://tailscale.com/kb/1118/custom-derp-servers/

## Client verification

In order to use `DERP_VERIFY_CLIENTS`, the container needs access to Tailscale's Local API, which can usually be accessed through `/var/run/tailscale/tailscaled.sock`. If you're running Tailscale bare-metal on Linux, adding this to the `docker run` command should be enough: `-v /var/run/tailscale/tailscaled.sock:/var/run/tailscale/tailscaled.sock`

---

Fork from [kaaanata/derper-docker](https://github.com/kaaanata/derper-docker)
