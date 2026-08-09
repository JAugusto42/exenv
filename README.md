# exenv - Simple Elixir Version Manager

`exenv` is a version manager for Elixir, inspired by tools like `rbenv` and `pyenv`. It allows you to easily install and switch between different versions of Elixir.

## Requirements

`exenv` installs Elixir using the official prebuilt OTP bundles from the Elixir releases. This means you do not need Erlang/OTP installed before using `install`.

Minimum requirements:
- `curl` or `wget`
- `unzip`
- `erlang` / `erl`

On most systems, `curl` and `unzip` are already available by default. Elixir release archives are built against a specific OTP version, but they do not include the Erlang runtime itself. You still need Erlang/OTP installed and available on `PATH`.

If you do not have these tools installed, use your system package manager to install them.

#### macOS (using Homebrew)

```bash
brew install curl unzip
```

#### Ubuntu/Debian (APT)

```bash
sudo apt-get update
sudo apt-get install curl unzip
```

#### Arch Linux (Pacman)

```bash
sudo pacman -S curl unzip
```

_O `exenv` agora busca automaticamente o arquivo `elixir-otp-XX.zip` correto para a versão solicitada._

## Installation

1. Install via Curl

    ```bash
    curl -fsSL https://raw.githubusercontent.com/JAugusto42/exenv/main/install.sh | bash
    ```

### Or install by cloning the repo:

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/JAugusto42/exenv.git
    ```

2.  **Run the installer:**

    ```bash
    cd exenv
    ./install.sh
    ```

3.  **Configure your Shell:**
    Add the following line to your shell configuration file (`~/.bashrc` or `~/.zshrc`):

    ```bash
    eval "$("$HOME/.exenv/bin/exenv" init -)"
    ```

4.  **Restart your terminal** for the changes to take effect.
    ```bash
    source ~/.zshrc # or source ~/.bashrc
    ```

## Usage

### Version installation

| Command | Description |
| --- | --- |
| `exenv install <version>` | Installs a specific Elixir version using a prebuilt OTP bundle with Erlang/OTP included. Does not set the active version. |
| `exenv install --list` | Lists available remote Elixir versions from GitHub tags. |
| `exenv list-remote` | Same as `install --list`: lists available remote versions. |

### Version selection

| Command | Description |
| --- | --- |
| `exenv global <version>` | Sets the global Elixir version in `${EXENV_ROOT}/version`. |
| `exenv local <version>` | Sets the local project version in `.elixir-version` in the current directory. |
| `exenv version` | Shows the currently active Elixir version, resolving local first and global second. |
| `exenv versions` | Lists installed Elixir versions in `${EXENV_ROOT}/versions`. |

### Management

| Command | Description |
| --- | --- |
| `exenv uninstall <version>` | Removes an installed version and rebuilds shims. |
| `exenv rehash` | Rebuilds shim scripts from installed versions. Use after manual version directory changes. |

### Execution and diagnostics

| Command | Description |
| --- | --- |
| `exenv exec <command> [args]` | Runs a command from the active version without relying on the shim. |
| `exenv which <command>` | Prints the actual executable path for the active version. |

### Command details

- `exenv install <version>`
  - Downloads the correct `elixir-otp-XX.zip` archive for the requested version.
  - Unpacks it into `~/.exenv/versions/<version>`.
  - Automatically rebuilds shims after installation.
  - Requires Erlang/OTP to be installed and available on `PATH`.
  - Does not activate the version. Use `exenv global <version>` or `exenv local <version>` after install.

- `exenv install --list` / `exenv list-remote`
  - Queries GitHub tags for available Elixir versions.
  - Use this to discover exact version strings before installing.

- `exenv versions`
  - Shows all versions currently installed under `~/.exenv/versions`.

- `exenv global <version>`
  - Sets the default Elixir version for all shells.
  - It writes the version string to `~/.exenv/version`.

- `exenv local <version>`
  - Creates a `.elixir-version` file in the current working directory.
  - `exenv` resolves this file by searching parent directories, so project subfolders inherit the version.

- `exenv uninstall <version>`
  - Deletes the installed version directory and rebuilds shims.
  - Use this to clean up versions you no longer need.

- `exenv version`
  - Prints the active version, preferring a local `.elixir-version` file and falling back to the global version.

- `exenv which <command>`
  - Prints the full path to a command executable under the active version's `bin/` directory.
  - Useful for debugging `PATH` or checking which Elixir executable is being used.

- `exenv rehash`
  - Rebuilds shim scripts in `~/.exenv/shims`.
  - This is normally automatic after `install` and `uninstall`, but useful if you manually change version directories.

- `exenv exec <command> [args]`
  - Executes the named command from the active Elixir version directory.
  - Useful when calling commands directly from `exenv` without relying on shell shims.

### Examples

Install a specific version:
```bash
exenv install 1.20.3
```

List remote versions:
```bash
exenv install --list
```

or:
```bash
exenv list-remote
```

Set the global version:
```bash
exenv global 1.20.3
```

Set a local project version:
```bash
cd /path/to/your/project
exenv local 1.20.3
```

Show the currently active version:
```bash
exenv version
```

Show the path to the active `elixir` executable:
```bash
exenv which elixir
```

Run a command directly with the active version:
```bash
exenv exec elixir -v
```

Remove an installed version:
```bash
exenv uninstall 1.20.3
```

Rebuild shims manually:
```bash
exenv rehash
```

## Release Notes

### Implemented in this version

- `exenv install <version>` installs prebuilt Elixir OTP bundles automatically.
- `exenv install --list` and `exenv list-remote` show available remote versions.
- `exenv uninstall <version>` removes an installed version and rebuilds shims.
- `exenv which <command>` shows the command path for the active version.
- `exenv version` shows the currently active version using local or global config.
- `exenv local <version>` resolves `.elixir-version` by searching parent directories.
- Updated documentation to reflect self-contained OTP bundle installs.
