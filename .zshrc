# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/blackdeer/.zshrc'

autoload -Uz compinit
compinit
_comp_options+=(globdots)		# Include hidden files.

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

bindkey -M viins jk vi-cmd-mode

# Enable colors and change prompt:
autoload -U colors && colors

# git branch
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}
function parse_arc_branch() {
    arc branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

COLOR_DEF=$'%f'
COLOR_GIT=$'%F{39}'
setopt PROMPT_SUBST
export PROMPT='%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%} ${COLOR_GIT}$(parse_git_branch)$(parse_arc_branch)${COLOR_DEF} $%b '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# custom 
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME/'
alias tmux='tmux -2'

export PATH="$HOME/nvim-linux64/bin:$PATH"

export PATH=$PATH:/usr/local/go/bin
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH=$PATH:$HOME/.local/share/nvim/mason/bin
export PATH=$PATH:$HOME/gpt4all/lib/libcudart.so.12
export PATH=$PATH:$HOME/apache-maven-3.9.8/bin

export PATH="$HOME/.elan/bin:$PATH"
export PATH="$HOME/.pack/bin:$PATH"
export PATH="$HOME/.idris2/bin:$PATH"

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export PATH=$HOME/.cache/rebar3/bin:$PATH

. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export EDITOR='nvim'
export VISUAL='nvim'

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f "/home/blackdeer/.ghcup/env" ] && source "/home/blackdeer/.ghcup/env" # ghcup-env
fpath+=${ZDOTDIR:-~}/.zsh_functions
