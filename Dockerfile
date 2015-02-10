FROM progrium/cedarish:cedar14

RUN curl https://github.com/gliderlabs/herokuish/releases/download/v0.2.0/herokuish_0.2.0_linux_x86_64.tgz \
		--silent -L | tar -xzC /bin

# install herokuish supported buildpacks and entrypoints
RUN /bin/herokuish buildpack install \
	&& ln -s /bin/herokuish /build \
	&& ln -s /bin/herokuish /start \
	&& ln -s /bin/herokuish /exec

# backwards compatibility
ADD ./rootfs /
