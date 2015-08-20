
dir:export-file() {
  local file="${BUILDKIT_FILE?not set}"
  cp /tmp/artifact "/build/$file"
}

dir:export-image() {
  local file="${BUILDKIT_FILE?not set}"
  docker save $BUILDKIT_TAG > "/build/$file"
}

stdout:export-file() {
  cat /tmp/artifact
}

stdout:export-image() {
  docker save $BUILDKIT_TAG
}
