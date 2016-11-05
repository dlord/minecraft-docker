# Minecraft - Vanilla Server

* * *


## About this image

This Docker image allows you to run a Vanilla Minecraft server quickly. It
also serves as the base image for some of my Modded Minecraft server images.


## Available Tags

* `java7`, `latest` - the default
* `java8` - used by certain modpacks, or for people who know what they are doing.


## How to use this image


### Starting an instance

    docker run \
        --name minecraft-instance \
        -p 0.0.0.0:25565:25565 \
        -d \
        -it \
        -e DEFAULT_OP=dinnerbone \
        -e MINECRAFT_EULA=true \
        dlord/minecraft

By default, this starts up a Minecraft 1.8.8 server instance. If you wish to
start a different Minecraft server version, you need to set the
`MINECRAFT_VERSION` variable to the appropriate version.

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

It is highly preferred to start the container with `-it`. This is needed in
order to allow executing console commands via `docker exec`. This also allows
the Minecraft server to safely shutdown when stopping the container via
`docker stop`. See the `Scripting` section for more details.


### Commands

The image uses an entrypoint script called `minecraft`, which allows you to
execute preset commands. Should you attempt to execute an unrecognized command,
it will treat it as a regular shell command.

The commands are as follows:

* `run` - This runs the Minecraft server, and is the default command used by the
  container. This command can accept additional parameters (_if_ minecraft
  supports other options apart from `nogui`). Useful when
  creating a new container via `docker create` or `docker run`
* `permissions` - This updates the permissions of all related files and
  folders. Useful when manually editing a file.
* `console` - This executes a console command. This allows system administrators
  to perform complex tasks via scripts. This feature is off by default. See the
  `Scripting` section for more details and examples.

Here are some examples on how to use these commands:

**run - pass anotherminecraftoptionthatdoesnotexist to minecraft server**

    docker run \
        --name minecraft-instance \
        -p 0.0.0.0:25565:25565 \
        -d \
        -it \
        -e DEFAULT_OP=dinnerbone \
        -e MINECRAFT_EULA=true \
        dlord/minecraft
        run anotherminecraftoptionthatdoesnotexist

**permissions - update file and folder permissions while a container is running**

    docker exec minecraft-instance minecraft permissions


### Scripting

Unlike other Minecraft Docker Images, this image provides a way to execute
console commands without attaching to the docker container. It lets system
administrators perform much more complex tasks, such as managing the docker
container from another docker container (e.g. deploying using Jenkins).

For those who are used to running `docker attach` inside a `screen` or `tmux`
session for scripting, this is going to be heaven.

This feature can be enabled by pasing the `-it` parameter to `docker create` or
`docker run`, which enables STDIN and TTY. This runs the Minecraft server inside
a `tmux` session. This also enables safe shutdown mode when the container is
stopped.

Once enabled, you may now execute console commands like so:

    docker exec minecraft-instance minecraft console say hello everybody!

Some warnings when using this feature:

* **DO NOT USE `-it` ON `docker exec`!** For some reason, it crashes
  the `tmux` session that drives this feature.
* **Be careful when attaching to the console via `docker attach`**. You are
  attaching to a `tmux` session running on the foreground with the footer
  disabled. Do not try to detach from the `tmux` session using `CTRL-b d`,
  otherwise this will stop the container. To detach from the container, use
  `CTRL-p CTRL-q`, which is the standard escape sequence for `docker attach`.

Here is an example on how to notify players that the server will be shutdown
after 60 seconds:

    #!/bin/bash
    docker exec minecraft-instance minecraft console say We will be shutting down the server in 60s!
    docker exec minecraft-instance minecraft console say Stop whatever you are doing!
    sleep 60
    docker exec minecraft-instance minecraft console say We will be back in 1 hour!
    sleep 5
    
    # The container will send the stop console command to the server for you, to
    # ensure that the server is shutdown safely.
    #
    # Of course you can run this manually like so:
    #
    #     docker exec minecraft-instance minecraft console stop
    #
    # But this will restart the container if the restart policy is set to always.
    docker stop -t 60 minecraft-instance


