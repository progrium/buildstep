
# Initial Plugn
## sources <plugin-name>.sh from all plugins that have it
    eval “$(plugn source)”

## sources importer.bash from all plugins that have it
    eval “$(plugn source importer.bash)”

# Plugins
Herokuish
Docker
Core/Builtin

# Initial Buildkit
## Example - 1 Day

```  
docker run —-rm \
	-e BUILDKIT_BUILDERS=docker \
	-e BUILDKIT_ARTIFACT=file \
	-e BUILDKIT_FILE=myapp.tgz \
	-e BUILDKIT_OUTPUT=docker \
	-e BUILDKIT_TAG=myapp:v3 \
	-e BUILDKIT_INPUT=dir \
	-v $PWD/app:/src \
	-v /var/run/docker.sock:/var/run/docker.sock \
	buildkit
```

```
# Take app from current git directory and pass to Buildkit via STDIN to docker.
# docker builds app and produces a file which Buildkit streams out via STDOUT to myapp.tgz
# and any progress output is redirected to STDERR.

git archive master | docker run —-rm -i \
	-e BUILDKIT_BUILDERS=docker \
	-e BUILDKIT_ARTIFACT=file \
	-e BUILDKIT_OUTPUT=stdout \
	-e BUILDKIT_INPUT=stdin \
	-v /var/run/docker.sock:/var/run/docker.sock \
	buildkit > myapp.tgz
```
```
git archive master | \
	BUILDKIT_BUILDERS=docker \
	BUILDKIT_ARTIFACT=file \
	BUILDKIT_OUTPUT=stdout \
	BUILDKIT_INPUT=stdin \
	buildkit > myapp.tgz
```
## Plugins
### Core - 1 Day
- exporter
  - stdout:export-file - write tar to stdout
- importer
  - stdin: extract tar from stdin to /tmp/src

### Docker - 1 Day
- builder
  - detect-build: check for dockerfile - /tmp/src
  - build-image: tag build image.
  - build-file: export from docker as a tar, save in artifacts folder


# Sprint 2
## Adding Herokuish - 1 day
  - image tag
  - exporter (from core)
  - herokuish vars

# Docker in docker - 2 day
- env vars
- Export image to parent docker
- logic to choose which docker daemon to use.


# Sprint 3
- hooks
## Dockerfile Plugin Config

`DOCKERFILE_OPTS`
- options to pass to `docker build`
- example: —-force-rm

`DOCKERFILE_CP`
- specify file to `docker cp` from image
- example: /path/to/artifact/in/container
