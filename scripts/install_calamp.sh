#!/bin/bash

set -e

calamp="$HOME/Documents/CalAmp"
mkdir -p "$calamp"

cat > "$calamp/.nvim.lua" <<'EOF'
vim.fn.setenv("OPENCODE_MODELS_PATH", vim.fn.expand("~") .. "/.config/opencode/models-kiro.json")
EOF
