# dotfiles

My config files under version control, with `make` targets to bootstrap them
on any machine. Configs live in this repo and are **symlinked** into place, so
editing the live config edits the repo copy — changes are always one
`git commit` away from being backed up.

## Bootstrap

```bash
git clone <this-repo> ~/dotfiles
cd ~/dotfiles
make all      # or a single component, e.g. `make nvim`
```

`make help` lists every available target.

Existing real (non-symlink) config directories are backed up in place with a
timestamped `.backup.*` suffix before being replaced, so bootstrapping is safe
to run on a machine that already has configs.

## Components

| Target | What it does |
| --- | --- |
| `make nvim` | Symlinks `nvim/` to `~/.config/nvim` (LazyVim config, plugin versions pinned via `lazy-lock.json`) |

## Structure

```
.
├── Makefile         # shared macros (symlink, backup, brew install, ...) + help
├── makefiles/       # one .mk module per tool, auto-included by the Makefile
│   ├── editors.mk   # nvim (more editors later)
│   └── targets.mk   # high-level bundles (`make all`)
└── nvim/            # Neovim configuration
```

## Adding a new component

1. Put the config files in a new top-level directory (or as a dotfile in the
   repo root).
2. Add a target in an existing module or a new `makefiles/<tool>.mk` — it is
   picked up automatically. Use `$(call symlink,...)` for single files and
   `$(call symlink_dir,...)` for whole directories.
3. Add the target to `all` in `makefiles/targets.mk` and document it above.

Planned: zsh, alacritty, Claude Code configs.
