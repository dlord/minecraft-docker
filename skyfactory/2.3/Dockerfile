FROM dlord/minecraft
MAINTAINER John Paul Alcala jp@jpalcala.com

ENV SKYFACTORY_PAGE http://www.atlauncher.com/pack/SkyFactory
ENV SKYFACTORY_VERSION 2.3
ENV SKYFACTORY_URL http://fs.atlcdn.net/downloads/servers/public/SkyFactory
ENV MINECRAFT_VERSION 1.7.10
ENV MINECRAFT_OPTS -server -Xms2048m -Xmx3072m -XX:MaxPermSize=256m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC
ENV MINECRAFT_STARTUP_JAR forge-1.7.10-10.13.2.1291-universal.jar

RUN \
    curl -s $SKYFACTORY_PAGE | grep -sho "\"$SKYFACTORY_URL/$SKYFACTORY_VERSION/.*[\"]" | xargs curl -o /tmp/skyfactory.zip && \
    unzip /tmp/skyfactory.zip -d $MINECRAFT_HOME && \
    find $MINECRAFT_HOME -name "*.log" -exec rm -f {} \; && \
    rm -rf $MINECRAFT_HOME/ops.* $MINECRAFT_HOME/whitelist.* $MINECRAFT_HOME/logs/* /tmp/*

VOLUME ["/opt/minecraft", "/var/lib/minecraft"]
