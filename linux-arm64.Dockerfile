ARG BRANCH
FROM hotio/mono:${BRANCH}

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8989
HEALTHCHECK --interval=60s CMD curl -fsSL http://localhost:8989 || exit 1

COPY root/ /

# https://download.sonarr.tv/v2/master/mono/
ENV SONARR_VERSION=2.0.0.5338

# install app
RUN curl -fsSL "https://download.sonarr.tv/v2/master/mono/NzbDrone.master.${SONARR_VERSION}.mono.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"
