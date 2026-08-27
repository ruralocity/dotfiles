# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

The chezmoi **source directory** (`~/.local/share/chezmoi`, remote `ruralocity/dotfiles`) for a macOS
workstation. There is no build, no test suite, and no application code — every file here is either a
dotfile destined for `$HOME` or metadata that tells chezmoi how to place it.

## The source-state naming convention

Filenames in this repo are *encoded*. chezmoi decodes prefixes/suffixes to produce the target path and
its attributes. Never rename a file by hand to "fix" it — the name is the configuration:

| Source name | Target | Meaning |
| --- | --- | --- |
| `dot_zshrc` | `~/.zshrc` | `dot_` → leading `.` |
| `dot_config/starship.toml` | `~/.config/starship.toml` | applies recursively |
| `private_dot_gitconfig.tmpl` | `~/.gitconfig` | `private_` → mode 0600; `.tmpl` → rendered as a Go template |
| `executable_install` | `install` with `+x` | |
| `readonly_pack-*.pack` | mode 0444 | |

Because the encoding is recursive, vendored git checkouts under `dot_config/nvim/pack/` show up as
`dot_git/`, `dot_github/`, `dot_gitignore` — that is expected, not corruption.

## Templates and user data

`private_dot_gitconfig.tmpl` is the only template. It interpolates `{{ .name }}` / `{{ .email }}`, which
come from `~/.config/chezmoi/chezmoi.toml` (`[data]` block, **not** in this repo), and
`{{ .chezmoi.homeDir }}` from chezmoi's built-in data. Adding a new template variable means also
documenting it in README.md's setup section, since a fresh machine must create that toml by hand before
`chezmoi init --apply ruralocity` works.

## Workflow for changes

Edit the source files here directly, then:

```sh
chezmoi diff          # preview what would change in $HOME
chezmoi -v apply      # write the changes out
chezmoi execute-template < private_dot_gitconfig.tmpl   # render a template to check it
chezmoi verify        # exit non-zero if $HOME has drifted from source state
```

To capture a file that was edited in `$HOME` instead: `chezmoi add ~/.foo` (or `chezmoi re-add` to
refresh already-managed files). `chezmoi cd` opens a shell in this directory for the git commit.

Note that `chezmoi apply` writes to the real home directory — treat it like a deploy, and run
`chezmoi diff` first.

## `.chezmoiignore`

Files listed there stay in the repo but are never written to `$HOME`. Repo-meta files (`README.md`,
`CLAUDE.md`) belong in it. Anything else added at the top level *will* land in `$HOME` — that is
intentional for `Brewfile` (→ `~/Brewfile`, so `brew bundle` works from home).

## Brewfile

`Brewfile` is grouped by purpose with comments (core utilities, build tools, CLI improvements,
development tools, Mac apps, misc). Keep new entries in the matching group. It mixes `brew`, `cask`, and
`mas` (Mac App Store, which needs the numeric app id). Apply it with `brew bundle --file=~/Brewfile`.
Adding a tool here usually pairs with a config change — e.g. `starship`/`less`/`fzf`/`mise` in the
Brewfile each have corresponding setup in `dot_zshrc`.

## Neovim

`dot_config/nvim/init.vim` uses **minpac** (packages under `dot_config/nvim/pack/`). Plugins are
committed into this repo as full checkouts rather than fetched at apply time, so adding a plugin means
vendoring it — expect large diffs and the `dot_git/` encoding described above.

## AI tool configs (`dot_claude/`, `dot_config/opencode/`)

Only hand-maintained config is tracked; the surrounding state directories are deliberately unmanaged.
Do **not** add these to the source state:

- `~/.claude/.credentials.json`, `.claude.json` — auth tokens and per-project history
- `~/.claude/{history.jsonl,sessions,projects,file-history,shell-snapshots,plugins,cache}` — machine state
- `~/.claude/settings.local.json` — machine-local by design, and already covered by `dot_gitignore_global`
- `~/.opencode/`, and `node_modules/`+`package*.json` under `~/.config/opencode` — installed artifacts
  (opencode's own `.gitignore` there lists the latter)

`dot_claude/settings.json.tmpl` is a template only so the `statusLine` command can use
`{{ .chezmoi.homeDir }}` instead of a hardcoded `/Users/...` path. Two consequences: edit the `.tmpl`
directly rather than `chezmoi add`-ing the target back over it, and re-render it after changes with
`chezmoi execute-template < dot_claude/settings.json.tmpl | jq .` to confirm it is still valid JSON.

Claude Code writes a generated `autoMode.environment` block into `~/.claude/settings.json` describing
the current project. It is intentionally **not** in the tracked copy — leave it out when updating, or
`chezmoi status` will report drift every time it is regenerated.

The opencode config references `./plugins/caveman/plugin.js`, which is *not* tracked (third-party,
reinstallable). A fresh machine will need caveman reinstalled or that `plugin` key removed.
