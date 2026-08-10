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

# Ensure the installed libexec script is executable
chmod +x "${INSTALL_DIR}/libexec/exenv" || true

# Rebuild shims and perform a simple post-install validation
"${INSTALL_DIR}/bin/exenv" rehash || true

# Try to initialize exenv in this shell and run a lightweight validation
if eval "\$(${INSTALL_DIR}/bin/exenv init -)" 2>/dev/null; then
	if command -v elixir >/dev/null 2>&1; then
		echo "Post-install check: 'elixir' is available in PATH. Running 'elixir -v'..."
		if elixir -v >/dev/null 2>&1; then
			elixir -v
		else
			echo "Warning: 'elixir' command exists but 'elixir -v' failed. Ensure Erlang/OTP is installed and available to exenv."
		fi
	else
		echo "Post-install check: 'elixir' not found in PATH. You may need to open a new shell or add eval \"\$(${INSTALL_DIR}/bin/exenv init -)\" to your shell config."
	fi
else
	echo "Warning: could not source exenv init; skipping post-install validation."
fi

echo
echo "Installation completed successfully!"
echo
echo 'Add the following line to your shell configuration file:'
echo
echo 'eval "$("$HOME/.exenv/bin/exenv" init -)"'
echo
echo 'Then restart your terminal or source your shell config file to activate exenv.'
