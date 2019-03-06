# Suitarr

Suitarr is a collection of docker images. Suitarr gives you the option of installing different versions for every app, completely optional.

## Support on Beerpay

Hey dude! Help me out for a couple of :beers:!

[![Beerpay](https://beerpay.io/hotio/suitarr/badge.svg?style=beer-square)](https://beerpay.io/hotio/suitarr)

## Donations

NANO: `xrb_1bxqm6nsm55s64rgf8f5k9m795hda535to6y15ik496goatakpupjfqzokfc`  
BTC: `39W6dcaG3uuF5mZTRL4h6Ghem74kUBHrmz`  
LTC: `MMUFcGLiK6DnnHGFnN2MJLyTfANXw57bDY`

## Starting the container

The environment variables `PUID`, `PGID`, `UMASK`, `VERSION`, `BACKUP` and `TZ` are all optional, the values you see below are the default values.

By default the image comes with a stable version. You can however install a different version with the environment variable `VERSION`. The value `image` does nothing, but keep the included version, all the others install a different version when starting the container.

```shell
-e PUID=1000
-e PGID=1000
-e UMASK=022
-e VERSION=image
-e BACKUP=yes
-e TZ=Europe/Brussels
```

```yaml
environment:
  - PUID=1000
  - PGID=1000
  - UMASK=022
  - VERSION=image
  - BACKUP=yes
  - TZ=Europe/Brussels
```

### [Radarr](https://github.com/Radarr/Radarr)

```shell
docker run --rm --name radarr -p 7878:7878 -v /tmp/radarr:/config hotio/radarr
```

```yaml
radarr:
  container_name: radarr
  image: hotio/radarr
  ports:
    - "7878:7878"
  volumes:
    - /tmp/radarr:/config
```

```shell
VERSION=image
VERSION=stable
VERSION=unstable
VERSION=https://github.com/Radarr/Radarr/releases/download/v0.2.0.1120/Radarr.develop.0.2.0.1120.linux.tar.gz
VERSION=file:///config/Radarr.develop.0.2.0.1120.linux.tar.gz
```

### [Sonarr](https://github.com/Sonarr/Sonarr)

```shell
docker run --rm --name sonarr -p 8989:8989 -v /tmp/sonarr:/config hotio/sonarr
```

```yaml
sonarr:
  container_name: sonarr
  image: hotio/sonarr
  ports:
    - "8989:8989"
  volumes:
    - /tmp/sonarr:/config
```

```shell
VERSION=image
VERSION=stable
VERSION=unstable
VERSION=v3
VERSION=https://download.sonarr.tv/v2/master/mono/NzbDrone.master.2.0.0.5228.mono.tar.gz
VERSION=file:///config/NzbDrone.master.2.0.0.5228.mono.tar.gz
```

### [Sonarr3](https://github.com/Sonarr/Sonarr)

```shell
docker run --rm --name sonarr3 -p 8989:8989 -v /tmp/sonarr3:/config hotio/sonarr3
```

```yaml
sonarr3:
  container_name: sonarr3
  image: hotio/sonarr3
  ports:
    - "8989:8989"
  volumes:
    - /tmp/sonarr3:/config
```

```shell
VERSION=image
VERSION=stable
VERSION=unstable
VERSION=https://download.sonarr.tv/v3/phantom-develop/3.0.1.371/Sonarr.phantom-develop.3.0.1.371.linux.tar.gz
VERSION=file:///config/Sonarr.phantom-develop.3.0.1.371.linux.tar.gz
```

### [Lidarr](https://github.com/lidarr/Lidarr)

```shell
docker run --rm --name lidarr -p 8686:8686 -v /tmp/lidarr:/config hotio/lidarr
```

```yaml
lidarr:
  container_name: lidarr
  image: hotio/lidarr
  ports:
    - "8686:8686"
  volumes:
    - /tmp/lidarr:/config
```

```shell
VERSION=image
VERSION=stable
VERSION=unstable
VERSION=https://github.com/lidarr/Lidarr/releases/download/v0.3.0.430/Lidarr.develop.0.3.0.430.linux.tar.gz
VERSION=file:///config/Lidarr.develop.0.3.0.430.linux.tar.gz
```

### [Jackett](https://github.com/Jackett/Jackett)

```shell
docker run --rm --name jackett -p 9117:9117 -v /tmp/jackett:/config hotio/jackett
```

```yaml
jackett:
  container_name: jackett
  image: hotio/jackett
  ports:
    - "9117:9117"
  volumes:
    - /tmp/jackett:/config
```

```shell
VERSION=image
VERSION=stable
VERSION=unstable
VERSION=https://github.com/Jackett/Jackett/releases/download/v0.8.1162/Jackett.Binaries.Mono.tar.gz
VERSION=file:///config/Jackett.Binaries.Mono.tar.gz
```

### [NZBHydra2](https://github.com/theotherp/nzbhydra2)

```shell
docker run --rm --name nzbhydra2 -p 5076:5076 -v /tmp/nzbhydra2:/config hotio/nzbhydra2
```

```yaml
nzbhydra2:
  container_name: nabhydra2
  image: hotio/nzbhydra2
  ports:
    - "5076:5076"
  volumes:
    - /tmp/nzbhydra2:/config
```

```shell
VERSION=image
VERSION=stable
VERSION=unstable
VERSION=https://github.com/theotherp/nzbhydra2/releases/download/v1.5.1/nzbhydra2-1.5.1-linux.zip
VERSION=file:///config/nzbhydra2-1.5.1-linux.zip
```

### [NZBGet](https://github.com/nzbget/nzbget)

```shell
docker run --rm --name nzbget -p 6789:6789 -v /tmp/nzbget:/config hotio/nzbget
```

```yaml
nzbget:
  container_name: nzbget
  image: hotio/nzbget
  ports:
    - "6789:6789"
  volumes:
    - /tmp/nzbget:/config
```

```shell
VERSION=image
VERSION=stable
VERSION=unstable
VERSION=https://github.com/nzbget/nzbget/releases/download/v20.0/nzbget-20.0-bin-linux.run
VERSION=file:///config/nzbget-20.0-bin-linux.run
```

### [Bazarr](https://github.com/morpheus65535/bazarr)

```shell
docker run --rm --name bazarr -p 6767:6767 -v /tmp/bazarr:/config hotio/bazarr
```

```yaml
bazarr:
  container_name: bazarr
  image: hotio/bazarr
  ports:
    - "6767:6767"
  volumes:
    - /tmp/bazarr:/config
```

```shell
VERSION=image
VERSION=stable
VERSION=unstable
VERSION=https://github.com/morpheus65535/bazarr/archive/master.tar.gz
VERSION=file:///config/master.tar.gz
```

### [SABnzbd](https://github.com/sabnzbd/sabnzbd)

```shell
docker run --rm --name sabnzbd -p 8080:8080 -v /tmp/sabnzbd:/config hotio/sabnzbd
```

```yaml
sabnzbd:
  container_name: sabnzbd
  image: hotio/sabnzbd
  ports:
    - "8080:8080"
  volumes:
    - /tmp/sabnzbd:/config
```

```shell
VERSION=image
VERSION=stable
VERSION=unstable
VERSION=https://github.com/sabnzbd/sabnzbd/releases/download/2.3.4/SABnzbd-2.3.4-src.tar.gz
VERSION=file:///config/SABnzbd-2.3.4-src.tar.gz
```

### [Ombi](https://github.com/tidusjar/Ombi)

```shell
docker run --rm --name ombi -p 5000:5000 -v /tmp/ombi:/config hotio/ombi
```

```yaml
ombi:
  container_name: ombi
  image: hotio/ombi
  ports:
    - "5000:5000"
  volumes:
    - /tmp/ombi:/config
```

```shell
VERSION=image
VERSION=stable
VERSION=unstable
VERSION=https://github.com/tidusjar/Ombi/releases/download/v3.0.3477/linux.tar.gz
VERSION=file:///config/linux.tar.gz
```

### [Tautulli](https://github.com/Tautulli/Tautulli)

```shell
docker run --rm --name tautulli -p 8181:8181 -v /tmp/tautulli:/config hotio/tautulli
```

```yaml
tautulli:
  container_name: tautulli
  image: hotio/tautulli
  ports:
    - "8181:8181"
  volumes:
    - /tmp/tautulli:/config
```

```shell
VERSION=image
VERSION=stable
VERSION=unstable
VERSION=https://github.com/Tautulli/Tautulli/archive/v2.1.14.tar.gz
VERSION=file:///config/v2.1.14.tar.gz
```

### [Nanode](https://github.com/nanocurrency/raiblocks)

```shell
docker run --rm --name nanode -p 7075:7075/udp -p 7075:7075 -p 127.0.0.1:7076:7076 -v /tmp/nanode:/config hotio/nanode
```

```yaml
nanode:
  container_name: nanode
  image: hotio/nanode
  ports:
    - "7075:7075/udp"
    - "7075:7075"
    - "127.0.0.1:7076:7076"
  volumes:
    - /tmp/nanode:/config
```

```shell
VERSION=image
VERSION=stable
VERSION=unstable
VERSION=https://github.com/nanocurrency/raiblocks/releases/download/V16.0/nano-16.0.0-Linux.tar.bz2
VERSION=file:///config/nano-16.0.0-Linux.tar.bz2
```

### [Nanomon](https://github.com/NanoTools/nanoNodeMonitor)

```shell
docker run --rm --name nanomon -p 8081:8081 -v /tmp/nanomon:/config hotio/nanomon
```

```yaml
nanomon:
  container_name: nanomon
  image: hotio/nanomon
  ports:
    - "8081:8081"
  volumes:
    - /tmp/nanomon:/config
```

```shell
VERSION=image
VERSION=stable
VERSION=unstable
VERSION=https://github.com/NanoTools/nanoNodeMonitor/archive/v1.4.10.tar.gz
VERSION=file:///config/v1.4.10.tar.gz
```

## Backing up the configuration

By default on every docker container shutdown a backup is created from the configuration files. You can change this behaviour.

```shell
-e BACKUP=no
```

```yaml
environment:
  - BACKUP=no
```

## Using a rclone mount

Mounting a remote filesystem using `rclone` can be done with the environment variable `RCLONE`. Use `docker exec -it --user hotio CONTAINERNAME rclone config` to configure your remote when the container is running. Configuration files for `rclone` are stored in `/config/.config/rclone`.

```shell
-e RCLONE="remote1:path/to/files,/localmount1|remote2:path/to/files,/localmount2"
```

```yaml
environment:
  - RCLONE=remote1:path/to/files,/localmount1|remote2:path/to/files,/localmount2
```

## Using a rar2fs mount

Mounting a filesystem using `rar2fs` can be done with the environment variable `RAR2FS`. The new mount will be read-only. Using a `rar2fs` mount makes the use of an unrar script obsolete. You can mount a `rar2fs` mount on top of an `rclone` mount, `rclone` mounts are mounted first.

```shell
-e RAR2FS="/folder1-rar,/folder1-unrar|/folder2-rar,/folder2-unrar"
```

```yaml
environment:
  - RAR2FS=/folder1-rar,/folder1-unrar|/folder2-rar,/folder2-unrar
```

## Extra docker priviliges

In most cases you will need some or all of the following flags added to your command to get the required docker privileges when using a rclone or rar2fs mount.

```shell
--security-opt apparmor:unconfined --cap-add SYS_ADMIN --device /dev/fuse
```

```yaml
security_opt:
  - apparmor:unconfined
cap_add:
  - SYS_ADMIN
devices:
  - /dev/fuse
```
