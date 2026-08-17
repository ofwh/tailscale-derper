FROM golang:latest AS builder
WORKDIR /app

ARG DERP_VERSION=latest
RUN go install tailscale.com/cmd/derper@${DERP_VERSION}

FROM ubuntu
WORKDIR /app

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y ca-certificates && \
    mkdir /app/certs

ENV DERP_DOMAIN=your-hostname.com \
    DERP_CERT_MODE=letsencrypt \
    DERP_CERT_DIR=/app/certs \
    DERP_ADDR=:443 \
    DERP_STUN=true \
    DERP_STUN_PORT=3478 \
    DERP_HTTP_PORT=80 \
    DERP_VERIFY_CLIENTS=false \
    DERP_VERIFY_CLIENT_URL="" \
    DERP_VERIFY_CLIENT_URL_FAIL_OPEN=true

COPY --from=builder /go/bin/derper .

CMD /app/derper --hostname=$DERP_DOMAIN \
    --certmode=$DERP_CERT_MODE \
    --certdir=$DERP_CERT_DIR \
    --a=$DERP_ADDR \
    --stun=$DERP_STUN  \
    --stun-port=$DERP_STUN_PORT \
    --http-port=$DERP_HTTP_PORT \
    --verify-clients=$DERP_VERIFY_CLIENTS \
    --verify-client-url=$DERP_VERIFY_CLIENT_URL \
    --verify-client-url-fail-open=$DERP_VERIFY_CLIENT_URL_FAIL_OPEN
