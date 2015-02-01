Material Energy^4 v1.0.3
========================

![image](https://i.imgur.com/RmehAcr.jpg)


What is Material Energy^4?
--------------------------

From the [FTB forum post][]:

    Spatial IO, Cookies, Potatoes, EXPLOSIONS!!!


Base Docker Image
-----------------

* java:7


How to use this image
---------------------

### Starting an instance ###

    docker run --name me4-instance -p 0.0.0.0:25565:25565 -d -e DEFAULT_OP=dinnerbone dlord/materialenergy4

You must set the `DEFAULT_OP` variable on startup. This should be your
Minecraft username. The container will fail to run if this is not set.

This image exposes the standard minecraft port (25565).

### Data volumes ###

This image declares two data volumes:

* /opt/me4 (aka `MINECRAFT_HOME`)
* /var/lib/minecraft

`MINECRAFT_HOME` is declared as a data volume due to the mutable nature of a
Minecraft server installation. This makes it much easier to modify the installed
mods and configs without creating a custom Docker image. It also allows backup
and restore using Docker's recommended way of working with data volumes.

For storing world data, the recommended approach is to use a separate data
volume container. You can create one with the following command:

    docker run --name me4-data -v /var/lib/minecraft java:7 true && \
    docker run -it --rm --volumes-from me4-data -u root dlord/materialenergy4 \
        chown -R minecraft:minecraft /var/lib/minecraft

Do not skip the chown step. Otherwise, Minecraft won't be able to write to the
directories.

The world is stored in `/var/lib/minecraft`. On first run, this directory will
be empty. The startup script will create a copy of the world included in the
modpack distribution.

### Environment Variables ###

The image uses environment variables to configure the JVM settings and the
server.properties.

**DEFAULT_OP**

`DEFAULT_OP` is required when starting creating a new container.

**JVM Settings**

You may adjust the JVM settings via the `MINECRAFT_OPTS` variable.

**server.properties**

Each entry in the `server.properties` file can be changed by passing the
appropriate variable. To make it easier to remember and configure, the variable
representation of each entry is in uppercase, and uses underscore instead
of dash.

The server port cannot be changed. This has to be remapped when starting an
instance.

For reference, here is the list of environment variables for `server.properties`
that you can set:

* GENERATOR_SETTINGS
* OP_PERMISSION_LEVEL
* ALLOW_NETHER
* LEVEL_NAME
* ENABLE_QUERY
* ALLOW_FLIGHT
* ANNOUNCE_PLAYER_ACHIEVEMENTS
* LEVEL_TYPE
* ENABLE_RCON
* FORCE_GAMEMODE
* LEVEL_SEED
* SERVER_IP
* MAX_BUILD_HEIGHT
* SPAWN_NPCS
* WHITE_LIST
* SPAWN_ANIMALS
* SNOOPER_ENABLED
* ONLINE_MODE
* RESOURCE_PACK
* PVP
* DIFFICULTY
* ENABLE_COMMAND_BLOCK
* PLAYER_IDLE_TIMEOUT
* GAMEMODE
* MAX_PLAYERS
* SPAWN_MONSTERS
* VIEW_DISTANCE
* GENERATE_STRUCTURES
* MOTD


Supported Docker versions
-------------------------

This image has been tested on Docker version 1.3.2.


Feedback
--------

Feel free to open a [Github issue][].

If you wish to contribute, you may open a pull request.


[FTB forum post]: http://forum.feed-the-beast.com/threads/1-7-10-material-energy-4.57967/
[Github issue]: https://github.com/dlord/minecraft-docker/issues
