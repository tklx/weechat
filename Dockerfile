FROM tklx/base:stretch

ENV TINI_VERSION=v0.14.0
ENV TINI_HASH=eeffbe853a15982e85d923390d3a0c4c5bcf9c78635f4ddae207792fa4d7b5e6
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN set -x \
    && echo -n "${TINI_HASH}  /tini" | sha256sum --strict --check - \
    && chmod +x /tini

RUN set -x \
    && apt-get update \
    && apt-get -y install ncurses-base weechat weechat-plugins \
    && apt-clean --aggressive

RUN set -x \
    && apt-get update \
    && apt-get -y install python-potr weechat-scripts \
    && apt-clean --aggressive

RUN adduser --disabled-login --gecos '' user
USER user
WORKDIR /home/user

EXPOSE 9001
COPY entrypoint /entrypoint
ENTRYPOINT ["/tini", "--", "/entrypoint"]
CMD ["weechat"]
