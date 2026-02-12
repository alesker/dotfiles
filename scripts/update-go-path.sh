#!/usr/bin/env bash

SCRIPT="$(basename "$0")"

help() {
  cat <<EOF
Usage:
  $SCRIPT <command>

Commands:
  hide        Make Go dir hidden
  restore     Restore default Go dir

Options:
  -h, --help  Show this help message

Examples:
  $SCRIPT hide
  $SCRIPT restore
EOF
}

move_go() {
  OLD_PATH=$1
  NEW_PATH=$2

  if [ -d "$OLD_PATH" ] && [ ! -d "$NEW_PATH" ]; then
    echo "Moving $OLD_PATH to $NEW_PATH"
    mv "$OLD_PATH" "$NEW_PATH"
  fi

  go env -w GOPATH="$NEW_PATH"
  echo "GOPATH is now $NEW_PATH"
}

cmd_hide() {
  move_go "$HOME/go" "$HOME/.go"
}

cmd_restore() {
  move_go "$HOME/.go" "$HOME/go"
}

case "${1:-}" in
-h | --help)
  help
  exit 0
  ;;
hide)
  shift
  cmd_hide "$@"
  ;;
restore)
  shift
  cmd_restore "$@"
  ;;
"")
  echo "Error: no command provided" >&2
  help
  exit 1
  ;;
*)
  echo "Error: unknown command '$1'" >&2
  help
  exit 1
  ;;
esac
