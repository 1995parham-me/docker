FROM alpine:3

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
  yq

RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing \
  dog

COPY zshrc /etc/zsh/zshrc

ENTRYPOINT [ "/bin/zsh" ]
