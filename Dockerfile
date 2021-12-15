FROM mcr.microsoft.com/dotnet/core/sdk:3.1.302-bionic
RUN apt-get update && apt-get -y --no-install-recommends install unzip apt-transport-https ca-certificates curl software-properties-common \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" \
    && apt-get update \
    && apt-get install --no-install-recommends docker-ce-cli \
    && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:git-core/ppa \
    apt update \
    && apt install jq -y \
    && apt-get install -y git 
RUN git --version

RUN echo "fs.file-max = 65535" >> /etc/sysctl.conf \
    && sysctl -p

# Increase file read limits by appending to conf files
RUN echo "root soft     nproc          65535" >> /etc/security/limits.conf
RUN echo "root hard     nproc          65535" >> /etc/security/limits.conf
RUN echo "root soft     nofile         65535" >> /etc/security/limits.conf
RUN echo "root hard     nofile         65535" >> /etc/security/limits.conf

RUN echo "session required pam_limits.so" >> /etc/pam.d/common-session