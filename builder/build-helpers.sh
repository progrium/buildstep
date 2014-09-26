#!/bin/bash
function echo_title() {
  echo $'\e[1G----->' $*
}

function echo_normal() {
  echo $'\e[1G      ' $*
}

function ensure_indent() {
  while read line; do
    if [[ "$line" == --* ]]; then
      echo $'\e[1G'$line
    else
      echo $'\e[1G      ' "$line"
    fi
  done
}
