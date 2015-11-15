FROM dlord/minecraft
MAINTAINER John Paul Alcala jp@jpalcala.com

ENV SPACE_ASTRONOMY_URL http://ftb.cursecdn.com/FTB2/privatepacks/SpaceAstronomy/1_2_9/SpaceAstronomyServer.zip

RUN curl -S $SPACE_ASTRONOMY_URL -o /tmp/space_astronomy.zip && \
    unzip /tmp/space_astronomy.zip -d /tmp && \
    mv /tmp/\[1.7.10\]\ Space\ Astronomy\ Server\ Files\ -\ Use\ with\ v1.2.9/* $MINECRAFT_HOME && \
    find $MINECRAFT_HOME -name "*.log" -exec rm -f {} \; && \
    rm -rf $MINECRAFT_HOME/ops.* $MINECRAFT_HOME/whitelist.* $MINECRAFT_HOME/logs/* /tmp/*

ENV MINECRAFT_VERSION 1.7.10
ENV MINECRAFT_OPTS -server -Xms2048m -Xmx3072m -XX:MaxPermSize=256m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC
ENV MINECRAFT_STARTUP_JAR forge-1.7.10-10.13.4.1517-1.7.10-universal.jar
