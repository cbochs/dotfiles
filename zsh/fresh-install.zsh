#!/usr/bin/env zsh

# Don't use ~/.zshenv on macOS
#
# Reference: https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2
#
ln -sf $HOME/.config/zsh/.zshenv $HOME/.zprofile

source $HOME/.zshenv

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
