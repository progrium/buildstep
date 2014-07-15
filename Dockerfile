FROM ubuntu:quantal
MAINTAINER progrium "progrium@gmail.com"

RUN mkdir /build
ADD ./stack/ /build
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive /build/prepare
RUN rm -rf /var/lib/apt/lists/*
RUN sed s/archive/old-releases/g /etc/apt/sources.list
RUN apt-get clean
