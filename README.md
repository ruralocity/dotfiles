# Dotfiles

Personal dotfile management, using [chezmoi].

[chezmoi]:https://github.com/twpayne/chezmoi


## Setup

Install XCode ...

```
xcode-select --install
```

... then [Homebrew]:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Install `chezmoi`:

```
brew install chezmoi
```

Create `.config/chezmoi/chezmoi.toml`:

```toml
[data]
  name = "<your name>"
  email = "<email address>"
```

Initialize workstation to use chezmoi:

```
chezmoi init --apply ruralocity
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
