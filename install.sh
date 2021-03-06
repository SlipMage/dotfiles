#!/bin/env bash

DISTRO=$(awk -F= '$1=="ID" { print $2 }' /etc/os-release)


HOSTNAME=$(hostname -s)

if [ $DISTRO == "debian" ] || [ $DISTRO == "ubuntu" ]
then
	sudo apt -y install vim
	sudo apt -y purge nano
	
	mkdir -p .local/share/vim/swap .local/share/vim/undo .local/share/vim/backup .local/share/vim/view .local/share/vim/after

	if [ $HOSTNAME == "dev" || $HOSTNAME == "abel" ]
	then
		PACKAGES="xorg-server rofi picom kitty conky python3-pip zsh curl rsync xz-utils git-flow kitty xorg build-essential libsdl1.2-dev libsdl-mixer1.2-dev conky picom git"
		sudo apt -y install $PACKAGES
		python3 -m pip install --user pipx
		python3 -m pipx ensurepath
		pipx install --user pywal
	fi
fi

if [ $DISTRO == "arch" ]
then
	mkdir -p .local/share/vim/swap .local/share/vim/undo .local/share/vim/backup .local/share/vim/view .local/share/vim/after

	if [ $HOSTNAME == "dev" ] || [ $HOSTNAME == "abel" ]
	then
		PACKAGES="xorg xorg-server xorg-apps xorg-init i3-gaps-next-git i3status rofi picom alacritty conky python-pywal python-pip rsync xz gitflow-avh xorg-server alacritty base-devel sdl sdl_mixer conky picom"

		git clone https://aur/archlinux.org/yay.git
		cd yay
		makepkg -si
		cd ~
		yay -S --noconfirm $PACKAGES
		python3 -m pip install --user pipx
		python3 -m pipx ensurepath
		git clone --recursive --separate-git-dir=$HOME/.dots.git git@github.com:SlipMage/dotfiles.git /tmp/dots
		rsync -rvl --exclude ".git" /tmp/dots/ $HOME/
		rm -r /tmp/dots
		echo "change .config/zsh/.zshrc to setup zinit; logout then back in"
	fi
fi
