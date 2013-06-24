# This file describes how to build the buildstep base container
# Build it with 'docker build .'
#
# Larger, less frequently changed steps should come first. They will be cached to speed up future builds.

from ubuntu:quantal
run apt-get update

# General system dependencies
run apt-get install -y --force-yes bind9-host dnsutils daemontools openssh-server openssh-client netcat-openbsd iputils-tracepath curl ed curl git telnet socat mercurial libssl0.9.8 imagemagick

# Database clients
run apt-get install -y --force-yes mysql-client libmysqlclient-dev postgresql postgresql-server-dev-9.1 libsqlite-dev sqlite3

# Build tools
run apt-get install -y --force-yes build-essential autoconf bison libevent-dev libglib2.0-dev libjpeg-dev libpq-dev libssl-dev libxml2-dev libxslt-dev zlib1g-dev graphicsmagick-libmagick-dev-compat

# Dependencies for the Java buildpack
run apt-get install -y --force-yes openjdk-6-jdk
run apt-get install -y --force-yes openjdk-6-jre-headless

# Dependencies for the NodeJS buildpack
run apt-get install -y --force-yes nodejs

# Dependencies for the Python buildpack
run apt-get install -y --force-yes python-dev

# Dependencies for the Ruby buildpack
run apt-get install -y --force-yes ruby1.9.1-dev rubygems

# Install buildpacks
run git clone https://github.com/heroku/heroku-buildpack-ruby /build/buildpacks/heroku-buildpack-ruby
run git clone https://github.com/heroku/heroku-buildpack-nodejs /build/buildpacks/heroku-buildpack-nodejs
run git clone https://github.com/heroku/heroku-buildpack-java /build/buildpacks/heroku-buildpack-java
run git clone https://github.com/heroku/heroku-buildpack-play /build/buildpacks/heroku-buildpack-play
run git clone https://github.com/heroku/heroku-buildpack-python /build/buildpacks/heroku-buildpack-python
run git clone https://github.com/heroku/heroku-buildpack-php /build/buildpacks/heroku-buildpack-php
run git clone https://github.com/kr/heroku-buildpack-go /build/buildpacks/heroku-buildpack-go
run git clone https://github.com/miyagawa/heroku-buildpack-perl /build/buildpacks/heroku-buildpack-perl

# Postinstall of ruby buildpacks
run update-alternatives --set ruby /usr/bin/ruby1.9.1
run update-alternatives --set gem /usr/bin/gem1.9.1
run gem install bundler
run cd /build/buildpacks/heroku-buildpack-ruby && bundle install
run mkdir /app
add ./stack/builder /build/builder
cmd ["/build/builder"]
