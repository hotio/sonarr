FROM hotio/mono@sha256:63ef2b58d083322a18a9f764962b38a32258c528ff763907d176455366667dc8

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8989

# https://download.sonarr.tv/v2/master/mono/
ARG SONARR_VERSION=2.0.0.5338

# install app
RUN curl -fsSL "https://download.sonarr.tv/v2/master/mono/NzbDrone.master.${SONARR_VERSION}.mono.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
