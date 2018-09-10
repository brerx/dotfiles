#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
eval "$(rbenv init -)"
export EDITOR=vim

plugins=(docker)

export DATABASE_URL="postgres://postgres:@localhost:5432"

#workaround for ansible under HighSierra
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

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
alias kubes="kubectl --context=staging-185"
alias kubep="kubectl --context=production-186"
alias bert="bundle exec rake -T"
alias ber="bundle exec rake"
alias bertest="bundle exec rake test"
alias src="cd ~/prj/source/"
alias vimbash="vim ~/.bash_profile"
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc"
alias tmuxconf="vim ~/.tmux.conf"
alias vimprezto="vim ~/.zprestorc"
alias readme="vim ./README.md"
alias changelog="vim ~/prj/source/iwfm-pkg/CHANGELOG.md"
alias release="grep -m 1 --colour=never 'build-' ~/prj/source/iwfm-pkg/CHANGELOG.md"
# alias servant="~/servant"
# alias vimserv="vim ~/servant"
alias ls='ls -GFh'
alias ll='ls -la'

# mxe for cmake cross compilation
export PATH=~/prj/source/mxe/usr/bin:$PATH

# # kubectl
# kprod () { kubectl --context prod "$@" }
# kstag () { kubectl --context staging "$@" }

# global aliases
alias -g gp='| grep -i'

# type title Something to rename iterm tab to Something
function title {
  echo -ne "\033]0;"$*"\007"
}

# VSINSTALLDIR: wine path to your Visual Studio installation
export VSINSTALLDIR='Z:\\Users\\thomas\\prj\\Microsoft Visual Studio 8'
# IWFM_3PTY: unix path to iWFM third party
export IWFM_3PTY="/Users/thomas/prj/3PTY"
#
# Customize to your needs...

autoload -Uz promptinit
promptinit
prompt paradox

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi
# Tmux {{{
# Makes creating a new tmux session (with a specific name) easier
function tmuxopen() {
  tmux attach -t $1
}

# Makes creating a new tmux session (with a specific name) easier
function tmuxnew() {
  tmux new -s $1
}

# Makes deleting a tmux session easier
function tmuxkill() {
  tmux kill-session -t $1
}
# }}}

# Alias' {{{
alias vi="vim"
alias r="source ~/.zshrc"
alias tat='tmux new-session -As $(basename "$PWD" | tr . -)' # will attach if session exists, or create a new session
alias tmuxsrc="tmux source-file ~/.tmux.conf"
alias tmuxkillall="tmux ls | cut -d : -f 1 | xargs -I {} tmux kill-session -t {}" # tmux kill all sessions
alias ct="ctags -R --exclude=.git --exclude=node_modules"
alias dotfiles="ls -a | grep '^\.' | grep --invert-match '\.DS_Store\|\.$'"
# }}}
#
# restore C-a and C-e for moving on line
bindkey -e

