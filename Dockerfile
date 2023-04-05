FROM alpine:3.17

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
  yq

COPY zshrc /etc/zsh/zshrc

COPY --from=natsio/nats-box:latest /usr/local/bin/nats /usr/local/bin/nats
COPY --from=natsio/nats-box:latest /usr/local/bin/nats-top /usr/local/bin/nats-top
COPY --from=natsio/nats-box:latest /usr/local/bin/stan-pub /usr/local/bin/stan-pub
COPY --from=natsio/nats-box:latest /usr/local/bin/stan-sub /usr/local/bin/stan-sub
COPY --from=natsio/nats-box:latest /usr/local/bin/stan-bench /usr/local/bin/stan-bench

RUN date >/build-date.txt; \
  touch /.mycli.log && chmod 0666 /.mycli.log; \
  touch /.myclirc && chmod 0666 /.myclirc

ENTRYPOINT [ "/bin/zsh" ]
