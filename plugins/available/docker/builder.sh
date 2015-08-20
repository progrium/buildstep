
# detect dockerfile
dockerfile:detect-build() {
  [[ -f /tmp/src/Dockerfile ]]
}

dockerfile:build-image() {
  local tag="${BUILDKIT_TAG?not set}"
  docker build -t $tag /tmp/src | output_redirect
}

dockerfile:build-file() {
  local ID=$(uuidgen)
  docker build -t $ID /tmp/src && docker save $ID > /tmp/artifact
}
