FROM hotio/mono@sha256:5331c582f976175ce0686fc0e91b7ce14e3defaf1f332da69557fca5d962a9b7

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8989

ARG VERSION
ARG PACKAGE_VERSION=${VERSION}

# install app
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://download.sonarr.tv/v3/phantom-develop/${VERSION}/Sonarr.phantom-develop.${VERSION}.linux.tar.gz" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Sonarr.Update" && \
    echo "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=[hotio](https://github.com/hotio)\nUpdateMethod=Docker\nBranch=phantom-develop" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
