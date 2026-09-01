#!/bin/bash

set -e

# Omarchy ships with mise pre-installed. It reads .ruby-version /
# .python-version / .tool-versions files natively, so a language version is
# installed automatically the first time you enter a project that requests it
# (mise use --activate or the version file).
#
# This script only sets your global default Python. Ruby and other runtimes
# are pulled in on-demand from each project's version file.
#
# Use uv on top for Python venv/package management: uv venv && uv pip install ...

PYTHON_VERSION="${PYTHON_VERSION:-3.12}"

echo "Setting global default Python $PYTHON_VERSION via mise ..."
mise use -g python@"$PYTHON_VERSION"

echo
echo "mise global runtimes:"
mise ls --global
