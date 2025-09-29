FROM alpine:3.22

# Add old repositories for mongodb packages
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
  mongodb-tools \
  tmux

# Copy custom zsh configuration
COPY zshrc /etc/zsh/zshrc

# Copy NATS CLI from official nats-box image
COPY --from=natsio/nats-box:latest /usr/local/bin/nats /usr/local/bin/nats

# Save build date
RUN date >/build-date.txt

# Fix permissions (for OpenShift compatibility)
RUN chmod -R g=u /root

WORKDIR /root
ENV HOME=/root

ENTRYPOINT ["/bin/zsh"]
