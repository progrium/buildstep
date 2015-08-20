

# import tar and extract to /tmp/src
stdin:import() {
  tar xf - -C /tmp/src
}

# copy /src to /tmp/src
dir:import() {
  cp -R /src/* /tmp/src/
}
