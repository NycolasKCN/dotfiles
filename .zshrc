
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
export EDITOR="nvim"

# Theme config
ZSH_THEME="robbyrussell"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

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
source $HOME/.zsh_alias

eval "$(dotnet completions script zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
