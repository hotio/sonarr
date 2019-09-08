FROM hotio/mono

ARG DEBIAN_FRONTEND="noninteractive"
ARG COMMIT
ARG TAG

ENV COMMIT="${COMMIT}" TAG="${TAG}"
ENV APP="Sonarr"
EXPOSE 8989
HEALTHCHECK --interval=60s CMD curl -fsSL http://localhost:8989 || exit 1

# install app
# https://download.sonarr.tv/v2/master/mono/
RUN curl -fsSL "https://download.sonarr.tv/v2/master/mono/NzbDrone.master.2.0.0.5338.mono.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
