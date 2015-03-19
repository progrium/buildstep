FROM progrium/cedarish:cedar14
MAINTAINER Jeff Lindsay <progrium@gmail.com>

RUN curl https://github.com/gliderlabs/herokuish/releases/download/v0.1.0/herokuish_0.1.0_linux_x86_64.tgz \
		--silent -L | tar -xzC /bin

# install herokuish supported buildpacks
RUN /bin/herokuish buildpack install

# entrypoints
RUN ln -s /bin/herokuish /build
RUN ln -s /bin/herokuish /start
RUN ln -s /bin/herokuish /exec

# backwards compatibility
ADD ./rootfs /
