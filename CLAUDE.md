# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles, bootstrapped by symlinking configs from this repo into place (`~/.config/...`, `~/`). Because everything is symlinked, editing a live config on the machine edits the repo copy directly — check `git status` before assuming the working tree is clean, and remember that changes made here take effect immediately in the running tools.

## Commands

- `make help` — list all targets (auto-generated from `##` comments on target lines)
- `make all` — bootstrap everything
- `make <tool>` — bootstrap one component: `nvim`, `git`, `zsh`, `ghostty`, `herdr`, `mise`

There are no tests or linters at the repo level. Neovim Lua is formatted per `nvim/stylua.toml` (2-space indent, 120 columns).

## Architecture

- **Makefile** defines shared macros only: `symlink` (single file), `symlink_dir` (directory, backs up a pre-existing real directory with a timestamped `.backup.*` suffix first), `mkdir_safe`, `install_with_brew`, `pretty_print` (single-quoted — no `'` or `,` in messages).
- **makefiles/*.mk** — one module per tool, auto-included via `$(wildcard makefiles/*.mk)`. A new `.mk` file needs no Makefile edit; its `##`-annotated targets appear in `make help` automatically. `makefiles/targets.mk` holds the `all` bundle.
- **Adding a component**: put configs in a top-level directory (or root dotfile), add a target using the macros in an existing or new `.mk` module, add it to `all` in `targets.mk`, and document it in the README's components table.

## Non-obvious details

- **Git identity switching**: `base.gitconfig` sets the personal identity (alex.savchin@gmail.com) globally; its `includeIf "gitdir:~/salonized/"` layers `work.gitconfig` on top (work email) for repos under `~/salonized/`. To add another work directory, add another `includeIf` block.
- **Neovim** is LazyVim with plugin versions pinned in `nvim/lazy-lock.json` and extras declared in `nvim/lazyvim.json` (telescope, ruby). Ruby LSP deliberately uses the gem-installed `ruby-lsp` from mise's Ruby (`mason = false`) and disables the standalone rubocop client — RuboCop runs through ruby-lsp inside the project bundle. Don't "fix" these back to Mason defaults. Its `root_markers` put `Gemfile.lock` before `Gemfile` so monorepo components (salonized `components/*`, which have a Gemfile but a gitignored lockfile) resolve to the repo root instead of a lockless dir where ruby-lsp exits. Because the server comes from the active Ruby's gems, a Ruby upgrade in a project leaves it without `ruby-lsp` — `.default-gems` (symlinked to `~/.default-gems` by `make mise`) makes mise install it into every new Ruby; an already-installed Ruby needs a one-off `mise exec -- gem install ruby-lsp`.
- **Ghostty** reads `~/.config/ghostty/config.ghostty` (symlinked from the repo). It also loads `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty` if present, which would override the repo copy, so keep that file absent.
- **herdr** links only `config.toml`, not the directory, because herdr writes its logs into `~/.config/herdr/`. `make herdr` also runs `herdr integration install claude` (a `SessionStart` hook in `~/.claude/settings.json`) and writes `herdr --skill` to `~/.claude/skills/herdr/SKILL.md`; both are tied to the installed herdr version, so rerun the target after upgrading.
- **Images inside herdr**: herdr panes report `TERM_PROGRAM=herdr`, so Claude Code won't send terminal images there even though herdr forwards kitty graphics to Ghostty. `.zshrc` sets `CLAUDE_CODE_FORCE_TERMINAL_IMAGES=1` only when `HERDR_ENV=1`. It is required (tested: the pokemon plugin falls back to half blocks without it), and the plugin also needs a one-off `/pokemon images on` since it has its own terminal-name check.
