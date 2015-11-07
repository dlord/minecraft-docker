FROM dlord/minecraft
MAINTAINER John Paul Alcala jp@jpalcala.com

ENV CRUSADERCRAFT_URL http://vl4.voidswrath.com/release/CrusaderCraft.zip
ENV LAUNCHWRAPPER net/minecraft/launchwrapper/1.11/launchwrapper-1.11.jar

RUN \
    curl -S $CRUSADERCRAFT_URL -o /tmp/crusadercraft.zip && \
    unzip /tmp/crusadercraft.zip -d $MINECRAFT_HOME && \
    mkdir -p $MINECRAFT_HOME/libraries && \
    curl -S https://libraries.minecraft.net/$LAUNCHWRAPPER -o $MINECRAFT_HOME/libraries/$LAUNCHWRAPPER && \
    find $MINECRAFT_HOME -name "*.log" -exec rm -f {} \; && \
    rm -rf $MINECRAFT_HOME/ops.* $MINECRAFT_HOME/whitelist.* /tmp/*

ENV MINECRAFT_VERSION 1.7.10
ENV MINECRAFT_OPTS -server -Xms2048m -Xmx3072m -XX:MaxPermSize=256m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC
ENV MINECRAFT_STARTUP_JAR forge.jar
