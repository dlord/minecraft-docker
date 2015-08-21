FROM dlord/minecraft
MAINTAINER John Paul Alcala jp@jpalcala.com

ENV TOLKIENCRAFT_URL http://ftb.cursecdn.com/FTB2/modpacks/TolkienCraftII/2_7_1/TolkienCraftIIServer.zip

RUN \
    curl -S $TOLKIENCRAFT_URL -o /tmp/tolkiencraft.zip && \
    unzip /tmp/tolkiencraft.zip -d $MINECRAFT_HOME && \
    find $MINECRAFT_HOME -name "*.log" -exec rm -f {} \; && \
    rm -rf $MINECRAFT_HOME/ops.* $MINECRAFT_HOME/whitelist.* /tmp/*

ENV MINECRAFT_VERSION 1.7.10
ENV MINECRAFT_OPTS -server -Xms2048m -Xmx3072m -XX:MaxPermSize=256m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC
ENV MINECRAFT_STARTUP_JAR TolkienCraftII_server.jar

VOLUME ["/opt/minecraft", "/var/lib/minecraft"]
