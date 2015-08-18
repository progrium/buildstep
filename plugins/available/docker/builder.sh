
# detect dockerfile
docker:detect-build() {
  [[ -f /tmp/src/Dockerfile ]]
}

docker:build-image() {
  declare tag="${BUILDKIT_TAG?not set}"
  docker build -t $tag /tmp/src
}
