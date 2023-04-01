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
  yq

COPY zshrc /etc/zsh/zshrc

COPY --from=natsio/nats-box:latest /usr/local/bin/nats /usr/loca/bin/nats
COPY --from=natsio/nats-box:latest /usr/local/bin/nats-top /usr/loca/bin/nats-top
COPY --from=natsio/nats-box:latest /usr/local/bin/stan-pub /usr/loca/bin/stan-pub
COPY --from=natsio/nats-box:latest /usr/local/bin/stan-sub /usr/loca/bin/stan-sub
COPY --from=natsio/nats-box:latest /usr/local/bin/stan-bench /usr/loca/bin/stan-bench

ENTRYPOINT [ "/bin/zsh" ]
