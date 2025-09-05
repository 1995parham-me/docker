FROM alpine:3.22

# Add old repositories for mongodb packages
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/main' >> /etc/apk/repositories && \
  echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/community' >> /etc/apk/repositories

# Install base utilities, databases, networking tools, terminal goodies, and languages
RUN apk add --update --no-cache \
  # base tools
  ca-certificates \
  busybox-extras \
  curl \
  curlie \
  git \
  zsh \
  vim \
  nano \
  bat \
  tmux \
  jq \
  yq \
  # networking & debugging
  mtr \
  iputils \
  bind-tools \
  net-tools \
  nmap \
  tcpdump \
  tshark \
  httpie \
  whois \
  iperf3 \
  # databases & clients
  redis \
  mariadb-client \
  mycli \
  postgresql \
  pgcli \
  mongodb \
  mongodb-tools \
  sqlite \
  # terminal tools
  htop \
  ncdu \
  fd \
  ripgrep \
  fzf \
  exa \
  starship \
  # languages
  python3 \
  py3-pip \
  nodejs \
  npm \
  go \
  rust \
  cargo

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
