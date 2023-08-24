bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^F" autosuggest-accept
bindkey "^N" history-beginning-search-forward
bindkey "^P" history-beginning-search-backward

for plugin in $(echo $ZPLUGINS)
do
	plugin_user=$(echo $plugin | awk -F/ '{ print $1 }')
	plugin_name=$(echo $plugin | awk -F/ '{ print $2 }')

    source "$ZPLUGINDIR/$plugin_name/$plugin_name.plugin.zsh"
done

export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

eval "$(atuin init zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
