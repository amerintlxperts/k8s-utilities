FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install essential packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    apt-transport-https \
    gnupg && \
    rm -rf /var/lib/apt/lists/*

# Add the Google Cloud public signing key
RUN curl -fsS https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

# Add the Kubernetes apt repository
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" \
    > /etc/apt/sources.list.d/kubernetes.list

# Update package lists and install kubectl
RUN apt-get update && \
    apt-get install -y --no-install-recommends kubectl && \
    rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
