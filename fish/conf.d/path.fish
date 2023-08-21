# Let's take a moment to understand where PATH is loaded from:
# 1. /etc/paths
# 2. /etc/paths.d/*
# 3. $HOME/.config/fish/config.fish
# 4. $HOME/.config/fish/path.fish
# 5. $HOME/.ssh/environment (ssh only)
#
# Reference: https://fishshell.com/docs/current/cmds/fish_add_path.html
#

# Added by me to use ARM64-based Homebrew
fish_add_path /opt/homebrew/sbin
fish_add_path /opt/homebrew/bin

# Created by `pipx` on 2021-11-05 22:56:16
# Modified by me to use more fish-like syntax
fish_add_path $HOME/.local/bin

# Added by me to include rust in PATH
fish_add_path $HOME/.cargo/bin

# Added by me to include spicetify in PATH
# fish_add_path $HOME/.spicetify

# Added by me to include neovim bob in PATH
fish_add_path $HOME/.local/share/neovim/bin

# Added by me to include neovim custom scripts
fish_add_path $HOME/.config/nvim/bin
