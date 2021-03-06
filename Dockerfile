

# Basis Image
FROM ubuntu:16.04

# Maintainer info
MAINTAINER Vicky Lee <vickyli.tw@gmail.com>

# Update Image
RUN apt-get update && apt-get install -y --no-install-recommends \
                        python-setuptools \
                        python-pip \
                        python-eventlet \
                        python-lxml \
                        python-msgpack \
                        unzip \
                        wget \
                   && rm -rf /var/lib/apt/lists/*

# Install Ryu
RUN wget -O /opt/ryu.zip "http://github.com/osrg/ryu/archive/master.zip" --no-check-certificate && \
    unzip -q /opt/ryu.zip -d /opt && \
    mv /opt/ryu-master /opt/ryu && \
    cd /opt/ryu && pip install -r tools/pip-requires && \
    python setup.py install

# Clean up APT when done.
RUN apt-get clean && rm -rf /opt/ryu.zip

# Define working directory.
WORKDIR /opt/ryu

# Execute when building new container
# Show ryu-manager version
CMD ["./bin/ryu-manager", "--version"]
