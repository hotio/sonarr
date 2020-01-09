FROM hotio/mono@sha256:81966d7ac8c79de3c0a0713122748d0432463325d5d79a6e399dae5666bfde0e

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8989

ARG SONARR_VERSION=2.0.0.5337

# install app
RUN curl -fsSL "https://download.sonarr.tv/v2/develop/mono/NzbDrone.develop.${SONARR_VERSION}.mono.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/NzbDrone.Update" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
