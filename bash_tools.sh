readonly BASH_TOOLS_ROOT="$( cd "$( dirname "$BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
bash_tools() {
  local script_name="$1"
  local script="$BASH_TOOLS_ROOT/bash_tools/$script_name"

  if [ -z "$1" ]; then
    echo "No script name provided. Usage: bash_tools {script_name}"
    $BASH_TOOLS_ROOT/bash_tools/ls
    return 1
  elif [ -x "$script" ]; then
    "$script" "${@:2}"
  else
    echo "Script $script_name not found. options are:"
    $BASH_TOOLS_ROOT/bash_tools/ls
    return 1
  fi
}
