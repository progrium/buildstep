

# Import tar from stdin
stdin:import() {
  cat | tar xC /tmp/src
}

dir:import() {
  cp -R /src/* /tmp/src/
}
