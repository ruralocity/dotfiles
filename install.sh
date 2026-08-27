#!/bin/bash

read -p "Enter your NAME: " NAME
read -p "Enter your EMAIL: " EMAIL
read -p "Enter your GITHUB_USERNAME: " GITHUB_USERNAME

echo "Installing Xcode Command Line Tools..."
xcode-select --install

until xcode-select -p &>/dev/null; do
  sleep 5
done

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle

echo "Installing chezmoi..."
brew install chezmoi

mkdir -p ~/.config/chezmoi
cat <<EOL > ~/.config/chezmoi/chezmoi.toml
[data]
  name = "$NAME"
  email = "$EMAIL"
EOL

chezmoi init --apply "$GITHUB_USERNAME"

echo "Installing gh-cli extensions..."
gh extension install ruralocity/gh-clone-team-repos

echo "Installing Aider..."
curl -LsSf https://aider.chat/install.sh | sh
