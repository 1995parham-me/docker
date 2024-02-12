FROM alpine:3.19

RUN apk add --update --no-cache \
  ca-certificates \
  zsh \
  net-tools \
  curl \
  busybox-extras \
  mtr \
  iputils \
  bind-tools \
  bat \
  curlie \
  vim \
  jq \
  dog \
  mycli \
  pgcli \
  starship \
  yq

COPY zshrc /etc/zsh/zshrc

COPY --from=natsio/nats-box:latest /usr/local/bin/nats /usr/local/bin/nats
COPY --from=natsio/nats-box:latest /usr/local/bin/nats-top /usr/local/bin/nats-top

RUN date >/build-date.txt; \
  touch /.mycli.log && chmod 0666 /.mycli.log; \
  touch /.myclirc && chmod 0666 /.myclirc; \
  touch /.mycli-history && chmod 0666 /.mycli-history

ENTRYPOINT [ "/bin/zsh" ]
