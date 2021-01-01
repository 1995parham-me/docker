FROM ubuntu:20.04

ARG VCS_REF
ARG BUILD_DATE

# Metadata
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="ubuntu-okd" \
      org.label-schema.url="https://hub.docker.com/r/1995parham/ubuntu-okd/" \
      org.label-schema.vcs-url="https://github.com/1995parham/ubuntu-okd" \
      org.label-schema.build-date=$BUILD_DATE

ARG HELM_VERSION
ARG OC_VERSION

RUN apt-get update && apt-get install -y ca-certificates bash git curl wget

# Install helm (latest release)
ENV BASE_URL="https://get.helm.sh"
ENV TAR_FILE="helm-v${HELM_VERSION}-linux-amd64.tar.gz"
RUN curl -L ${BASE_URL}/${TAR_FILE} | tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64

# Install openshift-origin-client
RUN OC_MAJOR_VERSION=$(echo $OC_VERSION | cut -d'.' -f 1) \
    && curl -sLo /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v$OC_MAJOR_VERSION/clients/$(if [ "$OC_MAJOR_VERSION" == "4" ]; then echo "oc/"; fi)$OC_VERSION/linux/oc.tar.gz \
    && tar xzvf /tmp/oc.tar.gz -C /usr/local/bin/ \
    && chmod +x /usr/local/bin/oc \
    && chmod +x /usr/local/bin/kubectl \
    && rm -rf /tmp/oc.tar.gz \

WORKDIR /data

CMD bash
