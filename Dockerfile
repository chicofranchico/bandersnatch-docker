FROM debian:stable

MAINTAINER Francisco de Freitas <chicofranchico@gmail.com>

ENV NGINX_VERSION 1.14.0-1~stretch
ENV NJS_VERSION   1.14.0.0.2.0-1~stretch

RUN apt-get update && \
	apt-get -y install --no-install-recommends \
		virtualenv \
		python3-dev \
		python3-venv \
		ca-certificates \
		python-pip \
	&& \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN groupadd user && \
	useradd --uid 1000 --create-home --home-dir /home/user -g user user

WORKDIR /home/user

RUN su user -c "python3 -m venv bandersnatch  && \
		. ./bandersnatch/bin/activate && \
		pip install -r https://raw.githubusercontent.com/pypa/bandersnatch/master/requirements.txt"

COPY default.conf /etc/bandersnatch.conf
RUN chown user:user /etc/bandersnatch.conf

COPY run.sh /usr/local/bin/run.sh

VOLUME /srv/pypi
CMD ["/usr/local/bin/run.sh"]
