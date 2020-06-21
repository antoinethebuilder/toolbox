FROM phusion/baseimage:0.11

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ENV DISABLE_SYSLOG=1
ENV DISABLE_SSH=1
ENV DISABLE_CRON=1

ENV DEBIAN_FRONTEND=noninteractive

# Update/Install packages
RUN apt-get update -y && \
    apt-get install \
            jq \
            git \
            lsof  \
            curl \
            wget \
            bzip2 \
            unzip \
            zlibc \
            libtool \
            python3 \
            autoconf \
            certstrap \
            libssl-dev \
            zlib1g-dev \
            python3-pip \
            libxml2-dev \
            libxslt-dev \
            libyaml-dev \
            libreadline8 \
            concourse-fly \
            libsqlite3-dev \
            build-essential \
            libreadline-dev

RUN pip3 install \
         httpie \
         cloudflare
                                         
# Install git-lfs
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install git-lfs && \
    git lfs install

# Add a user for running things as non-superuser
RUN useradd -ms /bin/bash worker

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ENTRYPOINT [ "/sbin/my_init", "--"]