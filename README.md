# exenv - Simple Elixir Version Manager

`exenv` is a version manager for Elixir, inspired by tools like `rbenv` and `pyenv`. It allows you to easily install and switch between different versions of Elixir.

## Requirements

Elixir requires an active Erlang/OTP installation to run.

`exenv` manages Elixir versions, but it **does not** install Erlang for you. You must install Erlang on your system separately before using any Elixir version.

You can install Erlang using your system's package manager.

#### macOS (using Homebrew)

```bash
brew install erlang
```

### Arch Linux (using Pacman)

```bash
sudo pacman -S erlang
```

#### Ubuntu/Debian (using APT)

```bash
sudo apt-get update
sudo apt-get install erlang
```

_For other systems, please use your respective package manager to install the `erlang` package._

## Installation

1.  **Clone the repository:**
    Replace `YOUR_USERNAME` with your actual GitHub username.

    ```bash
    git clone [https://github.com/YOUR_USERNAME/exenv.git](https://github.com/YOUR_USERNAME/exenv.git)
    ```

2.  **Run the installer:**

    ```bash
    cd exenv
    ./install.sh
    ```

3.  **Configure your Shell:**
    Add the following lines to your shell configuration file (`~/.bashrc` or `~/.zshrc`):

    ```bash
    export EXENV_ROOT="$HOME/.exenv"
    export PATH="$EXENV_ROOT/bin:$PATH"
    export PATH="$EXENV_ROOT/shims:$PATH"
    ```

4.  **Restart your terminal** for the changes to take effect.

## Usage

- **Install a version:**

  ```bash
  exenv install 1.17.2
  ```

- **List installed versions:**

  ```bash
  exenv versions
  ```

- **Set the global version:**
  This version will be used by default in any shell.

  ```bash
  exenv global 1.17.2
  ```

- **Set a local version (for a project):**
  This will create a `.elixir-version` file in your current directory. This version will be automatically used whenever you are inside this directory.
  ```bash
  cd /path/to/your/project
  exenv local 1.16.3
  ```
