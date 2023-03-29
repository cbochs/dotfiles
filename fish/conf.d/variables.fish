# Homebrew settings
set -gx HOMEBREW_PREFIX     "/opt/homebrew";
set -gx HOMEBREW_CELLAR     "/opt/homebrew/Cellar";
set -gx HOMEBREW_REPOSITORY "/opt/homebrew";

# Preferred editor
set -gx EDITOR "nvim"
set -gx VISUAL "nvim"

# Lazygit config
set -gx LG_CONFIG_FILE $HOME/.config/lazygit/config.yml

# GPG Setup
#
# References:
# - https://stackoverflow.com/questions/39494631/gpg-failed-to-sign-the-data-fatal-failed-to-write-commit-object-git-2-10-0
# - https://unix.stackexchange.com/questions/388503/cant-sign-encrypt-unless-i-start-gpg-agent-manually
# - https://www.gnupg.org/(it)/documentation/manuals/gnupg/Common-Problems.html
#
set -gx GPG_TTY (tty)

