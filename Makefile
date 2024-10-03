# MakeSilicon Makefile

# Include configuration file
include config.mk

# Default directories to create (space-separated)
DEFAULT_DIRS := src sim synth docs scripts testbench constraints lib mem logs results

# Determine directories to create from config or default
ifeq ($(DIRECTORIES),)
    DIRS := $(DEFAULT_DIRS)
else
    DIRS := $(subst ,, ,$(DIRECTORIES))
endif

# Templates directory
TEMPLATE_DIR := templates

# Project name (must be specified on the command line)
PROJECT ?= my_project

# Parent directory where projects are created (from config or default 'ip_repos')
PROJ_DIR ?= ip_repos

.PHONY: create start clean help list

# Help message
help:
	@echo "Usage:"
	@echo "  make create PROJECT=project_name [GIT_INIT=yes]"  - Create a new project
	@echo "  make list" - List the projects in the project directory
	@echo "  make clean PROJECT=project_name" - Clean the project
	@echo ""
	@echo "Variables:"
	@echo "  DIRECTORIES - Comma-separated list of directories to create"
	@echo "  GIT_INIT    - Set to 'no' to not initialize a git repository. Default is 'yes'"
	@echo "  PROJ_DIR    - Parent directory where projects are created (default: ip_repos)"

# Create project target
create:
	@# Check if project directory already exists and find the next available project name
	@NEW_PROJECT="$(PROJECT)"; \
	if [ -d "$(PROJ_DIR)/$(PROJECT)" ]; then \
		i=1; \
		while [ -d "$(PROJ_DIR)/$(PROJECT)_$$i" ]; do \
			i=$$((i + 1)); \
		done; \
		NEW_PROJECT="$(PROJECT)_$$i"; \
	fi; \
	echo "Creating project: '$$NEW_PROJECT'..."; \
	mkdir -p "$(PROJ_DIR)/$$NEW_PROJECT"/$(DIRS); \
	echo "Copying and customizing README.md..."; \
	sed "s/{{PROJECT_NAME}}/$$NEW_PROJECT/g" "$(TEMPLATE_DIR)/README.md" > "$(PROJ_DIR)/$$NEW_PROJECT/README.md"; \
	echo "Copying init.sh from templates..."; \
	cp "$(TEMPLATE_DIR)/init.sh" "$(PROJ_DIR)/$$NEW_PROJECT/init.sh"; \
	echo "Copying and customizing Makefile and config.mk..."; \
	sed "s/{{PROJECT_NAME}}/$$NEW_PROJECT/g" "$(TEMPLATE_DIR)/Makefile" > "$(PROJ_DIR)/$$NEW_PROJECT/Makefile"; \
	sed "s/{{PROJECT_NAME}}/$$NEW_PROJECT/g" "$(TEMPLATE_DIR)/config.mk" > "$(PROJ_DIR)/$$NEW_PROJECT/config.mk"; \
	if [ "$(GIT_INIT)" != "no" ]; then \
		echo "Initializing git repository..."; \
		cd "$(PROJ_DIR)/$$NEW_PROJECT"; \
		git init; \
	fi; \
	echo "Project '$$NEW_PROJECT' has been created."

# List the projects in the project directory
list:
	@echo "Projects in '$(PROJ_DIR)':"
	@ls -1 "$(PROJ_DIR)"

# Clean project target
clean:
	@echo "Cleaning project: '$(PROJECT)'..."
	@if [ -d "$(PROJ_DIR)/$(PROJECT)/.git" ]; then \
		echo "Git repository detected in project."; \
		cd "$(PROJ_DIR)/$(PROJECT)" && \
		UNCOMMITTED=$$(git status --porcelain); \
		REMOTE=$$(git remote); \
		UNPUSHED=""; \
		if [ -n "$$REMOTE" ]; then \
			UPSTREAM=$$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || echo ""); \
			if [ -n "$$UPSTREAM" ]; then \
				UNPUSHED=$$(git log --branches --not --remotes); \
			fi; \
		fi; \
		if [ -n "$$UNCOMMITTED" ] || [ -n "$$UNPUSHED" ]; then \
			echo "Warning: There are uncommitted changes or unpushed commits."; \
			echo "Do you want to proceed and delete the project directory? [y/N]"; \
			read answer; \
			if [ "$$answer" != "y" ] && [ "$$answer" != "Y" ]; then \
				echo "Aborting."; \
				exit 1; \
			fi; \
		fi; \
	fi; \
	echo "Checking directory: '$(PROJ_DIR)/$(PROJECT)'"
	@if [ -d "$(PROJ_DIR)/$(PROJECT)" ]; then \
		echo "Removing project directory at $(PROJ_DIR)/$(PROJECT)..."; \
		rm -rf "$(PROJ_DIR)/$(PROJECT)"; \
		echo "Project '$(PROJECT)' has been removed."; \
	else \
		echo "No project directory found. Directory: '$(PROJ_DIR)/$(PROJECT)'"; \
	fi;