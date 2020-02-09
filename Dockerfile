FROM debian:stable-slim

ENV TINI_VERSION v0.18.0

ADD bin/crond-init.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/crond-init.sh && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends procps ca-certificates gnupg dirmngr cron && \
    sed -i -e '/pam_loginuid.so/s/^/#/' /etc/pam.d/cron* && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN gpg --batch --keyserver keyserver.ubuntu.com --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 && \
    gpg --batch --verify /tini.asc /tini && \
    chmod 0755 /tini

ENTRYPOINT ["/tini", "--"]
CMD ["/usr/local/bin/crond-init.sh"]
