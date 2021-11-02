#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
# eval "$(rbenv init -)"
export TERM=xterm-256color
export EDITOR=vim
unset -v GEM_HOME # https://discourse.brew.sh/t/why-does-tmuxinator-sets-gem-home/7296/3
# export GEM_HOME='$HOME/.asdf/plugins/ruby/lib/gems/'

bindkey -v

# with sudo: password entry, w/o sudo: permission denied :(
# sudo ifconfig lo0 alias 192.168.100.1

plugins=(docker)

export RUBYOPT='-W0'

export ASDF_RUBY_BUILD_VERSION=master
export DEBUG_PRINT_LIMIT=10000

export DATABASE_URL="postgres://postgres:postgres@localhost:5432"
# export POSTGRES_URL="postgres://postgres:postgres@localhost:5432"
# export DB_USER="postgres"


# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source "$HOME/.logclirc"

# UTF-8 support
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# export DOCKER_BUILDKIT=0
# Powerline
# source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

# aliases
alias a="say -v 'Anna'"
alias y="say -v 'Yuri'"
alias b="bundle"
alias be="b exec"
alias bert="ENV=test RAILS_ENV=test RACK_ENV=test ber test"
alias bers="ENV=test RAILS_ENV=test RACK_ENV=test ber spec"
alias ber="be rake"
alias beru="ENV=test RAILS_ENV=test RACK_ENV=test ber unit"
alias beri="ENV=test RAILS_ENV=test RACK_ENV=test ber integration"
alias berui="ENV=test RAILS_ENV=test RACK_ENV=test ber unit integration"
alias beg="be guard"
alias pret="rbprettier --write **/*.rb"
alias brewup="brew update && brew upgrade && brew cleanup"
alias br="br -s"
alias dc="docker compose"
alias dcu="dc up"
alias dcs="dc stop"
alias dcl="dc logs -f"
alias dcb="dc build"
alias dct="dc run app test"
alias dcbt="docker-compose build && docker-compose run app test"
alias dp="docker system prune -f && docker rmi -f `docker images | awk '{if (NR!=1) {print $3}}' | tr '\n' ' '`"
alias gitalias="vim $HOME/.zprezto/modules/git/alias.zsh"
alias src="cd ~/prj/source/"
alias vimbash="vim ~/.bash_profile"
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zprezto/runcoms/zshrc"
alias tmuxconf="vim ~/.tmux.conf"
alias brewfile="vim ~/Brewfile"
alias vimprezto="vim ~/.zpreztorc"
alias readme="vim ./README.md"
alias drainfile="vim ~/.drainfile"
alias nginxconf="vim /Users/thomas/prj/source/local/nginx.conf"
alias changelog="cd ~/prj/source/iwfm-pkg && git pull && cd - && vim ~/prj/source/iwfm-pkg/CHANGELOG.md"
alias release="grep -m 1 --colour=never 'build-' ~/prj/source/iwfm-pkg/CHANGELOG.md"
alias maik="netstat -anv | grep LISTEN"
alias maikrabbitmq="maik | grep 5672"
alias maikpostgres="maik | grep 5432"
alias maikredis="maik | grep 6379"
alias vimdel="find . -type f -name '*.sw[klmnop]' -delete"
alias curl="/usr/bin/curl -A \"Thomas M. Macbook\" $@"
alias ls='exa -lg'
alias ll='exa -lga'
alias localip='ifconfig | grep -Eo '\''inet (addr:)?([0-9]*\.){3}[0-9]*'\'' | grep -Eo '\''([0-9]*\.){3}[0-9]*'\'' | grep -v '\''127.0.0.1'\'
alias yolo='rm -rf node_modules/ && rm package-lock.json && yarn install'
alias loki='~/bin/logcli-darwin-amd64'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias t='tmux new-session -n ""'
alias yarn1='cd $HOME && yarn set version 1.22.10 > /dev/null && echo "$(yarn -v)" && cd -'
alias yarn2='cd $HOME && yarn set version berry > /dev/null && echo "$(yarn -v)" && cd -'
alias vi="vim"
alias vs="vim -S"
alias ct="ctags -R --exclude=.git --exclude=node_modules"
alias mr="$HOME/prj/source/maintenance-helper/maintain-ruby.rb"

function ghi () {
  gh issue view https://github.com/ivx/injixo/issues/$1 --comments
}

i() {
  local arr=($@)
  for i in {1..$#} ; do
    if test "$@[i]" = 'cd' ; then
      arr[$i]=dir
      cd "$(command i $arr)"
      return
    fi
  done
  command i "$@"
}

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# for local WP development:
alias wp="docker-compose run --rm wp-cli"

# global aliases
alias -g gp='| grep -i'

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit promptinit colors edit-command-line vcs-info
colors
compinit -i
promptinit
zle -N edit-command-line

# source ${HOME}/prj/source/dotfiles/zsh-lcars-theme.sh
source ${HOME}/.bin/tmuxinator.zsh

export SPACESHIP_USER_SHOW=false
export SPACESHIP_HOST_SHOW=false
export SPACESHIP_NODE_SHOW=false
export SPACESHIP_DOCKER_SHOW=false
export SPACESHIP_PACKAGE_SHOW=false
export SPACESHIP_KUBECONTEXT_SHOW=false
export SPACESHIP_TIME_SHOW=true
export SPACESHIP_DIR_COLOR=5
export SPACESHIP_GIT_BRANCH_COLOR=33
export SPACESHIP_GIT_STATUS_COLOR=162
export SPACESHIP_BATTERY_SHOW=true
export SPACESHIP_BATTERY_TRESHOLD=50
export SPACESHIP_VI_MODE_COLOR=185

prompt spaceship

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

# restore C-a and C-e for moving on line
# bindkey -e
source "$HOME/.zsh/zsh-vim-mode/zsh-vim-mode.plugin.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setting rg as the default source for fzf (respects .gitgnore by default)
export FZF_DEFAULT_COMMAND='rg --files'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# overwrite precmd that sets the custom RPROMPT from tklepzig
# precmd() {}
