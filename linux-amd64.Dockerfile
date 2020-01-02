FROM hotio/mono@sha256:eb658649d158322ab76db26001b0a678fa148f3a948afbe7963589083b788ea3

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8989

# https://download.sonarr.tv/v2/develop/mono/
ARG SONARR_VERSION=2.0.0.5337

# install app
RUN curl -fsSL "https://download.sonarr.tv/v2/develop/mono/NzbDrone.develop.${SONARR_VERSION}.mono.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
