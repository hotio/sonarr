FROM ghcr.io/hotio/base@sha256:6069ceeb6aec1a4b29e8d4bcc531a9cd5fdca9ccddf2e0d639e4a9b9727ce0d0

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8989

# https://download.mono-project.com/repo/ubuntu/dists/focal/snapshots/
ARG MONO_VERSION=6.12.0.122

# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        gnupg && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && echo "deb https://download.mono-project.com/repo/ubuntu focal/snapshots/${MONO_VERSION} main" | tee /etc/apt/sources.list.d/mono-official.list && \
    apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        mono-complete=${MONO_VERSION}\* \
        libmediainfo0v5 && \
# clean up
    apt purge -y gnupg && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ARG VERSION
ARG SBRANCH
ARG PACKAGE_VERSION=${VERSION}
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://download.sonarr.tv/v3/${SBRANCH}/${VERSION}/Sonarr.${SBRANCH}.${VERSION}.linux.tar.gz" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Sonarr.Update" && \
    echo "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=[hotio](https://github.com/hotio)\nUpdateMethod=Docker\nBranch=${SBRANCH}" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

ARG ARR_DISCORD_NOTIFIER_VERSION
RUN curl -fsSL "https://raw.githubusercontent.com/hotio/arr-discord-notifier/${ARR_DISCORD_NOTIFIER_VERSION}/arr-discord-notifier.sh" > "${APP_DIR}/arr-discord-notifier.sh" && \
    chmod u=rwx,go=rx "${APP_DIR}/arr-discord-notifier.sh"

COPY root/ /
