FROM ubuntu:rolling

ENV DEBIAN_FRONTEND=noninteractive
LABEL description="baseimage of toolbox"
# Update/Install packages
RUN apt-get update -y && \
    apt-get install jq git lsof curl wget bzip2 unzip zlibc apt-utils libtool python3 autoconf libssl-dev zlib1g-dev python3-pip libxml2-dev libxslt-dev libyaml-dev libsqlite3-dev build-essential libreadline-dev -y

RUN pip3 install \
         httpie
                                         
# Add a user for running things as non-superuser
RUN useradd -ms /bin/bash worker

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*