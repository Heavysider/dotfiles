# Git configuration setup

.PHONY: git
git: ## Setup git config (personal identity, work overrides under ~/salonized/)
	$(call mkdir_safe,$(XDG_CONFIG_HOME)/git)
	$(call symlink,base.gitconfig,$(XDG_CONFIG_HOME)/git/config)
	$(call symlink,work.gitconfig,$(XDG_CONFIG_HOME)/git/work.gitconfig)
