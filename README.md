# sonarr

![logo](https://hotio.dev/img/sonarr.png)

![Base](https://img.shields.io/badge/base-ubuntu-orange)
[![GitHub](https://img.shields.io/badge/source-github-lightgrey)](https://github.com/hotio/docker-sonarr)
[![Docker Pulls](https://img.shields.io/docker/pulls/hotio/sonarr)](https://hub.docker.com/r/hotio/sonarr)
[![GitHub Registry](https://img.shields.io/badge/registry-ghcr.io-blue)](https://github.com/users/hotio/packages/container/sonarr/versions)
[![Discord](https://img.shields.io/discord/610068305893523457?color=738ad6&label=discord&logo=discord&logoColor=white)](https://discord.gg/3SnkuKp)
[![Upstream](https://img.shields.io/badge/upstream-project-yellow)](https://github.com/Sonarr/Sonarr)

## Starting the container

Just the basics to get the container running:

```shell
docker run --rm --name sonarr -p 8989:8989 -v /<host_folder_config>:/config hotio/sonarr
```

The environment variables below are all optional, the values you see are the defaults.

```shell
-e PUID=1000
-e PGID=1000
-e UMASK=002
-e TZ="Etc/UTC"
-e ARGS=""
-e DEBUG="no"
```

## Tags

| Tag                | Upstream        |
| -------------------|-----------------|
| `release` (latest) | master          |
| `testing`          | develop         |
| `nightly`          | phantom-develop |

You can also find tags that reference a commit or version number.

## Configuration location

Your sonarr configuration inside the container is stored in `/config/app`, to migrate from another container, you'd probably have to move your files from `/config` to `/config/app`.

## Executing your own scripts

If you have a need to do additional stuff when the container starts or stops, you can mount your script with `-v /docker/host/my-script.sh:/etc/cont-init.d/99-my-script` to execute your script on container start or `-v /docker/host/my-script.sh:/etc/cont-finish.d/99-my-script` to execute it when the container stops. An example script can be seen below.

```shell
#!/usr/bin/with-contenv bash

echo "Hello, this is me, your script."
```

## Troubleshooting a problem

By default all output is redirected to `/dev/null`, so you won't see anything from the application when using `docker logs`. Most applications write everything to a log file too. If you do want to see this output with `docker logs`, you can use `-e DEBUG="yes"` to enable this.
