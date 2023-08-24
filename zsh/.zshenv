export ZDOTDIR="$HOME/.config/zsh"

# Zsh Plugins
export zplugins=(
	marlonrichert/zsh-autocomplete
	olets/zsh-abbr
	zsh-users/zsh-autosuggestions
	zsh-users/zsh-syntax-highlighting
)
export ZPLUGINDIR="$HOME/.config/zsh/plugins"
export ZPLUGINS="$(echo $zplugins)"

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Man Pages
export MANPAGER='nvim +Man!'

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Lazygit
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"

# GPG
#
# References:
# - https://stackoverflow.com/questions/39494631/gpg-failed-to-sign-the-data-fatal-failed-to-write-commit-object-git-2-10-0
# - https://unix.stackexchange.com/questions/388503/cant-sign-encrypt-unless-i-start-gpg-agent-manually
# - https://www.gnupg.org/(it)/documentation/manuals/gnupg/Common-Problems.html
#
export GPG_TTY="$(tty)"

# Let's take a moment to understand where PATH is loaded from:
#
# File types
#     .zshenv   | always
#     .zprofile | interactive-only
#     .zshrc    | not scripts
#     .zlogin   | interactive-only
#     .zlogout  | interactive-only
#
# Files are sources from /etc and then $ZDOTDIR
#
# Reference: man zsh(1) FILES
#
#

# Path: rust and cargo binaries
path=("$HOME/.cargo/bin" $path)

# Path: pipx binaries
path=("$HOME/.local/bin" $path)

# Path: neovim bob binaries
path=("$HOME/.local/share/bob/nvim-bin" $path)

# Path: neovim custom scripts
path=("$HOME/.config/nvim/bin" $path)

# ensure path has unique elements
typeset -aU path
