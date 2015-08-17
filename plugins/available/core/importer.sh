

# import tar and extract to /tmp/src
stdin:import() {
  cat | tar xC /tmp/src
}

dir:import() {
  cp -R /src/* /tmp/src/
}
