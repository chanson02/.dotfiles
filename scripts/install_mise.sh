#!/bin/bash

set -e

PYTHON_VERSION="${PYTHON_VERSION:-3.12}"
RUBY_VERSION="${RUBY_VERSION:-3.3}"

mise use -g python@"$PYTHON_VERSION"
mise use -g ruby@"$RUBY_VERSION"

echo
echo "mise global runtimes:"
mise ls --global

# uv for Python virtualenv/package management on top of mise's Python
curl -LsSf https://astral.sh/uv/install.sh | sh
