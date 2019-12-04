# sonarr

[![GitHub](https://img.shields.io/badge/source-github-lightgrey)](https://github.com/hotio/docker-sonarr)
[![Docker Pulls](https://img.shields.io/docker/pulls/hotio/sonarr)](https://hub.docker.com/r/hotio/sonarr)
[![Discord](https://img.shields.io/discord/610068305893523457?color=738ad6&label=discord&logo=discord&logoColor=white)](https://discord.gg/CdaP4VT)

## Starting the container

Just the basics to get the container running:

```shell
docker run --rm --name sonarr -p 8989:8989 -v /tmp/sonarr:/config hotio/sonarr
```

The environment variables below are all optional, the values you see are the defaults.

```shell
-e PUID=1000
-e PGID=1000
-e UMASK=002
-e TZ="Etc/UTC"
```

## Tags

| Tag      | Description          | Build Status                                                                                                                                            | Last Updated                                                                                           |
| ---------|----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------|
| latest   | The same as `stable` |                                                                                                                                                         |                                                                                                        |
| stable   | Stable version, V2   | [![Build Status](https://cloud.drone.io/api/badges/hotio/docker-sonarr/status.svg?ref=refs/heads/stable)](https://cloud.drone.io/hotio/docker-sonarr)   | ![GitHub last commit (branch)](https://img.shields.io/github/last-commit/hotio/docker-sonarr/stable)   |
| unstable | Unstable version, V2 | [![Build Status](https://cloud.drone.io/api/badges/hotio/docker-sonarr/status.svg?ref=refs/heads/unstable)](https://cloud.drone.io/hotio/docker-sonarr) | ![GitHub last commit (branch)](https://img.shields.io/github/last-commit/hotio/docker-sonarr/unstable) |
| phantom  | Unstable version, V3 | [![Build Status](https://cloud.drone.io/api/badges/hotio/docker-sonarr/status.svg?ref=refs/heads/phantom)](https://cloud.drone.io/hotio/docker-sonarr)  | ![GitHub last commit (branch)](https://img.shields.io/github/last-commit/hotio/docker-sonarr/phantom)  |

You can also find tags that reference a commit or version number.

## Executing your own scripts

If you have a need to do additional stuff when the container starts or stops, you can mount your script with `-v /docker/host/my-script.sh:/etc/cont-init.d/99-my-script` to execute your script on container start or `-v /docker/host/my-script.sh:/etc/cont-finish.d/99-my-script` to execute it when the container stops. An example script can be seen below.

```shell
#!/usr/bin/with-contenv bash

echo "Hello, this is me, your script."
```
