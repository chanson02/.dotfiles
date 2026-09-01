#!/bin/bash

set -e

PYTHON_VERSION="${PYTHON_VERSION:-3.12}"
RUBY_VERSION="${RUBY_VERSION:-3.3}"

mise use -g python@"$PYTHON_VERSION"

if command -v ruby >/dev/null 2>&1 || [ -n "$RUBY_VERSION" ]; then
  mise use -g ruby@"$RUBY_VERSION"
fi

echo
echo "mise runtimes:"
mise ls
