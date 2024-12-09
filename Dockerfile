FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install minimal packages including curl and kubectl
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    ca-certificates \
    curl

# Download the stable Kubernetes release version
RUN curl -s https://dl.k8s.io/release/stable.txt | tee /tmp/release.txt

# Read the downloaded release version
RUN RELEASE=$(cat /tmp/release.txt)

# Print the resolved version
RUN echo "Resolved Kubernetes release version: $RELEASE"

# Download kubectl binary
RUN curl -LO "https://dl.k8s.io/release/${RELEASE}/bin/linux/amd64/kubectl"

# Make kubectl executable
RUN chmod +x kubectl

# Move kubectl to system path
RUN mv kubectl /usr/local/bin/

# Clean up temporary file
RUN rm -rf /tmp/release.txt

# Set the default command
CMD ["/bin/bash"]
