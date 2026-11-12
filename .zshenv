. "$HOME/.cargo/env"

# mise shims ahead of Homebrew, so shells without `mise activate` (git hooks,
# editors, agents) still get the .tool-versions node/pnpm/ruby
export PATH="$HOME/.local/share/mise/shims:$PATH"
