opencode() {
  if [[ "$PWD" == "$HOME/Documents/CalAmp" || "$PWD" == "$HOME/Documents/CalAmp"/* ]]; then
    OPENCODE_MODELS_PATH="$HOME/.config/opencode/models-kiro.json" command opencode "$@"
  else
    command opencode "$@"
  fi
}
