FROM progrium/cedarish:cedar14
MAINTAINER progrium "progrium@gmail.com"

ADD http://archive.ubuntu.com/ubuntu/pool/universe/r/runit/runit_2.1.1-6.2ubuntu3_amd64.deb /tmp/runit.deb
RUN dpkg-deb -x /tmp/runit.deb / && rm /tmp/runit.deb

ADD ./stack/configs/etc-profile /etc/profile

ADD ./builder/ /build
RUN xargs -L 1 /build/install-buildpack /tmp/buildpacks < /build/config/buildpacks.txt
