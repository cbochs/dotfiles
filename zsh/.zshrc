bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^F" autosuggest-accept
bindkey "^N" history-beginning-search-forward
bindkey "^P" history-beginning-search-backward
bindkey "^J" backward-word
bindkey "^K" forward-word
bindkey "^W" backward-kill-word

for plugin in $(echo $ZPLUGINS)
do
	plugin_user=$(echo $plugin | awk -F/ '{ print $1 }')
	plugin_name=$(echo $plugin | awk -F/ '{ print $2 }')

	source "$ZPLUGINDIR/$plugin_name/$plugin_name.plugin.zsh"
done

export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

source /opt/homebrew/opt/asdf/libexec/asdf.sh

eval "$(atuin init zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
