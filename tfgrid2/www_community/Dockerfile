FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update ; \
    apt-get install -y curl git supervisor gnupg; \
    apt-get install -y openssh-server vim net-tools iputils-ping

# install supervisor
#RUN pip3 install supervisor

# install crystal-lang.org

RUN curl -sSL https://dist.crystal-lang.org/apt/setup.sh |  bash ; \
	curl -sL "https://keybase.io/crystal/pgp_keys.asc" |  apt-key add - ; \
	echo "deb https://dist.crystal-lang.org/apt crystal main" > /etc/apt/sources.list.d/crystal.list  ; \
	apt-get update  ; \
	apt install crystal -y 

	# nstall Latest Node.js and NPM on Ubuntu with PPA
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -  ; \
	apt-get install nodejs -y

COPY supervisor.conf /etc/supervisor/supervisord.conf
COPY start_www_community.sh /start_www_community.sh

# ssh-agnet
ENV SSH_DIR /.ssh
ENV SOCKET_DIR /.ssh-agent
ENV SSH_AUTH_SOCK ${SOCKET_DIR}/socket
ENV SSH_AUTH_PROXY_SOCK ${SOCKET_DIR}/proxy-socket

VOLUME ${SOCKET_DIR}

RUN chmod  +x  /start_www_community.sh
ENTRYPOINT ["/start_www_community.sh" ]

# to support zosv1 , can removed later
COPY startup.toml /.startup.toml
RUN chmod  +x  /.startup.toml
