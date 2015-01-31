FROM java:7
MAINTAINER John Paul Alcala jp@jpalcala.com

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
    rm -rf $MINECRAFT_HOME/logs/* && \
    chown -R minecraft:minecraft $MINECRAFT_HOME $WORLD_DIR

COPY minecraft /usr/local/bin/

EXPOSE 25565

VOLUME ["$MINECRAFT_HOME/logs", "$WORLD_DIR"]

USER minecraft
CMD ["/usr/local/bin/minecraft"]
