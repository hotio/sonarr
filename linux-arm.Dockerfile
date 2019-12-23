FROM hotio/mono@sha256:165c748104d81df03e81fb3e26f61285a84267a72ec2027465417404f6bad807

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8989

# https://download.sonarr.tv/v2/develop/mono/
ARG SONARR_VERSION=2.0.0.5337

# install app
RUN curl -fsSL "https://download.sonarr.tv/v2/develop/mono/NzbDrone.develop.${SONARR_VERSION}.mono.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
