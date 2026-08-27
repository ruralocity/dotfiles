# Dotfiles

Personal dotfile management, using [chezmoi].

[chezmoi]:https://github.com/twpayne/chezmoi


## Setup

Clone this repo, then run `install.sh` from within it:

```
git clone https://github.com/ruralocity/dotfiles.git
cd dotfiles
./install.sh
```

It installs Xcode Command Line Tools (macOS only) and [Homebrew], runs `brew bundle` against
`Brewfile` (cross-platform CLI tools; also `Brewfile.mac` for casks/Mac App Store apps on macOS),
writes `~/.config/chezmoi/chezmoi.toml`, then runs `chezmoi init --apply` to lay down the rest of
the dotfiles.

By default it prompts for `NAME`, `EMAIL`, and `GITHUB_USERNAME`. To run it non-interactively (e.g.
a devcontainer `postCreateCommand`), export those three as env vars beforehand and the prompts are
skipped:

```
NAME="Your Name" EMAIL="you@example.com" GITHUB_USERNAME="ruralocity" ./install.sh
```

Recreate any machine-local secrets that live outside chezmoi's management, e.g. `~/.zshrc.local`
(sourced by `.zshrc` if present, holds `JIRA_PERSONAL_TOKEN` for the
`orm-claude-jira-ticket-manager` MCP server). These aren't tracked anywhere, so pull them from a
password manager or the previous machine.

[Homebrew]:https://brew.sh

## Common tasks

- Add a file to chezmoi: `$ chezmoi add ~/.bashrc`
- Edit a file: `$ chezmoi edit ~/.bashrc`
- View diff: `$ chezmoi diff`
- Apply changes: `$ chezmoi -v apply`
- commit changes:
  ```
  $ chezmoi cd
  $ <use git to add/commit/push>
  ```


## Things I haven't yet scripted

- SSH keys/setup (look into using 1Password for key management)
- Lots of app-specific configs
- Wondering, should I do some global Mise installs during setup?


## References

- [chezmoi quick start guide](https://www.chezmoi.io/quick-start/)
