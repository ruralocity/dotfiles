# List available commands when no command provided
@default:
  just --list

# Install remaining tooling
@finish-setup:
  gh extension install ruralocity/gh-clone-team-repos

# Update tooling
@update:
  brew bundle
  [ "$(uname -s)" = "Darwin" ] && brew bundle --file=Brewfile.mac || true
  gh extension upgrade --all
