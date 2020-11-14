#!/bin/zsh

export PATH="$PATH:/snap/bin:$HOME/.local/bin/"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.local/cache"

export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"| source $MYVIMRC'
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible/ansible.cfg"

export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"