### Data volumes

Previously, this image has one data volume: `/var/lib/minecraft`. This volume
used to contain world data. If you are using an older version of this docker
image, you will need to move the contents of this folder to `/opt/minecraft`.

The decision to change this was due to the way Vanilla Minecraft works.

Unlike Spigot, which is capable of changing the location of the world data,
Vanilla Minecraft (and by extension, Modded Minecraft), does not play nice with
this. Even though they technically support it, mods and other sysads expect the
world data to reside inside the main Minecraft folder.

And when you try to support both vanilla and modded servers, it becomes more
complex. Vanilla servers will have 3 world folders (e.g. `world`,
`world_nether`, `world_the_end`), while modded servers will only have `world`.

To keep things simple, I've removed the data volume definition. It is now up to
the user to declare the appropriate data volume either at runtime, or when
extending the image.

If you're running a Vanilla server, you may opt to declare `/opt/minecraft` as a
data volume. This not only simplifies data management, it allows you to take
advantage of the `ONBUILD` trigger that comes with this image. See the
`ONBUILD Trigger` section for details.


### Environment Variables

The image uses environment variables to configure the JVM settings and the
server.properties.


#### `MINECRAFT_EULA`

`MINECRAFT_EULA` is required when starting creating a new container. You need to
agree to Minecraft's EULA before you can start the Minecraft server.


#### `DEFAULT_OP`

`DEFAULT_OP` is required when starting creating a new container.


#### `MINECRAFT_OPTS`

You may adjust the JVM settings via the `MINECRAFT_OPTS` variable.


#### Environment variables for server.properties

On startup, it will check the existence of `server.properties`. If it does
not exist, one will be created for you. You may override the defaults by
setting the appropriate environment variable.

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


## Extending this image

This image is meant to be extended for packaging custom maps, modpacks, and
configurations as Docker images. For server owners, this is the best way to
roll out configuration changes and updates to your servers.

If you wish to do so, here are some of the things you will need to know:


### ONBUILD Trigger

This Docker image contains one `ONBUILD` trigger, which copies any local files
to `/usr/src/minecraft`.

When a container is started for the first time, the contents of this folder is
copied to `/opt/minecraft` via `rsync`, except for anything that starts with
`world`.


### World Templates

This Docker image supports the use of world templates, which is useful for
packaging custom maps. World templates should always start with `world`, which
has been a standard Minecraft convention (e.g. world, world_nether,
world_the_end). Copy your world templates to `/usr/src/minecraft` via the
`ONBUILD` trigger. During startup, it will check if `/opt/minecraft/world` is
empty. If so, it will create a copy of the world template on this folder.


### Environment Variables in Dockerfile


#### `MINECRAFT_HOME` (Read-only!)

To make your life simple, this variable points to where Minecraft is installed.
This points to `/opt/minecraft`. Useful for creating scripts when packaging
modpacks.

**DO NOT OVERRIDE THIS. CHANGES TO THIS VARIABLE ARE IGNORED!**


#### `MINECRAFT_VERSION`

Modpacks will require a specific Minecraft version in order to work. This can
be done setting the `MINECRAFT_VERSION` in your Dockerfile.


#### `MINECRAFT_STARTUP_JAR`

When packaging a modpack, you will need to start the server using a different
jar file. To specify the startup jar, set the `MINECRAFT_STARTUP_JAR` variable
in your Dockerfile.


#### `MINECRAFT_OPTS`

Some modpacks have their own recommended JVM settings. You can include them
via the `MINECRAFT_OPTS` variable in your Dockerfile.


## Supported Docker versions

This image has been tested on Docker version 1.1.1.


## Feedback

Feel free to open a [Github issue][].

If you wish to contribute, you may open a pull request.

[Github issue]: https://github.com/dlord/minecraft-docker/issues
[Minecraft EULA]: https://account.mojang.com/documents/minecraft_eula
