#!/usr/bin/env zsh

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
# Avoid using ~/.zshenv on macOS, path_helper overrides and reorders the PATH.
# Instead, link .zshenv to ~/.zprofile so it is sourced AFTER /etc/zshenv
#
# Reference: https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2
#
ln -sf $HOME/.config/zsh/.zshenv $HOME/.zprofile

source $HOME/.zprofile

rm -rf $ZPLUGINDIR
mkdir  $ZPLUGINDIR

for plugin in $(echo $ZPLUGINS)
do
	plugin_user=$(echo $plugin | awk -F/ '{ print $1 }')
	plugin_name=$(echo $plugin | awk -F/ '{ print $2 }')
	plugin_repo="https://github.com/$plugin"

	git clone $plugin_repo $ZPLUGINDIR/$plugin_name --single-branch --depth 1
done

source $ZDOTDIR/.zshrc
