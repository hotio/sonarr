FROM hotio/mono@sha256:30dd3768f2ee5f47e91157e53dde5c10c6ee8c93b8294ef513fde475755b8991

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8989

ARG SONARR_VERSION=2.0.0.5343

# install app
RUN curl -fsSL "https://download.sonarr.tv/v2/develop/mono/NzbDrone.develop.${SONARR_VERSION}.mono.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/NzbDrone.Update" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
