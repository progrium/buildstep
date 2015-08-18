
# stdout:export-file() {
#   tar cC /tmp/artifact
# }

dir:export-file() {
  cp /tmp/artifact /build
}

stdout:export-file() {
  < /tmp/artifact
}

stdout:export-image() {
  docker export $BUILDKIT_TAG
}
