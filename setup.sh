#!/bin/bash

# make sure we have pulled in and updated any submodules
git submodule init
git submodule update

base=(
	bash,
	git
)

configs=(
	nvim
)

# run the stow command for the passed in directory ($2) in location $1
stowit() {
	usr=$1
	app=$2
	# -v verbose
	# -R recursive
	# -t target
	stow -v -R -t ${usr} ${app}
}

echo ""
echo "Stowing apps for user: ${whoami}"

# install apps available to local users and root
for app in ${base[@]}; do
	stowit "${HOME}" $app
done

for config in ${configs[@]}; do
	stowit "${HOME}/.config/${config}" $config
done

echo ""
echo "##### ALL DONE"
