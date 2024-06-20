#!/bin/bash

# make sure we have pulled in and updated any submodules
git submodule init
git submodule update

apps=(
	bash
	git
	nvim
	lazygit
)

# run the stow command for the passed in directory ($2) in location $1
stowit() {
	usr=$1
	app=$2
	# -v verbose
	# -R recursive
	# -t target
	stow --dotfiles -v -R -t ${usr} ${app}
}

echo ""
echo "Stowing apps for user: ${whoami}"

# install apps available to local users and root
for app in ${apps[@]}; do
	stowit "${HOME}" $app
done

echo "Stowing hyprland config"
stowit "${HOME}/.config/hypr" hyprland

echo ""
echo "##### ALL DONE"
