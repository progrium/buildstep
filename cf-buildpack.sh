#!/bin/bash
# Fetch cloudfoundry buildpacks
set -e

buildpack-install() {
    local runtime="$1"
    local commit="$2"

    echo "Clone ${runtime}-buildpack version ${commit}"
    git clone --quiet \
        --depth=1 \
        --branch ${commit} \
        --recursive \
        https://github.com/cloudfoundry/${runtime}-buildpack /tmp/buildpacks/${runtime}-buildpack >/dev/null  2>&1
}

buildpack-install java v3.6
buildpack-install ruby v1.6.14
buildpack-install nodejs v1.5.7
buildpack-install binary v1.0.1
buildpack-install go v1.7.3
buildpack-install python v1.5.4
buildpack-install staticfile v1.3.2

# TODO (tcnksm): php buildpack is failed because of permission
# buildpack-install php v4.3.6
git clone --quiet --depth=1 https://github.com/heroku/heroku-buildpack-php /tmp/buildpacks/php-buildpack >/dev/null 2>&1




