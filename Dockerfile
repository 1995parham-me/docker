FROM alpine:3.22

LABEL maintainer="parham" \
  description="Cloud-native debugging and testing toolkit with database clients, network tools, and CLI utilities" \
  org.opencontainers.image.source="https://github.com/1995parham-me/docker"

# Save build date early to improve layer caching
RUN date >/build-date.txt

# Install glibc compatibility for MongoDB binaries
RUN apk add --no-cache libc6-compat

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
  tmux

# Copy custom zsh configuration
COPY zshrc /etc/zsh/zshrc

# Copy NATS CLI from official nats-box image
COPY --from=natsio/nats-box:latest /usr/local/bin/nats /usr/local/bin/nats

# Copy MongoDB tools from official MongoDB image
COPY --from=mongo:latest /usr/bin/mongosh /usr/local/bin/mongosh
COPY --from=mongo:latest /usr/bin/mongodump /usr/local/bin/mongodump
COPY --from=mongo:latest /usr/bin/mongoexport /usr/local/bin/mongoexport
COPY --from=mongo:latest /usr/bin/mongoimport /usr/local/bin/mongoimport
COPY --from=mongo:latest /usr/bin/mongorestore /usr/local/bin/mongorestore
COPY --from=mongo:latest /usr/bin/mongostat /usr/local/bin/mongostat
COPY --from=mongo:latest /usr/bin/mongotop /usr/local/bin/mongotop

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
