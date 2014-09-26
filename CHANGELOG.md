# HEAD

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
