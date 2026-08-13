# Editor configuration setups

.PHONY: nvim
nvim: ## Setup Neovim by symlinking nvim/ into XDG_CONFIG_HOME
	$(call mkdir_safe,$(XDG_CONFIG_HOME))
	$(call symlink_dir,nvim,$(XDG_CONFIG_HOME)/nvim)
