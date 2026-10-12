#!/bin/zsh
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export ZDOTDIR="$HOME/.config/zsh"

# Oh My Zsh path
export ZSH="$XDG_CONFIG_HOME/oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"

export EDITOR="nvim"

####### Other apps
# Android
export ANDROID_USER_HOME="$XDG_DATA_HOME/android"
export ANDROID_SDK_HOME="$XDG_DATA_HOME/android"

# Rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# Claude
export CLAUDE_CONFIG_DIR="$XDG_CONFIG_HOME/claude"

# Open Claude
export OPENCLAUDE_CONFIG_DIR="$XDG_CONFIG_HOME/openclaude"

# Copilot
export COPILOT_HOME="$XDG_CONFIG_HOME/copilot"

# Docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# GnuPG
export GNUPGHOME="$XDG_DATA_HOME/gnupg"

# Maven
export MAVEN_OPTS="-Dmaven.repo.local=$XDG_DATA_HOME/maven/repository"

# npm
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

# Wine
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default

# Less
export LESSHISTFILE="-"

# Python
export PYTHON_HISTORY="-"

# Wget
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
