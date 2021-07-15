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
      vim \
      # dog \
      jq \
      yq

RUN adduser -g 'Parham Alvani' -D -s /bin/zsh parham
USER parham

COPY zshrc /home/parham/.zshrc

ENTRYPOINT [ "/bin/zsh" ]
