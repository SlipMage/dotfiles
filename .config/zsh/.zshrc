# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTSIZE=100000
SAVEHIST=100000

# Load aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"

setopt histignorealldups sharehistory no_match auto_cd promptsubst

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -v

HISTFILE=~/.cache/history

# Use modern completion system
autoload -Uz compinit
zmodload zsh/complist
compinit
_comp_options+=(globdots)

autoload -Uz bashcompinit
bashcompinit

eval "$(register-python-argcomplete pipx)"

typeset -g MY_ZINIT_PATH=${ZDOTDIR:-$HOME/.config/zsh}/zinit
#if [ ! -f "$MY_ZINIT_PATH/bin/zinit.sh" ]; then
#	mkdir -p $MY_ZINIT_PATH && chmod g-rwx "$MY_ZINIT_PATH" && \
#	git clone --depth=1 https://github.com/zdharma/zinit $ZINIT_PATH/bin
#fi

if [ -f $MY_ZINIT_PATH/bin/zinit.zsh ]; then
	declare -A ZINIT

	ZINIT[HOME_DIR]="$MY_ZINIT_PATH"
	source $MY_ZINIT_PATH/bin/zinit.zsh

	if [ -z "$skip_global_compinit" ]; then
		autoload -Uz _zinit
		(( ${+_comps} )) && _comps[zinit]=_zinit
	fi

	unset MY_ZINIT_PATH

	[ ${${(s:.:)ZSH_VERSION}[1]} -ge 5 ] && [ ${${(s:.:)ZSH_VERSION}[2]} -gt 2 ] && \
	MY_ZINIT_USE_TURBO=true
fi
zinit depth=1 lucid nocd for \
	romkatv/powerlevel10k
typeset -g ZSH_AUTOSUGGEST_USE_ASYNC=true
typeset -g ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# nothing past this point
zinit wait lucid for \
	atinit"zicompinit; zicdreplay" \
		zdharma/fast-syntax-highlighting \
	atload"_zsh_autosuggest_start" \
		zsh-users/zsh-autosuggestions \
	blockf atpull'zinit creinstall -q .' \
		zsh-users/zsh-completions


# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
