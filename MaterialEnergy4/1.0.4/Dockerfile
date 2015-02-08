FROM dlord/minecraft
MAINTAINER John Paul Alcala jp@jpalcala.com

ENV ME4_URL http://www.creeperrepo.net/FTB2/modpacks%5EMaterialEnergy4%5E1_0_4%5EMaterialEnergy4Server.zip
ENV MINECRAFT_VERSION 1.7.10
ENV MINECRAFT_OPTS -server -Xms2048m -Xmx3072m -XX:MaxPermSize=256m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC
ENV MINECRAFT_STARTUP_JAR FTBServer-1.7.10-1272.jar

RUN \
    curl -S $ME4_URL -o /tmp/me4.zip && \
    unzip /tmp/me4.zip -d $MINECRAFT_HOME && \
    find $MINECRAFT_HOME -name "*.log" -exec rm -f {} \; && \
    rm -rf $MINECRAFT_HOME/ops.* $MINECRAFT_HOME/whitelist.* $MINECRAFT_HOME/logs/* /tmp/*

VOLUME ["/opt/minecraft", "/var/lib/minecraft"]
