#!/usr/bin/env bash

link="/usr/local/bin/system-appearance"

sudo tee "$link" >/dev/null <<'EOF'
#!/bin/sh

if defaults read -g AppleInterfaceStyle >/dev/null 2>&1; then
  echo "dark"
else
  echo "light"
fi
EOF

sudo chmod 755 "$link"

echo "Created $link"
