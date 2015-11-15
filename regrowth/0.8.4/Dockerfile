FROM dlord/minecraft
MAINTAINER John Paul Alcala jp@jpalcala.com

ENV REGROWTH_URL http://ftb.cursecdn.com/FTB2/modpacks/Regrowth/0_8_4/RegrowthServer.zip

RUN curl -S $REGROWTH_URL -o /tmp/regrowth.zip && \
    unzip /tmp/regrowth.zip -d $MINECRAFT_HOME && \
    find $MINECRAFT_HOME -name "*.log" -exec rm -f {} \; && \
    rm -rf $MINECRAFT_HOME/ops.* $MINECRAFT_HOME/whitelist.* $MINECRAFT_HOME/logs/* /tmp/*

ENV MINECRAFT_VERSION 1.7.10
ENV MINECRAFT_OPTS -server -Xms2048m -Xmx3072m -XX:MaxPermSize=256m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC
ENV MINECRAFT_STARTUP_JAR forge-1.7.10-10.13.4.1448-1.7.10-universal.jar
