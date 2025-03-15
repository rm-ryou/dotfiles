SRC_CONFIG_DIR := $(CURDIR)/config
DIST_CONFIG_DIR := $(XDG_CONFIG_HOME)

HOME_SRCS := zshenv
CONFIG_SRCS := $(notdir $(wildcard $(SRC_CONFIG_DIR)/*))

.PHONY: all
all: help

.PHONY: install
install: links_to_home links_to_config
	@echo "Dotfiles setup complete!!"

.PHONY: links_to_home
links_to_home:
	@echo "Creating symlinks for HOME files..."
	@$(foreach file, $(HOME_SRCS), ln -sfn $(CURDIR)/$(file) $(HOME)/.$(file);)

.PHONY: links_to_config
links_to_config:
	@echo "Creating symlinks for config items..."
	@mkdir -p $(DIST_CONFIG_DIR)
	@$(foreach srcs, $(CONFIG_SRCS), ln -sfn $(SRC_CONFIG_DIR)/$(srcs) $(DIST_CONFIG_DIR)/$(srcs);)

.PHONY: clean
clean:
	@echo "Removing symlinks..."
	@$(foreach file, $(HOME_SRCS), rm -f $(HOME)/.$(file);)
	@$(foreach srcs, $(CONFIG_SRCS), rm -f $(DIST_CONFIG_DIR)/$(srcs);)

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  install        - Create symlinks for dotfiles."
	@echo "  clean          - Remove created symlinks."
	@echo "  help           - Show this help message."
