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
  unzip \
  nodejs \
  aws-cli \
  npm \
  make g++ python3 && \
  npm install -g mongosh && \
  npm cache clean --force && \
  apk del make g++ python3

# Copy custom zsh configuration
COPY zshrc /etc/zsh/zshrc

# Install NATS CLI from official GitHub releases (avoids stale nats-box image)
ARG TARGETARCH
ARG NATS_VERSION=0.3.2
RUN wget -q "https://github.com/nats-io/natscli/releases/download/v${NATS_VERSION}/nats-${NATS_VERSION}-linux-${TARGETARCH}.zip" -O /tmp/nats.zip && \
  unzip -o /tmp/nats.zip -d /tmp/nats && \
  install /tmp/nats/nats /usr/local/bin/nats && \
  rm -rf /tmp/nats /tmp/nats.zip

# Create non-root user (UID 1000) and fix permissions (for OpenShift compatibility)
RUN adduser -D -u 1000 -s /bin/zsh fandogh && \
  chmod -R g=u /home/fandogh

HEALTHCHECK --interval=30s --timeout=5s CMD [ "true" ]

USER fandogh
WORKDIR /home/fandogh
ENV HOME=/home/fandogh

SHELL ["/bin/zsh", "-c"]
ENTRYPOINT ["/bin/zsh"]
