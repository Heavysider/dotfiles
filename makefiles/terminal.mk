# Terminal tooling setups (emulator)

.PHONY: ghostty
ghostty: ## Setup Ghostty by symlinking ghostty/ into XDG_CONFIG_HOME
	$(call mkdir_safe,$(XDG_CONFIG_HOME))
	$(call symlink_dir,ghostty,$(XDG_CONFIG_HOME)/ghostty)
