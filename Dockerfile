FROM alpine:3.23

LABEL maintainer="parham" \
  description="Cloud-native debugging and testing toolkit with database clients, network tools, and CLI utilities" \
  org.opencontainers.image.source="https://github.com/1995parham-me/docker"

# Save build date early to improve layer caching
RUN date >/build-date.txt

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
  npm

# Install mongosh using npm (requires build tools)
RUN apk add --no-cache --virtual .build-deps make g++ python3 && \
  npm install -g mongosh && \
  apk del .build-deps

# Copy custom zsh configuration
COPY zshrc /etc/zsh/zshrc

# Copy NATS CLI from official nats-box image
COPY --from=natsio/nats-box:latest /usr/local/bin/nats /usr/local/bin/nats

# Create non-root user (UID 1000)
RUN adduser -D -u 1000 -s /bin/zsh fandogh && \
  mkdir -p /home/fandogh && \
  chown -R fandogh:fandogh /home/fandogh

# Fix permissions (for OpenShift compatibility)
RUN chmod -R g=u /home/fandogh

USER fandogh
WORKDIR /home/fandogh
ENV HOME=/home/fandogh

ENTRYPOINT ["/bin/zsh"]
