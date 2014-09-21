FROM ubuntu

RUN apt-get -y update
RUN apt-get -y install openssh-server git curl

# Setting up openssh
RUN mkdir /var/run/sshd

# Adding git user
RUN adduser --system git
RUN mkdir -p /home/git/.ssh

# Updating shell to bash
RUN sed -i s#/home/git:/bin/false#/home/git:/bin/bash# /etc/passwd

ADD scripts /scripts
ADD config/sshd_config /etc/ssh/sshd_config

RUN git config --global init.templatedir /scripts/hooks

RUN mkdir -p /home/git/repos && chown -hR git /home/git
VOLUME /home/git/repos

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-E", "/var/log/sshd.log"]