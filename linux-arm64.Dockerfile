FROM hotio/mono@sha256:7d4fdc4ed5378736f28e8e45ed7b5e146db6150c72e1dc598eb1b7e172e9a6fa

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8989

ARG SONARR_VERSION
ARG PACKAGE_VERSION=${SONARR_VERSION}

# install app
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://download.sonarr.tv/v3/phantom-develop/${SONARR_VERSION}/Sonarr.phantom-develop.${SONARR_VERSION}.linux.tar.gz" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Sonarr.Update" && \
    echo "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=hotio\nUpdateMethod=Docker\nBranch=phantom-develop" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
