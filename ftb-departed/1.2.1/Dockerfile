FROM dlord/minecraft
MAINTAINER John Paul Alcala jp@jpalcala.com

ENV FTB_DEPARTED_URL http://ftb.cursecdn.com/FTB2/modpacks/FTBDeparted/1_2_1/FTBDepartedServer.zip
ENV LAUNCHWRAPPER net/minecraft/launchwrapper/1.11/launchwrapper-1.11.jar

RUN \
    curl -S $FTB_DEPARTED_URL -o /tmp/departed.zip && \
    unzip /tmp/departed.zip -d $MINECRAFT_HOME && \
    mkdir -p $MINECRAFT_HOME/libraries && \
    curl -S https://libraries.minecraft.net/$LAUNCHWRAPPER -o $MINECRAFT_HOME/libraries/$LAUNCHWRAPPER && \
    find $MINECRAFT_HOME -name "*.log" -exec rm -f {} \; && \
    rm -rf $MINECRAFT_HOME/ops.* $MINECRAFT_HOME/whitelist.* /tmp/*

ENV MINECRAFT_VERSION 1.7.10
ENV MINECRAFT_OPTS -server -Xms2048m -Xmx3072m -XX:MaxPermSize=256m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC
ENV MINECRAFT_STARTUP_JAR FTBServer-1.7.10-1448.jar

VOLUME ["/opt/minecraft", "/var/lib/minecraft"]
