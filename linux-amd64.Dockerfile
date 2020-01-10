FROM hotio/mono@sha256:671ca3060299f25e62a867eed146eae20fadbcb2fb4d772de20080e19d7b602b

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8989

ARG SONARR_VERSION=2.0.0.5338

# install app
RUN curl -fsSL "https://download.sonarr.tv/v2/master/mono/NzbDrone.master.${SONARR_VERSION}.mono.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/NzbDrone.Update" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
