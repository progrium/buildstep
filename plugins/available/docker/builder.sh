
# Check if Dockerfile exists
docker:detect-build() {
  if [ -f $1/Dockerfile ]; then
    return 0
  fi
  return 1
}

docker:build-image() {
  declare path="$1" tag="${2?BUILDKIT_TAG not set}"
  cd $path; docker build -t $tag .
}
