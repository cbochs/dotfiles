# Remove default greeting
set -g fish_greeting

source /opt/homebrew/opt/asdf/libexec/asdf.fish

# Other settings
# cat /usr/local/lib/asdf.fish | source
atuin init fish | source
starship init fish | source
zoxide init fish | source
