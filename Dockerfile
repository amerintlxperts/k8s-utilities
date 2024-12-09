FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install minimal packages including curl and kubectl
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    ca-certificates \
    curl \
    && export RELEASE=$(curl -s https://dl.k8s.io/release/stable.txt) && \
    echo "Resolved Kubernetes release version: $RELEASE" && \
    curl -LO "https://dl.k8s.io/release/${RELEASE}/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/ && \
    rm -rf /var/lib/apt/lists/*

# Set the default command
CMD ["/bin/bash"]

