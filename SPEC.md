# buildkit

## Config

Buildkit Config

`BUILDKIT_BUILDERS`
- comma separated list of builders to use in given order
- example: dockerfile, herokuish
- builtin: dockerfile, herokuish
- sourced from plugins in builder.bash

`BUILDKIT_ARTIFACT`
- type of artifact: file or image.
- default: image

`BUILDKIT_FILE`
- name of file to use when working with file artifact
- example: myapp.tgz

`BUILDKIT_TAG`
- name of tag to use on image when working with image artifact
- example: progrium/myapp:v1

`BUILDKIT_INPUT`
- input method to use for staging /tmp/src
- example: stdin
- builtin: stdin, dir
- sourced from plugins in importer.bash

`BUILDKIT_OUTPUT`
- output method to use with artifact
- example: docker
- builtin: stdout, docker, dir
- sourced from plugins in exporter.bash

`BUILDKIT_ENGINE`
- docker engine to use for build.
- default: local
- example: dind
- builtin: local, dind
- sourced from plugins in engine.bash

`BUILDKIT_VOLUME`
- path used for volume in data container images.
- default: /data
- example: /my/long/path


Herokuish Plugin Config

`HEROKUISH_IMAGE`
- image to use for builder.
- default: gliderlabs/herokuish:latest
- example: gliderlabs/herokuish:v3

`HEROKUISH_MODE`
- force artifact mode: slug or image
- example: slug
- if not specified, mode is based on BUILDKIT_ARTIFACT

`HEROKUISH_INSTALL`
- space separated urls to buildpacks to install
- example: https://github.com/heroku/heroku-buildpack-go

Docker-in-Docker Plugin Config

`DIND_IMAGE`
- image to use for dind.
- default: progrium/dind:latest

`DIND_NAME`
- name to use for dind container.
- default: buildkit.dind-<random>

`DIND_OPTS`
- docker daemon options to pass to dind
- example: -H 127.0.0.1:1234

`DIND_MOUNT`
- host path used to bind mount in /var/lib/docker
- example: /mnt/my/cached/dind/data


Dockerfile Plugin Config

`DOCKERFILE_OPTS`
- options to pass to `docker build`
- example: —-force-rm

`DOCKERFILE_CP`
- specify file to `docker cp` from image
- example: /path/to/artifact/in/container

## Examples
```
# Take Heroku app in ./app and make a Docker image called myapp with Herokuish.
# Progress output is displayed to STDOUT and ./app is untouched.
docker run —-rm \
	-e BUILDKIT_BUILDERS=herokuish \
	-e BUILDKIT_ARTIFACT=image \
	-e BUILDKIT_TAG=myapp:v1 \
	-e BUILDKIT_OUTPUT=docker \
	-e BUILDKIT_INPUT=dir \
	-v $PWD/app:/src \
	-v /var/run/docker.sock:/var/run/docker.sock \
	buildkit

# Same as above but first detects if a Dockerfile exists to make image from,
# and exports the image as a file called myapp_v2.tgz into ./build
docker run --rm \
	-e BUILDKIT_BUILDERS=dockerfile,herokuish \
	-e BUILDKIT_ARTIFACT=file \
	-e BUILDKIT_TAG=myapp:v2 \
	-e BUILDKIT_OUTPUT=dir \
	-e BUILDKIT_INPUT=dir \
	-v $PWD/app:/src \
	-v $PWD/build:/build \
	-v /var/run/docker.sock:/var/run/docker.sock \
	buildkit

# Same as above but creates data container image called myapp:v3 from scratch
# that contains myapp.tgz in the volume /data
docker run —-rm \
	-e BUILDKIT_BUILDERS=dockerfile \
	-e BUILDKIT_ARTIFACT=file \
	-e BUILDKIT_FILE=myapp.tgz \
	-e BUILDKIT_OUTPUT=docker \
	-e BUILDKIT_TAG=myapp:v3 \
	-e BUILDKIT_INPUT=dir \
	-v $PWD/app:/src \
	-v /var/run/docker.sock:/var/run/docker.sock \
	buildkit

# Take Heroku app in current git directory and pass to Buildkit via STDIN to Herokuish.
# Herokuish builds app and produces a slug which Buildkit streams out via STDOUT to myapp.tgz
# and any progress output is redirected to STDERR.
git archive master | docker run —-rm -i \
	-e BUILDKIT_BUILDERS=herokuish \
	-e BUILDKIT_ARTIFACT=file \
	-e BUILDKIT_OUTPUT=stdout \
	-e BUILDKIT_INPUT=stdin \
	-e HEROKUISH_MODE=slug \
	-v /var/run/docker.sock:/var/run/docker.sock \
	buildkit > myapp.tgz

# Build a Dockerfile app as an image tagged myapp:v4 but built using a Docker in Docker instance.
docker run —-rm \
	-e BUILDKIT_BUILDERS=dockerfile \
	-e BUILDKIT_ARTIFACT=image \
	-e BUILDKIT_TAG=myapp:v4 \
	-e BUILDKIT_OUTPUT=docker \
	-e BUILDKIT_ENGINE=dind \
	-e BUILDKIT_INPUT=dir \
	-v $PWD/app:/src \
	-v /var/run/docker.sock:/var/run/docker.sock \
	buildkit
```

# Plugin API

Most plugins are providing namespaced functions sourced from a file that
represents a particular interface:

### importer.bash

  * `<plugin>:import` - gets source and stages at /tmp/src

Example:
```
stdin:import() {
  cat | tar -xC /tmp/src
}
```

### exporter.bash - (export from buildkit)

 * `<plugin>:export-file` - exports a file artifact, potentially staged at /tmp/artifact
 * `<plugin>:export-image` - exports an image artifact, tagged with BUILDKIT_TAG

### builder.bash

 * `<plugin>:detect-build` - performs detect for this builder based on src at /tmp/src
 * `<plugin>:build-file` - performs a build expecting a file artifact
 * `<plugin>:build-image` - performs a build expecting an image artifact

## Hooks

Plugins have the option of a few traditional hooks as well:

 * `boot` - when the container starts. can be used to start pulling images like dind
