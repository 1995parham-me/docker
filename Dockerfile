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

ENTRYPOINT [ "/bin/zsh" ]
