# Terminal tooling setups (multiplexer, emulator, ...)

.PHONY: zellij
zellij: ## Setup Zellij by symlinking zellij/ into XDG_CONFIG_HOME
	$(call mkdir_safe,$(XDG_CONFIG_HOME))
	$(call symlink_dir,zellij,$(XDG_CONFIG_HOME)/zellij)
