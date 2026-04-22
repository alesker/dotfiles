#!/usr/bin/env bash

target="/Applications/OpenCode.app/Contents/MacOS/opencode-cli"
link="/usr/local/bin/opencode"

if [ ! -x "$target" ]; then
  echo 'Missing target: %s' "$target" >&2
  exit 1
fi

sudo ln -sfn "$target" "$link"
