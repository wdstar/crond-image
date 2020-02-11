FROM debian:stable-slim AS builder

ARG TINI_VER=v0.18.0

RUN apt-get update && \
    apt-get install -y --no-install-recommends gnupg

ADD https://github.com/krallin/tini/releases/download/${TINI_VER}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VER}/tini.asc /tini.asc
RUN gpg --batch --keyserver keyserver.ubuntu.com --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 && \
    gpg --batch --verify /tini.asc /tini && \
    chmod 0755 /tini

FROM debian:stable-slim

COPY --from=builder /tini /tini
ADD bin/crond-init.sh /usr/local/bin/

RUN chmod 0755 /usr/local/bin/crond-init.sh && \
    apt-get update && \
    apt-get install -y --no-install-recommends procps ca-certificates cron && \
    sed -i -e '/pam_loginuid.so/s/^/#/' /etc/pam.d/cron* && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/tini", "--"]
CMD ["/usr/local/bin/crond-init.sh"]
