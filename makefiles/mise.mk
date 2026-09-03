# Runtime version manager (mise) setup

.PHONY: mise
mise: ## Setup mise: symlink .default-gems so every newly installed Ruby gets ruby-lsp
	$(call symlink,.default-gems,$(HOME)/.default-gems)
