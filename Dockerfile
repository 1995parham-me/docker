FROM alpine:edge

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
      # dog \
      jq \
      yq

ENTRYPOINT [ "/bin/zsh" ]
