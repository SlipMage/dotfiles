#!/bin/zsh

export PATH="$PATH/snap/bin:$HOME/.local/bin/" 

export HDG_CONFIG_HOME="$HOME/.config"
export HDG_DATA_HOME="$HOME/.local/share"
export HDG_CACHE_HOME="$HOME/.local/cache"

export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible/ansible.cfg"

export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"

