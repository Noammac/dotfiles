# User configuration
if [[ -e /usr/bin/most ]]; then export PAGER="most"; fi
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
export GPG_TTY=$(tty)
export XDG_CONFIG_HOME="$HOME/.config"
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Editor
if [[ -n $SSH_CONNECTION || ! -e $GOPATH/bin/micro ]]; then
	export EDITOR='nano'
else
	export EDITOR='micro'
fi

# Functions, widgets and keybindings
## Functions
autoload zed
autoload -U tetris
autoload -U tetriscurses

cheat.sh() {
	curl cheat.sh/$1
}

weather() {
	curl "wttr.in/$1?0qm"
}

qrencode() {
	printf "$*" | curl -F-=\<- qrenco.de
}

dict() {
	curl "dict://dict.org/d:$*"
}

## Widgets
tetris 1>/dev/null 2>&1
zle -N tetris
## Key bindings
bindkey "[3~" backward-delete-word
bindkey "\C-T" tetris
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# End functions, widgets and key bindings

# Antigen
source /home/noammac/antigen.zsh

## oh-my-zsh lib
antigen use oh-my-zsh

## Bundles for the default repo
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle virtualenv
antigen bundle go
antigen bundle archlinux
antigen bundle command-not-found
# antigen bundle common-aliases

## Syntax highlighting
antigen bundle zdharma/fast-syntax-highlighting
export FAST_HIGHLIGHT_STYLES[path]="fg=white,underline"

## Auto-suggestions
antigen bundle zsh-users/zsh-autosuggestions

## Theme
antigen theme noammac/dotfiles themes/neo_agnoster
DEFAULT_USER=noammac
export VIRTUAL_ENV_DISABLE_PROMPT=true


antigen apply

# End Antigen

## Aliases and even-better-ls
# aliases, needs to be executed after oh-my-zsh to assert higher priority
# aliases using already-installed programs
alias l.="ls -d .*"
alias please="sudo"
alias fucking="sudo"
alias py="python3"
alias gdiff="diff -du --color=always"
alias קסןא="exit"
alias ךד="ls"

# aliases using programs that need to be installed locally
if [[ -e /usr/bin/nc ]]; then alias tb="nc termbin.com 9999"; fi
if [[ -e /usr/bin/pygmentize ]]; then alias ccat="pygmentize -g"; fi
if [[ -e $GOPATH/bin/micro ]]; then alias nano="micro"; fi

# even-better-ls setup, needs to be executed after oh-my-zsh for the same reason
if [[ -e /usr/bin/ls-i && -e /usr/bin/dir-i && -e /usr/bin/vdir-i ]]; then
	export LS_COLORS=$(ls_colors_generator)
	run_ls() {
		ls-i --color=auto -w $(tput cols) "$@"
	}

		run_dir() {
		dir-i --color=auto -w $(tput cols) "$@"
	}

		run_vdir() {
		vdir-i --color=auto -w $(tput cols) "$@"
	}

	alias ls="run_ls"
	alias dir="run_dir"
	alias vdir="run_vdir"
fi

# WORDCHARS, I'm not sure it even works
WORDCHARS=${WORDCHARS//[\/.-]=\+\@}
export WORDCHARS=$WORDCHARS

# vim-like keybindings
bindkey -v 

# Startup commands, refer to launch-{tetris,man} and to clock
if [[ -z $NO_STARTUP ]]; then
	neofetch
	$HOME/dater.py
fi
