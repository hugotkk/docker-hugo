# Use the official Alpine base image
FROM alpine:latest

# Install necessary packages
RUN apk add --no-cache \
    supervisor \
    git \
    wget \
    ca-certificates \
    tar \
    python3 \
    py3-pip

# Set the desired Hugo version
ENV HUGO_VERSION 0.92.0

# Download and install Hugo
WORKDIR /tmp
RUN wget -O hugo.tar.gz "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz" \
    && tar -xf hugo.tar.gz \
    && mv hugo /usr/local/bin/hugo \
    && rm -rf /tmp/*

# Create a virtual environment for Supervisor
RUN python3 -m venv /opt/venv

# Activate the virtual environment and install the latest version of Supervisor
RUN /opt/venv/bin/pip install --upgrade pip \
    && /opt/venv/bin/pip install supervisor

# Copy the Supervisor configuration file
COPY supervisord.conf /etc/supervisord.conf

# Set the working directory
WORKDIR /app

# Expose the port Hugo server will run on
EXPOSE 1313

# Command to run Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf", "-n"]
