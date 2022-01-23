# Base off phusion baseimage (that supports running multiple processes) - see https://github.com/phusion/baseimage-docker
FROM phusion/baseimage:focal-1.1.0

LABEL description="Container for Ubuntu 20.04 development" 

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# install build dependencies 
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y build-essential openssh-server cmake ninja-build emacs git cscope

RUN rm -f /etc/service/sshd/down

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Set up a user
ENV USERNAME=mcross

RUN useradd -m -d /home/${USERNAME} -s /bin/bash -G sudo -p '*' ${USERNAME} && mkdir -p /home/${USERNAME}/.ssh && chmod 700 /home/${USERNAME}/.ssh && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.ssh

COPY --chown=${USERNAME}:${USERNAME} id_ed25519.pub /home/${USERNAME}/.ssh/authorized_keys

# expose port 22 
EXPOSE 22

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
