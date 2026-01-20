get-password() {
  security find-generic-password -a "$USER" -s "$1" -w 2>/dev/null
}

