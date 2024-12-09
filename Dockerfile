FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --no-install-recommends -y ca-certificates curl && \
    rm -rf /var/lib/apt/lists/*

# Perform all related tasks in one RUN command
RUN set -eux; \
    RELEASE=$(curl -s https://dl.k8s.io/release/stable.txt); \
    echo "Resolved Kubernetes release version: $RELEASE"; \
    curl -sSLO "https://dl.k8s.io/release/${RELEASE}/bin/linux/amd64/kubectl"; \
    chmod +x kubectl; \
    mv kubectl /usr/local/bin/kubectl

CMD ["/bin/bash"]
