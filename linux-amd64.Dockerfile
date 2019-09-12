FROM hotio/mono

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8989
HEALTHCHECK --interval=60s CMD curl -fsSL http://localhost:8989 || exit 1

COPY root/ /

# install app
RUN version=$(sed -n '1p' /versions/sonarr) && \
    curl -fsSL "https://download.sonarr.tv/v2/master/mono/NzbDrone.master.${version}.mono.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"
