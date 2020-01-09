FROM hotio/mono@sha256:76e748ef4680eb3f013cec27993bff694730feaed7555705339d974f16811db2

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8989

ARG SONARR_VERSION=2.0.0.5337

# install app
RUN curl -fsSL "https://download.sonarr.tv/v2/develop/mono/NzbDrone.develop.${SONARR_VERSION}.mono.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/NzbDrone.Update" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
