FROM alpine:3.23

LABEL maintainer="parham" \
  description="Cloud-native debugging and testing toolkit with database clients, network tools, and CLI utilities" \
  org.opencontainers.image.source="https://github.com/1995parham-me/docker"

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
  postgresql-client \
  pgcli \
  mongodb-tools \
  tmux \
  wget \
  nodejs \
  aws-cli \
  npm \
  make g++ python3 && \
  npm install -g mongosh && \
  npm cache clean --force && \
  apk del make g++ python3

# Copy custom zsh configuration
COPY zshrc /etc/zsh/zshrc

# Copy NATS CLI from official nats-box image
COPY --from=natsio/nats-box:0.19.3 /usr/local/bin/nats /usr/local/bin/nats

# Create non-root user (UID 1000)
RUN adduser -D -u 1000 -s /bin/zsh fandogh

# Fix permissions (for OpenShift compatibility)
RUN chmod -R g=u /home/fandogh

HEALTHCHECK --interval=30s --timeout=5s CMD [ "true" ]

USER fandogh
WORKDIR /home/fandogh
ENV HOME=/home/fandogh

SHELL ["/bin/zsh", "-c"]
ENTRYPOINT ["/bin/zsh"]
