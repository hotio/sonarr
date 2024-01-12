ARG UPSTREAM_IMAGE
ARG UPSTREAM_DIGEST_ARM64

FROM ${UPSTREAM_IMAGE}@${UPSTREAM_DIGEST_ARM64}
EXPOSE 8989
VOLUME ["${CONFIG_DIR}"]

RUN apk add --no-cache libintl sqlite-libs icu-libs

ARG VERSION
ARG SBRANCH
ARG PACKAGE_VERSION=${VERSION}
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://github.com/Sonarr/Sonarr/releases/download/v${VERSION}/Sonarr.${SBRANCH}.${VERSION}.linux-musl-arm64.tar.gz" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Sonarr.Update" && \
    echo -e "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=[hotio](https://github.com/hotio)\nUpdateMethod=Docker\nBranch=${SBRANCH}" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}" && \
    chmod +x "${APP_DIR}/bin/Sonarr" "${APP_DIR}/bin/ffprobe"

COPY root/ /
