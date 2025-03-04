# Dotfiles

Personal dotfile management, using [chezmoi].

[chezmoi]:https://github.com/twpayne/chezmoi


## Setup

Install [Homebrew]:

```
xcode-select --install
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
chezmoi init git@github.com:ruralocity/dotfiles.git
```

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


## References

- [chezmoi quick start guide](https://www.chezmoi.io/quick-start/)
