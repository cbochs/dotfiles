# Remove default greeting
set -g fish_greeting


# Plugins
zoxide init fish | source

# Abbreviations
abbr -a b bat
abbr -a c cd
abbr -a l eza
abbr -a n nvim
abbr -a s ssh
abbr -a v nvim

abbr -a lg lazygit
abbr -a ll eza -l
abbr -a lll eza -la

abbr -a g git
abbr -a gb git branch
abbr -a gc git checkout
abbr -a gcm git checkout master
abbr -a gl git log
abbr -a gP git push
abbr -a gp git pull
abbr -a gpu git pull upstream master
abbr -a gr git remote
abbr -a gs git st
abbr -a gsm git submodule update --recursive

abbr -a d docker
abbr -a dc docker compose
abbr -a di docker image
abbr -a dv docker volume

# Bindings
function fish_user_key_bindings
    bind -M insert \cz 'fg &>/dev/null'
    bind -M insert \cj backward-word
    bind -M insert \ck forward-word

    # Execute this once per mode that emacs bindings should be used in
    fish_default_key_bindings -M insert

    # Then execute the vi-bindings so they take precedence when there's a conflict.
    # Without --no-erase fish_vi_key_bindings will default to
    # resetting all bindings.
    # The argument specifies the initial mode (insert, "default" or visual).
    fish_vi_key_bindings --no-erase insert
end

# Paths
# Let's take a moment to understand where PATH is loaded from:
# 1. /etc/paths
# 2. /etc/paths.d/*
# 3. $HOME/.config/fish/config.fish
# 4. $HOME/.config/fish/path.fish
# 5. $HOME/.ssh/environment (ssh only)
#
# Reference: https://fishshell.com/docs/current/cmds/fish_add_path.html
#

# Path: ARM64-based Homebrew
fish_add_path /opt/homebrew/sbin
fish_add_path /opt/homebrew/bin

# Path: rust and cargo binaries
fish_add_path $HOME/.cargo/bin

# Path: pipx binaries
fish_add_path $HOME/.local/bin

# Path: neovim bob binaries
fish_add_path $HOME/.local/share/bob/nvim-bin

# Path: cisco secure client vpn
fish_add_path $HOME/.config/nvim/bin

# Path: cisco secure client vpn
fish_add_path /opt/cisco/secureclient/bin

# Variables
# Homebrew
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
set -gx HOMEBREW_REPOSITORY /opt/homebrew

# Editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# Man Pages
set -gx MANPAGER "nvim +Man!"

# Lazygit
set -gx LG_CONFIG_FILE $HOME/.config/lazygit/config.yml

# ImageMagick
set -gx LDFLAGS "-L/opt/homebrew/opt/imagemagick@6/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/imagemagick@6/include"

# Fzf
set -gx FZF_DEFAULT_COMMAND "fd --type file --follow"

# GPG Setup
#
# References:
# - https://stackoverflow.com/questions/39494631/gpg-failed-to-sign-the-data-fatal-failed-to-write-commit-object-git-2-10-0
# - https://unix.stackexchange.com/questions/388503/cant-sign-encrypt-unless-i-start-gpg-agent-manually
# - https://www.gnupg.org/(it)/documentation/manuals/gnupg/Common-Problems.html
#
set -gx GPG_TTY (tty)

# Prompt
set __fish_git_prompt_showuntrackedfiles yes
set __fish_git_prompt_showdirtystate yes
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream none
set -g fish_prompt_pwd_dir_length 3

function fish_prompt
    if [ $fish_bind_mode != insert ]
        set_color yellow
    else
        set_color brblack
    end

    echo -n "["(date "+%H:%M")"] "
    set_color blue
    echo -n (hostname)
    if [ $PWD != $HOME ]
        set_color brblack
        echo -n ':'
        set_color yellow
        echo -n (basename $PWD)
    end
    set_color green
    printf '%s ' (__fish_git_prompt)
    set_color red
    echo -n '| '
    set_color normal
end

source /opt/homebrew/opt/asdf/libexec/asdf.fish
