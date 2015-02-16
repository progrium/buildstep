FROM ruby:2.1.5
MAINTAINER Jeff Lindsay <progrium@gmail.com>

RUN curl -sSL https://get.docker.io | sh

ADD . /tmp/buildstep-test

WORKDIR /tmp/buildstep-test

RUN bundle install

CMD ["bundle", "exec", "cucumber", "--exclude", "features/apps"]
