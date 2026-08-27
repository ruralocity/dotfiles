#!/bin/bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

# NAME/EMAIL/GITHUB_USERNAME can be pre-set as env vars (e.g. in a devcontainer
# postCreateCommand) to skip interactive prompts.
: "${NAME:=}"
: "${EMAIL:=}"
: "${GITHUB_USERNAME:=}"
[ -n "$NAME" ] || read -r -p "Enter your NAME: " NAME
[ -n "$EMAIL" ] || read -r -p "Enter your EMAIL: " EMAIL
[ -n "$GITHUB_USERNAME" ] || read -r -p "Enter your GITHUB_USERNAME: " GITHUB_USERNAME

if [ "$(uname -s)" = "Darwin" ]; then
  IS_MAC=1
  BREW_SHELLENV=/opt/homebrew/bin/brew
else
  IS_MAC=0
  BREW_SHELLENV=/home/linuxbrew/.linuxbrew/bin/brew
fi

if [ "$IS_MAC" = 1 ] && ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install

  until xcode-select -p &>/dev/null; do
    sleep 5
  done
fi

if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$("$BREW_SHELLENV" shellenv)"

echo "Installing CLI tools..."
brew bundle --file=Brewfile

if [ "$IS_MAC" = 1 ]; then
  echo "Installing Mac apps..."
  brew bundle --file=Brewfile.mac
fi

echo "Installing chezmoi dotfiles..."
mkdir -p ~/.config/chezmoi
cat <<EOL > ~/.config/chezmoi/chezmoi.toml
[data]
  name = "$NAME"
  email = "$EMAIL"
EOL

chezmoi init --apply "$GITHUB_USERNAME"

echo "Installing gh-cli extensions..."
gh extension install ruralocity/gh-clone-team-repos
