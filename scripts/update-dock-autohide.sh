#!/usr/bin/env bash

SCRIPT="$(basename "$0")"

help() {
  cat <<EOF
Usage:
  $SCRIPT <command>

Commands:
  update      Update something
  restore     Restore something

Options:
  -h, --help  Show this help message

Examples:
  $SCRIPT update
  $SCRIPT restore
EOF
}

cmd_update() {
  defaults write com.apple.dock autohide-delay -int 0
  killall Dock

  echo "Updated Dock autohide-delay"
}

cmd_restore() {
  defaults delete com.apple.dock autohide-delay
  killall Dock

  echo "Restored Dock autohide-delay"
}

case "${1:-}" in
-h | --help)
  help
  exit 0
  ;;
update)
  shift
  cmd_update "$@"
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
