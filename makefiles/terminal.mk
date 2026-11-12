# Terminal tooling setups (emulator, agent multiplexer)

.PHONY: ghostty
ghostty: ## Setup Ghostty by symlinking ghostty/ into XDG_CONFIG_HOME
	$(call mkdir_safe,$(XDG_CONFIG_HOME))
	$(call symlink_dir,ghostty,$(XDG_CONFIG_HOME)/ghostty)

# Only config.toml is linked (not the directory) because herdr writes its logs
# into ~/.config/herdr/. Rerun after upgrading herdr: the Claude Code hook and
# skill are version-matched to the installed binary.
.PHONY: herdr
herdr: ## Setup herdr: install it and symlink its config and wire up the Claude Code hook and skill
	$(call install_with_brew,herdr)
	$(call mkdir_safe,$(XDG_CONFIG_HOME)/herdr)
	$(call symlink,herdr/config.toml,$(XDG_CONFIG_HOME)/herdr/config.toml)
	@if [ -d "$(HOME)/.claude" ]; then \
		$(call pretty_print,Installing herdr Claude Code hook and skill); \
		herdr integration install claude; \
		mkdir -p $(HOME)/.claude/skills/herdr; \
		herdr --skill > $(HOME)/.claude/skills/herdr/SKILL.md; \
	else \
		$(call pretty_print,Skipping Claude Code integration - run claude once then rerun make herdr); \
	fi
