bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^F' autosuggest-accept
bindkey '^N' history-beginning-search-forward
bindkey '^P' history-beginning-search-backward

source "$HOME/.config/zsh/zsh-abbr/zsh-abbr.plugin.zsh"
source "$HOME/.config/zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
source "$HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

eval "$(atuin init zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
