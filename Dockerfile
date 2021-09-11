FROM ubuntu:20.04

# Needed by infrastructure
RUN export TERM=dumb ; apt-get update && apt-get install -y \
    apt-transport-https apt-utils ca-certificates curl wget \
    msmtp \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# UniFi App
RUN echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' > /etc/apt/sources.list.d/100-ubnt-unifi.list && \
  wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg && \
  export TERM=dumb ; apt-get update && apt-get install -y \
    openjdk-8-jre \
    unifi=6.2.26-15319-1 \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# The wrapper
COPY assets /
RUN chmod +x /wrapper-*

# The folders
RUN mkdir -p /usr/lib/unifi/data /usr/lib/unifi/logs /usr/lib/unifi/run && \
  chown unifi:unifi /usr/lib/unifi/data /usr/lib/unifi/logs /usr/lib/unifi/run

CMD /wrapper-unifi.sh
