FROM alpine:3.22

# Following repositories are required to install mongodb-shell.
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/main' >> /etc/apk/repositories && \
  echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/community' >> /etc/apk/repositories

RUN apk add --update --no-cache \
  ca-certificates \
  busybox-extras \
  curl \
  curlie \
  mtr \
  iputils \
  bind-tools \
  net-tools \
  zsh \
  bash \
  vim \
  nano \
  bat \
  jq \
  yq \
  git \
  redis \
  mariadb-client \
  mycli \
  postgresql \
  pgcli \
  mongodb \
  mongodb-tools

COPY zshrc /etc/zsh/zshrc

COPY --from=natsio/nats-box:latest /usr/local/bin/nats /usr/local/bin/nats

# hadolint ignore=DL3003
RUN mkdir -p ~/.vim/pack/tpope/start && cd ~/.vim/pack/tpope/start && git clone https://tpope.io/vim/sensible.git

RUN date >/build-date.txt; \
  touch /.mycli.log && chmod 0666 /.mycli.log; \
  touch /.myclirc && chmod 0666 /.myclirc; \
  touch /.mycli-history && chmod 0666 /.mycli-history

WORKDIR /

ENTRYPOINT [ "/bin/zsh" ]
