# List available commands when no command provided
@default:
  just --list

# Install remaining tooling
@finish-setup:
  curl -LsSf https://aider.chat/install.sh | sh
  gh extension install ruralocity/gh-clone-team-repos

# Update tooling
@update:
  brew bundle
  gh extension upgrade --all
