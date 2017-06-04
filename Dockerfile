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

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN set -x \
    && apt-get update \
    && apt-get -y locales \
    && echo "${LANG} UTF-8" >> /etc/locale.gen \
    && locale-gen \
    && update-locale LC_ALL=${LC_ALL} LANG=${LANG} \
    && apt-clean --aggressive

ENV INWEE_VERSION=0.2.0
ENV INWEE_HASH=ad4566d4354454f7d2b7db607b91a66aaf5c96a48a22c534159a515d03fd4e0d
ADD https://github.com/susam/inwee/releases/download/${INWEE_VERSION}/inwee /usr/local/bin/inwee
RUN set -x \
    && echo -n "${INWEE_HASH}  /usr/local/bin/inwee" | sha256sum --strict --check - \
    && chmod 655 /usr/local/bin/inwee

RUN adduser --disabled-login --gecos '' user
USER user
WORKDIR /home/user
COPY snippets /home/user/snippets

EXPOSE 9001
COPY entrypoint /entrypoint
ENTRYPOINT ["/tini", "--", "/entrypoint"]
CMD ["weechat"]
