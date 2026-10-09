# pywall colors
(cat ~/.cache/wal/sequences &)

# Performance optimizations
DISABLE_AUTO_UPDATE="false"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

# Use XDG dirs for completion, history and cache
[ -d "$XDG_STATE_HOME/zsh" ] || mkdir -p "$XDG_STATE_HOME/zsh"
HISTFILE="$XDG_STATE_HOME/zsh/history"

[ -d "$XDG_CACHE_HOME/zsh" ] || mkdir -p "$XDG_CACHE_HOME/zsh"
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

ZCOMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

autoload -Uz compinit

# re-compile once at day
if [[ -n "$ZCOMPDUMP"(#qN.mh+24) ]] || [[ ! -f "$ZCOMPDUMP" ]]; then
    compinit -d "$ZCOMPDUMP"
else
    compinit -C -d "$ZCOMPDUMP"
fi
#####################################################

# Theme config
ZSH_THEME="robbyrussell"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# Configuration
DISABLE_UNTRACKED_FILES_DIRTY="true"
COMPLETION_WAITING_DOTS="true"
ENABLE_CORRECTION="true"

# fzf
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
export FZF_DEFAULT_OPT
# Carefully ordered plugins (syntax highlighting must be last)

plugins=(
  git
	nvm
	zsh-nvm
	zsh-autosuggestions
	zsh-syntax-highlighting
)

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/mcli mcli

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh
source $XDG_CONFIG_HOME/zsh/.zsh_alias

if [[ $HOST == "nyc-desktop" ]]; then
  eval "$(dotnet completions script zsh)"
fi
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
