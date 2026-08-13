# Shell configuration setups

.PHONY: zsh
zsh: ## Setup zsh config and install oh-my-zsh if missing
	$(call symlink,.zshrc,$(HOME)/.zshrc)
	$(call symlink,.zshenv,$(HOME)/.zshenv)
	@if [ ! -d "$(HOME)/.oh-my-zsh" ]; then \
		$(call pretty_print,Cloning oh-my-zsh...); \
		git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git $(HOME)/.oh-my-zsh; \
	fi
