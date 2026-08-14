# Editor configuration setups

.PHONY: nvim
nvim: ## Setup Neovim: symlink nvim/ into XDG_CONFIG_HOME and install picker deps
	$(call mkdir_safe,$(XDG_CONFIG_HOME))
	$(call symlink_dir,nvim,$(XDG_CONFIG_HOME)/nvim)
	$(call install_with_brew,ripgrep)
	$(call install_with_brew,fd)
