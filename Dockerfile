FROM openjdk:8-jre-alpine
MAINTAINER John Paul Alcala jp@jpalcala.com

RUN apk add --no-cache \
      curl \
      rsync \
      tmux \
      bash \
      gnupg \
      findutils

# Taken from Postgres Official Dockerfile.
# grab gosu for easy step-down from root
RUN gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4  \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.11/gosu-amd64" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.11/gosu-amd64.asc" \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

RUN addgroup -g 1000 -S minecraft && \
    adduser -G minecraft -u 1000 -S -H minecraft && \
    touch /run/first_time && \
    mkdir -p /opt/minecraft /usr/src/minecraft && \
    echo "set -g status off" > /root/.tmux.conf

COPY minecraft /usr/local/bin/
ONBUILD COPY . /usr/src/minecraft

EXPOSE 25565

ENTRYPOINT ["/usr/local/bin/minecraft"]
CMD ["run"]
