#!/bin/env bash

DISTRO=$(awk -F= '$1=="ID" { print $2 }' /etc/os-release)

PACKAGES="zsh openssh-server curl vim rsync"

HOSTNAME=$(hostname -s)

if [ $DISTRO == "debian" || $DISTRO == "ubuntu" ]
then
	
	if [ $HOSTNAME == "dev" || $HOSTNAME == "abel" ]
	then
		PACKAGES+=xz-utils git-flow kitty xorg build-essential libsdl1.2-dev libsdl-mixer1.2-dev conky picom git
	fi
	sudo apt -y install $PACKAGES
	sudo apt -y purge nano
fi

if [ $DISTRO == "arch" ]
then
	if [ $HOSTNAME == "dev" || $HOSTNAME == "abel" ]
	then
		PACKAGES+=xz gitflow-avh xorg-server alacritty base-devel sdl sdl_mixer conky picom
	fi
	git clone https://aur/archlinux.org/yay.git
	cd yay
	makepkg -si
	cd ~
	yay -Y $PACKAGES
	yay -Y -R nano
	git clone --recursive --separate-git-dir=$HOME/.dots.git git@github.com:SlipMage/dotfiles.git /tmp/dots
	rsync -rvl --exclude ".git" /tmp/dots/ $HOME/
	rm -r /tmp/dots
	echo "change .config/zsh/.zshrc to setup zinit; logout then back in"
fi

