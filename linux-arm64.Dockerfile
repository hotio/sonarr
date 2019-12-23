FROM hotio/mono@sha256:41650dbe0e1d2f3a7dfaf73db59fd743fd3efa0d5548345b37687138fddd8d6e

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8989

# https://download.sonarr.tv/v2/develop/mono/
ARG SONARR_VERSION=2.0.0.5337

# install app
RUN curl -fsSL "https://download.sonarr.tv/v2/develop/mono/NzbDrone.develop.${SONARR_VERSION}.mono.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
