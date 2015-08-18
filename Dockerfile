FROM alpine

RUN apk --update add bash docker

ENV PLUGIN_PATH /var/buildkit/plugins

COPY buildkit /usr/bin/
COPY plugn /usr/bin/
COPY plugins/ /var/buildkit/plugins

RUN mkdir -p /tmp/src \
    && plugn enable core \
    && plugn enable docker \
    && plugn list

ENTRYPOINT ["buildkit"]
