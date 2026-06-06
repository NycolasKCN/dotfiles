eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

# pywall colors
(cat ~/.cache/wal/sequences &)

# Performance optimizations
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

# Cache completions aggressively
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi

# Oh My Zsh path
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"
# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/nyc/.lmstudio/bin"
# End of LM Studio CLI section

# Theme config
ZSH_THEME="robbyrussell"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Carefully ordered plugins (syntax highlighting must be last)
plugins=(
  git
	nvm
	zsh-nvm
	zsh-autosuggestions
	zsh-syntax-highlighting
)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_alias

eval "$(dotnet completions script zsh)"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/mcli mcli
