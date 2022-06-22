# Dotfiles

Personal dotfile management, using [chezmoi].

[chezmoi]:https://github.com/twpayne/chezmoi


## Setup

Assumes Homebrew is already installed on the workstation.

Install `chezmoi`:

```
brew install chezmoi
```

Create `.config/chezmoi/chezmoi.toml`:

```toml
[data]
  email = "<email address>"
```

Initialize workstation to use chezmoi:

```
chezmoi init git@github.com:ruralocity/dotfiles.git
```


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
