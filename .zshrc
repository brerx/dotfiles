#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
eval "$(rbenv init -)"
export EDITOR=vim

# restore C-a and C-e for moving on line
bindkey -e

export DATABASE_URL="postgres://postgres:@localhost:5432"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# UTF-8 support
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Powerline
source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

# aliases
alias bert="bundle exec rake -T"
alias ber="bundle exec rake"
alias bertest="bundle exec rake test"
alias src="cd ~/prj/source/"
alias vimbash="vim ~/.bash_profile"
alias vimrc="vim ~/.vimrc"
alias vimz="vim ~/.zshrc"
alias vimprezto="vim ~/.zprestorc"
# alias servant="~/servant"
# alias vimserv="vim ~/servant"
alias ls='ls -GFh'
alias ll='ls -la'

# mxe for cmake cross compilation
export PATH=~/prj/source/mxe/usr/bin:$PATH

# kubectl
kprod () { kubectl --context prod "$@" }
kstag () { kubectl --context staging "$@" }

# global aliases
alias -g gp='| grep -i'

# type title Something to rename iterm tab to Something
function title {
  echo -ne "\033]0;"$*"\007"
}

# Customize to your needs...

autoload -Uz promptinit
promptinit
prompt paradox

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i
