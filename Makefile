# Bootstraps my development environment by symlinking config files from this
# repository into their expected locations. Each tool gets its own module in
# makefiles/, which is picked up automatically — add a new .mk file and its
# targets appear in `make help`.

DOTFILES := $(shell pwd)
UNAME := $(shell uname)
XDG_CONFIG_HOME ?= $(HOME)/.config
BACKUP_SUFFIX := backup.$(shell date +%Y%m%d%H%M%S)

# Reusable macros for common operations

# Symlink a file: $(call symlink,<repo-relative-source>,<absolute-target>)
define symlink
	@$(call pretty_print,Linking $(1) -> $(2))
	@ln -fs $(DOTFILES)/$(1) $(2)
endef

# Symlink a whole directory, backing up any pre-existing real directory first:
# $(call symlink_dir,<repo-relative-source>,<absolute-target>)
define symlink_dir
	@if [ -e "$(2)" ] && [ ! -L "$(2)" ]; then \
		$(call pretty_print,Backing up existing $(2) -> $(2).$(BACKUP_SUFFIX)); \
		mv "$(2)" "$(2).$(BACKUP_SUFFIX)"; \
	fi
	@$(call pretty_print,Linking $(1) -> $(2))
	@ln -sfn $(DOTFILES)/$(1) $(2)
endef

define mkdir_safe
	@mkdir -p $(1)
endef

# Install a package with Homebrew if it is not already installed
define install_with_brew
	@brew list $(1) &>/dev/null || (echo "Installing $(1)" && brew install $(1))
endef

# Print in green so bootstrap output stands out from command noise.
# Messages are single-quoted, so avoid ' and , in them.
define pretty_print
	printf '\033[0;32m%s\033[0m\n' '$(1)'
endef

# Auto-include every module so new ones need no Makefile edit
include $(wildcard makefiles/*.mk)

.DEFAULT_GOAL := help

.PHONY: help
help: ## Display all available targets
	@echo "Available targets:"
	@awk 'BEGIN {FS = ":.*?##"} /^[a-zA-Z0-9_-]+:.*?##/ {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' Makefile makefiles/*.mk | sort
