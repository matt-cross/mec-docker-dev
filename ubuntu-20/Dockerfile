# Based off phusion baseimage (ubuntu image that supports running
# multiple processes) - see https://github.com/phusion/baseimage-docker
FROM phusion/baseimage:focal-1.1.0

LABEL description="Container for Ubuntu 20.04 development" 

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# install build dependencies 
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y build-essential openssh-server cmake ninja-build emacs git cscope

# Add Sudo
RUN apt install -y sudo

# Add ripgrep
RUN apt install -y ripgrep

# Add some older compilers and cross-compilers

RUN echo "deb http://archive.ubuntu.com/ubuntu/ xenial main" >> /etc/apt/sources.list && echo "deb http://archive.ubuntu.com/ubuntu/ xenial universe" >> /etc/apt/sources.list && echo "deb http://archive.ubuntu.com/ubuntu/ bionic main" >> /etc/apt/sources.list && echo "deb http://archive.ubuntu.com/ubuntu/ bionic universe" >> /etc/apt/sources.list && apt update

RUN apt install -y clang-4.0 g++-5 g++-10-aarch64-linux-gnu g++-8-arm-linux-gnueabi

# Add language servers
RUN apt install -y clangd python3-pip
RUN pip3 install python-lsp-server

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rm -f /etc/service/sshd/down

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Set up a user
ENV USERNAME=mcross

RUN useradd -m -d /home/${USERNAME} -s /bin/bash -G sudo -p '*' ${USERNAME} && mkdir -p /home/${USERNAME}/.ssh && chmod 700 /home/${USERNAME}/.ssh && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.ssh

# Link .emacs
RUN rm -rf /home/${USERNAME}/.emacs.d && ln -s sources/docker-dev/dot-emacs.d /home/${USERNAME}/.emacs.d && chown -h ${USERNAME}:${USERNAME} /home/${USERNAME}/.emacs.d

# Enable passwordless sudo access
RUN echo '%sudo ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/nopasswd && chmod 0440 /etc/sudoers.d/nopasswd

COPY --chown=${USERNAME}:${USERNAME} id_ed25519.pub /home/${USERNAME}/.ssh/authorized_keys

# expose port 22 
EXPOSE 22
