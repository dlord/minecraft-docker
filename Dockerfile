FROM ghcr.io/graalvm/graalvm-ce:java11-21.1.0
MAINTAINER John Paul Alcala jp@jpalcala.com

RUN microdnf install rsync tmux jq && microdnf clean all \
	&& gpg --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.11/gosu-amd64" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.11/gosu-amd64.asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && rm -r /root/.gnupg/ \
    && chmod +x /usr/local/bin/gosu \
    # Verify that the binary works
    && gosu nobody true

RUN groupadd -g 1000 minecraft && \
    useradd -g minecraft -u 1000 -r -M minecraft && \
    touch /run/first_time && \
    mkdir -p /opt/minecraft /usr/src/minecraft && \
    echo "set -g status off" > /root/.tmux.conf

COPY minecraft /usr/local/bin/
ONBUILD COPY . /usr/src/minecraft

EXPOSE 25565

ENTRYPOINT ["/usr/local/bin/minecraft"]
CMD ["run"]
