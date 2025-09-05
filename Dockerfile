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

# Install Cloud / DevOps tools (most via curl since not in apk)
RUN curl -fsSL https://get.helm.sh/helm-v3.16.0-linux-amd64.tar.gz | tar -xz -C /tmp && mv /tmp/linux-amd64/helm /usr/local/bin/helm && rm -rf /tmp/linux-amd64 && \
    curl -fsSL https://dl.k8s.io/release/v1.31.0/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl && \
    curl -fsSL https://github.com/derailed/k9s/releases/download/v0.32.5/k9s_Linux_amd64.tar.gz | tar -xz -C /usr/local/bin k9s && \
    curl -fsSL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o /tmp/awscliv2.zip && unzip -q /tmp/awscliv2.zip -d /tmp && /tmp/aws/install && rm -rf /tmp/aws /tmp/awscliv2.zip && \
    pip install --no-cache-dir --upgrade azure-cli gcloud-cli

# Enable Starship prompt in zsh
RUN echo 'eval "$(starship init zsh)"' >> /etc/zsh/zshrc

# Copy custom zsh configuration
COPY zshrc /etc/zsh/zshrc

# Copy NATS CLI from official nats-box image
COPY --from=natsio/nats-box:latest /usr/local/bin/nats /usr/local/bin/nats

# Install vim plugin
RUN mkdir -p /root/.vim/pack/tpope/start && \
    cd /root/.vim/pack/tpope/start && \
    git clone https://tpope.io/vim/sensible.git

# Save build date
RUN date >/build-date.txt

# Fix permissions (for OpenShift compatibility)
RUN chmod -R g=u /root

WORKDIR /root
ENV HOME=/root

ENTRYPOINT ["/bin/zsh"]
