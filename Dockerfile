FROM cloudfoundry/cflinuxfs2
# Use https://hub.docker.com/r/cloudfoundry/cflinuxfs2/
# This is docker image which is used cloudfoundry DEA base.
# Change base image from progrium/cedarish:cedar14
# https://github.com/progrium/cedarish
#
# TODO check differece between cedarish and cflinuxfs2

# Add dependencies
RUN apt-get install -y daemontools

# Install herokuish command
RUN curl https://github.com/gliderlabs/herokuish/releases/download/v0.3.1/herokuish_0.3.1_linux_x86_64.tgz \
		--silent -L | tar -xzC /bin

# Install herokuish supported buildpacks and entrypoints
RUN ln -s /bin/herokuish /build \
	&& ln -s /bin/herokuish /start \
	&& ln -s /bin/herokuish /exec

# backwards compatibility
ADD ./rootfs /

ENV CF_STACK=cflinuxfs2

ADD cf-buildpack.sh /bin/cf-buildpack.sh
RUN /bin/cf-buildpack.sh

