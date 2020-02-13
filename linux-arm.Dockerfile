FROM hotio/mono@sha256:c57c4bba4de56ecf369bfdc90b79e320f6c312dda6a850500ecba09aa1931926

ARG DEBIAN_FRONTEND="noninteractive"

ENV UNPACKERR="disabled"

EXPOSE 8989

ARG UNPACKERR_VERSION=0.7.0-beta1

# install unpackerr
RUN curl -fsSL "https://github.com/davidnewhall/unpackerr/releases/download/v${UNPACKERR_VERSION}/unpackerr.armhf.linux.gz" | gunzip | dd of=/usr/local/bin/unpackerr && chmod 755 /usr/local/bin/unpackerr

ARG SONARR_VERSION=3.0.3.698

# install app
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://download.sonarr.tv/v3/phantom-develop/${SONARR_VERSION}/Sonarr.phantom-develop.${SONARR_VERSION}.linux.tar.gz" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Sonarr.Update" && \
    echo "PackageVersion=${SONARR_VERSION}\nPackageAuthor=hotio\nReleaseVersion=${SONARR_VERSION}\nUpdateMethod=Docker\nBranch=phantom-develop" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
