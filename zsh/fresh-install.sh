#!/usr/bin/env sh

ln -sf $HOME/.config/zsh/.zshenv $HOME/.zshenv

rm -rf $ZPLUGINDIR
mkdir  $ZPLUGINDIR

for plugin in $ZPLUGINS
do
	plugin_user=$(echo $plugin | awk -F/ '{ print $1 }')
	plugin_name=$(echo $plugin | awk -F/ '{ print $2 }')
	plugin_repo="https://github.com/$plugin"

	git clone $plugin_repo $ZPLUGINDIR/$plugin_name --single-branch --depth 1
done
