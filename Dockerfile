FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    apt-transport-https \
    gnupg && \
    rm -rf /var/lib/apt/lists/*

# Retrieve and set up the Kubernetes repository GPG key
RUN curl -fsSLO "https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key" && \
    mkdir -p /usr/share/keyrings && \
    gpg --dearmor < Release.key > /usr/share/keyrings/k8s-archive-keyring.gpg && \
    rm Release.key

# Add the Kubernetes apt repository
RUN echo "deb [signed-by=/usr/share/keyrings/k8s-archive-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" \
    > /etc/apt/sources.list.d/k8s.list

# Update package lists and install kubectl
RUN apt-get update && \
    apt-get install -y --no-install-recommends kubectl && \
    rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
