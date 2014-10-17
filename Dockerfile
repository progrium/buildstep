FROM ubuntu:14.04
MAINTAINER progrium "progrium@gmail.com"

RUN mkdir /build
ADD ./stack/prepare /build/prepare
ADD ./stack/buildpacks.txt /build/buildpacks.txt
ADD ./stack/packages.txt /build/packages.txt
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive /build/prepare
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean

ADD ./stack/builder /build/builder