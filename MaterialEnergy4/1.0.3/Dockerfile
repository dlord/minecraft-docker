FROM java:7
MAINTAINER John Paul Alcala jp@jpalcala.com

# Taken from Postgres Official Dockerfile.
# grab gosu for easy step-down from root
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/* \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

ENV ME4_URL http://www.creeperrepo.net/FTB2/modpacks%5EMaterialEnergy4%5E1_0_3%5EMaterialEnergy4Server.zip
ENV MINECRAFT_HOME /opt/me4
ENV MINECRAFT_OPTS -server -Xms2048m -Xmx3072m -XX:PermSize=256m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC
ENV MINECRAFT_JAR FTBServer-1.7.10-1272.jar
ENV WORLD_DIR /var/lib/minecraft

RUN \
    groupadd -g 1000 minecraft && \
    useradd -g minecraft -u 1000 -r -M minecraft && \
    mkdir -p $MINECRAFT_HOME/logs $WORLD_DIR && \
    curl -S $ME4_URL -o /tmp/me4.zip && \
    unzip /tmp/me4.zip -d $MINECRAFT_HOME && \
    chmod -R +x $MINECRAFT_HOME/FTBInstall.sh && \
    $MINECRAFT_HOME/FTBInstall.sh && \
    find $MINECRAFT_HOME -name "*.log" -exec rm -f {} \; && \
    rm -rf $MINECRAFT_HOME/ops.* $MINECRAFT_HOME/whitelist.* $MINECRAFT_HOME/logs/*

COPY minecraft /usr/local/bin/

EXPOSE 25565

VOLUME ["/opt/me4", "/var/lib/minecraft"]

CMD ["/usr/local/bin/minecraft"]
