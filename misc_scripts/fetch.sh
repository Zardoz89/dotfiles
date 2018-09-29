#!/bin/bash

fetch() {
  local dir=$1
  pushd "$dir" > /dev/null
  echo "Fetch on $dir"
  git fetch --prune
  popd > /dev/null
}

shopt -s dotglob
find * -prune -type d | while IFS= read -r dir; do 
  fetch $dir
done

