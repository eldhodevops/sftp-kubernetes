FROM debian:jessie
MAINTAINER Eldho

# - Install packages
# - OpenSSH needs /var/run/sshd to run
# - Remove generic host keys, entrypoint generates unique keys
RUN apt-get update && \
    apt-get -y install rsyslog rsyslog-doc && \
    apt-get -y install openssh-server && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/sshd && \
    rm -f /etc/ssh/ssh_host_*key*

COPY conf/sshd_config /etc/ssh/sshd_config
COPY conf/rsyslog.conf /etc/rsyslog.conf
COPY conf/Array-graylog.conf /etc/rsyslog.d/Array-graylog.conf
COPY conf /
COPY scripts/entrypoint /
COPY README.md /
EXPOSE 22
ENTRYPOINT ["/entrypoint"]
