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
| `make git` | Symlinks `base.gitconfig` to `~/.config/git/config` and `work.gitconfig` next to it |

### Git identity switching

`base.gitconfig` sets the personal identity (`alex.savchin@gmail.com`) as the
global default. Its final `includeIf "gitdir:~/salonized/"` section layers
`work.gitconfig` on top for any repo living under `~/salonized/`, overriding
the email to `oleksandr.savchyn@treatwell.com`. Nothing to configure per repo —
identity follows the repo's location on disk. Check with `git config user.email`
inside any repo. To add another work directory, add another `includeIf` block.

## Structure

```
.
├── Makefile           # shared macros (symlink, backup, brew install, ...) + help
├── makefiles/         # one .mk module per tool, auto-included by the Makefile
│   ├── editors.mk     # nvim (more editors later)
│   ├── gitconfigs.mk  # git identity + config
│   └── targets.mk     # high-level bundles (`make all`)
├── base.gitconfig     # global git config, personal identity by default
├── work.gitconfig     # work-email override for repos under ~/salonized/
└── nvim/              # Neovim configuration
```

## Adding a new component

1. Put the config files in a new top-level directory (or as a dotfile in the
   repo root).
2. Add a target in an existing module or a new `makefiles/<tool>.mk` — it is
   picked up automatically. Use `$(call symlink,...)` for single files and
   `$(call symlink_dir,...)` for whole directories.
3. Add the target to `all` in `makefiles/targets.mk` and document it above.

Planned: zsh, alacritty, Claude Code configs.
