# Buildstep

Heroku-style application builds using Docker and Buildpacks. Used by [Dokku](https://github.com/progrium/dokku) to make a mini-Heroku.

## Requirements

 * Docker
 * Git

## Supported Buildpacks

Buildpacks should generally just work, but many of them make assumptions about their environment. So Buildstep has a [list of officially supported buildpacks](https://github.com/progrium/buildstep/blob/master/builder/config/buildpacks.txt) that are built-in and ready to be used.


## Building Buildstep

The buildstep script uses a buildstep base container that needs to be built. It must be created before
you can use the buildstep script. To create it, run:

    $ make build

This will create a container called `progrium/buildstep` that contains all supported buildpacks and the
builder script that will actually perform the build using the buildpacks.

## Building an App

Running the buildstep script will take an application tar via STDIN and an application container name as
an argument. It will put the application in a new container based on `progrium/buildstep` with the specified name.
Then it runs the builder script inside the container.

    $ cat myapp.tar | ./buildstep myapp

If you didn't already have an application tar, you can create one on the fly.

    $ tar cC /path/to/your/app . | ./buildstep myapp

The resulting container has a built app ready to go. The builder script also parses the Procfile and produces
a starter script that takes a process type. Run your app with:

    $ docker run -d myapp /bin/bash -c "/start web"

## Custom Buildpacks

Custom buildpacks can be installed by committing a file in the root of your git repository named `.env`
This file should contain a line `export BUILDPACK_URL=<repository>` specifying the git repository providing
the buildpack.

If your buildpack needs extra packages these can be installed by the buildpack using [bin/compile](https://devcenter.heroku.com/articles/buildpack-api#bin-compile).

## License

MIT
