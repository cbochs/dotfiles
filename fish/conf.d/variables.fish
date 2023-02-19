# Homebrew settings
set -gx HOMEBREW_PREFIX     "/opt/homebrew";
set -gx HOMEBREW_CELLAR     "/opt/homebrew/Cellar";
set -gx HOMEBREW_REPOSITORY "/opt/homebrew";

# Preferred editor
set -gx EDITOR "nvim"
set -gx VISUAL "nvim"

# GPG Setup
# https://www.gnupg.org/(it)/documentation/manuals/gnupg/Common-Problems.html
# https://stackoverflow.com/questions/39494631/gpg-failed-to-sign-the-data-fatal-failed-to-write-commit-object-git-2-10-0
set -gx GPG_TTY (tty)

