# sonarr

[![GitHub](https://img.shields.io/badge/source-github-lightgrey?style=flat-square)](https://github.com/hotio/docker-sonarr)
[![Docker Pulls](https://img.shields.io/docker/pulls/hotio/sonarr?style=flat-square)](https://hub.docker.com/r/hotio/sonarr)
[![Drone (cloud)](https://img.shields.io/drone/build/hotio/docker-sonarr?style=flat-square)](https://cloud.drone.io/hotio/docker-sonarr)

## Starting the container

Just the basics to get the container running:

```shell
docker run --rm --name sonarr -p 8989:8989 -v /tmp/sonarr:/config -e TZ=Etc/UTC hotio/sonarr
```

The environment variables below are all optional, the values you see are the defaults.

```shell
-e PUID=1000
-e PGID=1000
-e UMASK=022
-e VERSION=image
```

Possible values for `VERSION`:

```shell
VERSION=image
VERSION=stable
VERSION=unstable
VERSION=https://download.sonarr.tv/v2/master/mono/NzbDrone.master.2.0.0.5228.mono.tar.gz
VERSION=file:///config/NzbDrone.master.2.0.0.5228.mono.tar.gz
```

## Tags

| Tag     | Description          |
| --------|----------------------|
| latest  | Stable version, V2   |
| master  | Stable version, V2   |
| phantom | Unstable version, V3 |

You can also find tags that reference a commit or version number.

## Executing your own scripts

If you have a need to do additional stuff when the container starts or stops, you can mount your script with `-v /docker/host/my-script.sh:/etc/cont-init.d/99-my-script` to execute your script on container start or `-v /docker/host/my-script.sh:/etc/cont-finish.d/99-my-script` to execute it when the container stops. An example script can be seen below.

```shell
#!/usr/bin/with-contenv bash

echo "Hello, this is me, your script."
```
