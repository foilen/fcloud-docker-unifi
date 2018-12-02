FROM ubuntu:16.04

# Needed by infrastructure
RUN export TERM=dumb ; apt-get update && apt-get install -y \
    apt-transport-https apt-utils curl \
    haproxy=1.6.\* msmtp supervisor \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# UniFi App
RUN echo "deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti" > /etc/apt/sources.list.d/unifi.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv 06E85760C0A52C50 && \
  export TERM=dumb ; apt-get update && apt-get install -y \
    openjdk-8-jre=8u191-b12-0ubuntu0.16.04.1 \
    unifi=5.9.29-11384-1 \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# The wrapper
COPY assets /
RUN chmod +x /wrapper-*

# The folders
RUN mkdir -p /usr/lib/unifi/data /usr/lib/unifi/logs /usr/lib/unifi/run && \
  chown unifi:unifi /usr/lib/unifi/data /usr/lib/unifi/logs /usr/lib/unifi/run

CMD /wrapper-unifi.sh
