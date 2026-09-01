# let opencode use same lsps as neovim
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

opencode() {
  if [[ "$PWD" == "$HOME/Documents/CalAmp" || "$PWD" == "$HOME/Documents/CalAmp"/* ]]; then
    OPENCODE_MODELS_PATH="$HOME/.config/opencode/models-kiro.json" command opencode "$@"
  else
    command opencode "$@"
  fi
}
