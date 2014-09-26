FROM progrium/cedarish:cedar14
MAINTAINER progrium "progrium@gmail.com"

ADD ./builder/ /build
RUN xargs -L 1 /build/install-buildpack /tmp/buildpacks < /build/buildpacks.txt
