#!/usr/bin/env bash

set -e

INSTALL_DIR="${HOME}/.exenv"

echo "Installing exenv in ${INSTALL_DIR}..."

mkdir -p "${INSTALL_DIR}/bin"
mkdir -p "${INSTALL_DIR}/libexec"
mkdir -p "${INSTALL_DIR}/shims"
mkdir -p "${INSTALL_DIR}/versions"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cp "${script_dir}/bin/exenv" "${INSTALL_DIR}/bin/"
cp "${script_dir}/libexec/exenv" "${INSTALL_DIR}/libexec/"

echo
echo "Installation completed successfully!"
echo
echo 'Add the following line to your shell configuration file:'
echo
echo 'eval "$(exenv init -)"'
echo
echo 'Then restart your terminal or source your shell config file to activate exenv.'
