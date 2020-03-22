FROM hotio/mono@sha256:899c71346bb2ca8f1c699939b18d37e041f12efe2ad9312211da9b3335d2f4f0

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8989

ARG SONARR_VERSION=3.0.3.740

# install app
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://download.sonarr.tv/v3/phantom-develop/${SONARR_VERSION}/Sonarr.phantom-develop.${SONARR_VERSION}.linux.tar.gz" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Sonarr.Update" && \
    echo "PackageVersion=${SONARR_VERSION}\nPackageAuthor=hotio\nReleaseVersion=${SONARR_VERSION}\nUpdateMethod=Docker\nBranch=phantom-develop" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
