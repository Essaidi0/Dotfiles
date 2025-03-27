# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.config/histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/j3w/.zshrc'

# End of lines added by compinstall

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
## Load powerlevel10k theme
	zinit ice depth"1" # git clone depth
	zinit light romkatv/powerlevel10k

	zinit light zsh-users/zsh-syntax-highlighting
	zinit light zsh-users/zsh-completions
	zinit light zsh-users/zsh-autosuggestions
	zinit light Aloxaf/fzf-tab

### Load completions
	autoload -Uz compinit && compinit

### fzf setup 
  source <(fzf --zsh)

#######################################################
# ZSH Basic Options
#######################################################

	setopt autocd              # change directory just by typing its name
	setopt correct             # auto correct mistakes
	setopt interactivecomments # allow comments in interactive mode
	setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
	setopt nonomatch           # hide error message if there is no match for the pattern
	setopt notify              # report the status of background jobs immediately
	setopt numericglobsort     # sort filenames numerically when it makes sense
	setopt promptsubst         # enable command substitution in prompt

#######################################################
# Environment Variables	
#######################################################
# export EDITOR=nvim
# export VISUAL=nvim
	export EDITOR=nvim visudo
	export VISUAL=nvim visudo
	export SUDO_EDITOR=nvim
	export FCEDIT=nvim
	export TERMINAL=kitty
	export BROWSER=firefox

#######################################################
# History Configuration
#######################################################

	HISTSIZE=10000
	HISTFILE=~/.zsh_history
	SAVEHIST=$HISTSIZE
	HISTDUP=erase
	setopt appendhistory
	setopt sharehistory
	setopt hist_ignore_space	
	setopt hist_ignore_all_dups
	setopt hist_save_no_dups
	setopt hist_ignore_dups
	setopt hist_find_no_dups

#######################################################
# Completion styling
#######################################################

	zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
	zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
	zstyle ':completion:*' menu no
	zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
	zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

#######################################################
# Aliases
#######################################################

	alias nv="nvim"
	alias ls="ls -a --color=auto"
	alias mkdir='mkdir -pv'
	alias cp='cp -iv'
	alias mv='mv -iv'
	alias rm='rm -iv'
	alias rmdir='rmdir -v'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
