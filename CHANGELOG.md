# HEAD

## Removed buildpacks

The following buildpacks have been removed from the default image.
They can be installed using the custom buildpack feature. To use one
please commit a file in the root of your git repository named `.env`
containing `export BUILDPACK_URL=<repository>`.

  * Metorite - `https://github.com/oortcloud/heroku-buildpack-meteorite.git`
  * Perl - `https://github.com/miyagawa/heroku-buildpack-perl.git`
  * Dart - `https://github.com/igrigorik/heroku-buildpack-dart.git`
  * NGINX - `https://github.com/rhy-jot/buildpack-nginx.git`
  * Apache - `https://github.com/Kloadut/heroku-buildpack-static-apache.git`
  * Jekyll - `https://github.com/bacongobbler/heroku-buildpack-jekyll.git`

## Removed packages

  * Java
  * NodeJS
  * SQLite
  * MySQL client
  * PostgreSQL client
  * mercurial

If you need a JDK present during builds, use [buildpack-multi](https://github.com/ddollar/heroku-buildpack-multi) and check the
Heroku [migration instructions](https://devcenter.heroku.com/articles/cedar-14-migration#java-on-stack-image).

SQLite doesn't work well on ephemeral filesystems and shouldn't be use in a container. Your data would be lost on deploys/rebuilds.

Mercurial and NodeJS will be installed by the buildpacks should they require it.
