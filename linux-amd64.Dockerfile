FROM hotio/mono@sha256:7794be1032777eb0e81b3f1c888c555b6777b1542733a167fc84689755980bfb

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8989

# https://download.sonarr.tv/v2/master/mono/
ARG SONARR_VERSION=2.0.0.5338

# install app
RUN curl -fsSL "https://download.sonarr.tv/v2/master/mono/NzbDrone.master.${SONARR_VERSION}.mono.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
