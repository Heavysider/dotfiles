# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles, bootstrapped by symlinking configs from this repo into place (`~/.config/...`, `~/`). Because everything is symlinked, editing a live config on the machine edits the repo copy directly — check `git status` before assuming the working tree is clean, and remember that changes made here take effect immediately in the running tools.

## Commands

- `make help` — list all targets (auto-generated from `##` comments on target lines)
- `make all` — bootstrap everything
- `make <tool>` — bootstrap one component: `nvim`, `git`, `zellij`, `zsh`, `alacritty`, `mise`

There are no tests or linters at the repo level. Neovim Lua is formatted per `nvim/stylua.toml` (2-space indent, 120 columns).

## Architecture

- **Makefile** defines shared macros only: `symlink` (single file), `symlink_dir` (directory, backs up a pre-existing real directory with a timestamped `.backup.*` suffix first), `mkdir_safe`, `install_with_brew`, `pretty_print` (single-quoted — no `'` or `,` in messages).
- **makefiles/*.mk** — one module per tool, auto-included via `$(wildcard makefiles/*.mk)`. A new `.mk` file needs no Makefile edit; its `##`-annotated targets appear in `make help` automatically. `makefiles/targets.mk` holds the `all` bundle.
- **Adding a component**: put configs in a top-level directory (or root dotfile), add a target using the macros in an existing or new `.mk` module, add it to `all` in `targets.mk`, and document it in the README's components table.

## Non-obvious details

- **Git identity switching**: `base.gitconfig` sets the personal identity (alex.savchin@gmail.com) globally; its `includeIf "gitdir:~/salonized/"` layers `work.gitconfig` on top (work email) for repos under `~/salonized/`. To add another work directory, add another `includeIf` block.
- **Neovim** is LazyVim with plugin versions pinned in `nvim/lazy-lock.json` and extras declared in `nvim/lazyvim.json` (telescope, ruby). Ruby LSP deliberately uses the gem-installed `ruby-lsp` from mise's Ruby (`mason = false`) and disables the standalone rubocop client — RuboCop runs through ruby-lsp inside the project bundle. Don't "fix" these back to Mason defaults. Because the server comes from the active Ruby's gems, a Ruby upgrade in a project leaves it without `ruby-lsp` — `.default-gems` (symlinked to `~/.default-gems` by `make mise`) makes mise install it into every new Ruby; an already-installed Ruby needs a one-off `mise exec -- gem install ruby-lsp`.
- **Zellij** config unbinds Ctrl+h so it doesn't shadow Neovim window navigation.

## Commit conventions

- Do not add the `Co-Authored-By: Claude` trailer to commits in this repo.
