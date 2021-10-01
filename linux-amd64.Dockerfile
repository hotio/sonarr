FROM ghcr.io/hotio/base@sha256:36b96946e2d3480de7e5212b33b07a56aa65052f26ce33cacdce7e84a88a6c5a

EXPOSE 8989

RUN apk add --no-cache coreutils grep ca-certificates sqlite-libs && \
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main tinyxml2 && \
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community libmediainfo && \
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing mono

ARG VERSION
ARG SBRANCH
ARG PACKAGE_VERSION=${VERSION}
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://download.sonarr.tv/v3/${SBRANCH}/${VERSION}/Sonarr.${SBRANCH}.${VERSION}.linux.tar.gz" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Sonarr.Update" && \
    echo -e "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=[hotio](https://github.com/hotio)\nUpdateMethod=Docker\nBranch=${SBRANCH}" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

ARG ARR_DISCORD_NOTIFIER_VERSION
RUN curl -fsSL "https://raw.githubusercontent.com/hotio/arr-discord-notifier/${ARR_DISCORD_NOTIFIER_VERSION}/arr-discord-notifier.sh" > "${APP_DIR}/arr-discord-notifier.sh" && \
    chmod u=rwx,go=rx "${APP_DIR}/arr-discord-notifier.sh"

COPY root/ /
