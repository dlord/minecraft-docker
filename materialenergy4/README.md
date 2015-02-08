# Material Energy^4

![image](https://i.imgur.com/RmehAcr.jpg)


## What is Material Energy^4?

From the [FTB forum post][]:

    Spatial IO, Cookies, Potatoes, EXPLOSIONS!!!


## Supported tags and respective `Dockerfile` links

* [`1.0.3`](https://github.com/dlord/minecraft-docker/blob/master/materialenergy4/1.0.3/Dockerfile)
* [`1.0.4`, `latest`](https://github.com/dlord/minecraft-docker/blob/master/materialenergy4/1.0.4/Dockerfile)


## Base Docker Image

* [dlord/minecraft][]


##How to use this image

### Starting an instance ###

    docker run \
        --name me4-instance \
        -p 0.0.0.0:25565:25565 \
        -d \
        -e DEFAULT_OP=dinnerbone \
        -e MINECRAFT_EULA=true \
        dlord/materialenergy4

You must set the `DEFAULT_OP` variable on startup. This should be your
Minecraft username. The container will fail to run if this is not set.

When starting a Minecraft server, you must agree to the terms stated in
Minecraft's EULA. This can be done by setting the `MINECRAFT_EULA` variable
to `true`. Without this, the server will not run.

This image exposes the standard minecraft port (25565).

When starting a container for the first time, it will check for the existence of
the Minecraft Server jar file, and will download from Mojang when necessary. As
much as I want to package the Minecraft server jar in this image (to also save
on time and the hassle of an extra step), I cannot due to the [Minecraft EULA][]. 

### Data volumes ###

This image declares two data volumes:

* /opt/minecraft (aka `MINECRAFT_HOME`)
* /var/lib/minecraft

`MINECRAFT_HOME` is declared as a data volume due to the mutable nature of a
Minecraft server installation. This makes it much easier to modify the installed
mods and configs without creating a custom Docker image. It also allows backup
and restore using Docker's recommended way of working with data volumes.

For storing world data, the recommended approach is to use a separate data
volume container. You can create one with the following command:

    docker run --name me4-data -v /var/lib/minecraft java:7 true

The startup script updates the permissions of the data volumes before running
Minecraft. You are free to modify the contents of these directories without
worrying about permissions.

The world is stored in `/var/lib/minecraft`. On first run, this directory will
be empty. The startup script will create a copy of the world included in the
modpack distribution.

### Environment Variables ###

The image uses environment variables to configure the JVM settings and the
server.properties.

**MINECRAFT_EULA**

`MINECRAFT_EULA` is required when starting creating a new container. You need to
agree to Minecraft's EULA before you can start the Minecraft server.

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

This image has been tested on Docker version 1.1.1.


Feedback
--------

Feel free to open a [Github issue][].

If you wish to contribute, you may open a pull request.


[FTB forum post]: http://forum.feed-the-beast.com/threads/1-7-10-material-energy-4.57967/
[dlord/minecraft]: https://registry.hub.docker.com/u/dlord/minecraft/
[Github issue]: https://github.com/dlord/minecraft-docker/issues
[Minecraft EULA]: https://account.mojang.com/documents/minecraft_eula
