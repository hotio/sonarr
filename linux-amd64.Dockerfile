FROM hotio/mono@sha256:8a34991262a2e3a9a3a2f095a81a878cd0a73f5bb03bffcca06ed70e12e96a9f

ARG DEBIAN_FRONTEND="noninteractive"

ENV UNPACKERR="disabled"

EXPOSE 8989

ARG UNPACKERR_VERSION=0.7.0-beta1

# install unpackerr
RUN curl -fsSL "https://github.com/davidnewhall/unpackerr/releases/download/v${UNPACKERR_VERSION}/unpackerr.amd64.linux.gz" | gunzip | dd of=/usr/local/bin/unpackerr && chmod 755 /usr/local/bin/unpackerr

ARG SONARR_VERSION=3.0.3.698

# install app
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://download.sonarr.tv/v3/phantom-develop/${SONARR_VERSION}/Sonarr.phantom-develop.${SONARR_VERSION}.linux.tar.gz" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Sonarr.Update" && \
    echo "PackageVersion=${SONARR_VERSION}\nPackageAuthor=hotio\nReleaseVersion=${SONARR_VERSION}\nUpdateMethod=Docker\nBranch=phantom-develop" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
