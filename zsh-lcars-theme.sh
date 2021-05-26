#!/usr/bin/env zsh

isOS()
{
  if [[ "$OSTYPE:l" == *"$1:l"* ]]
  then
    return 0;
  fi

  return 1;
}

isProgramInstalled()
{
  command -v $1 >/dev/null 2>&1 || { return 1 >&2; }
  return 0
}

nl=$'\n'
greyTile=%K{238}%F{7}
default=%F{172}
light=%F{179}
lighter=%F{222}
accent=%F{32}
accentTile=%K{32}%F{15}
reset=%f%k

zstyle ':completion:*' menu select
zstyle ':vcs_info:git:*' formats " "
zstyle ':vcs_info:git:*' actionformats "$accentTile %a (%b) $reset"
zstyle ':vcs_info:*' enable git

precmd() {
  lastExitCode=$?

  vcs_info
  RPROMPT='${vcs_info_msg_0_}'
}

upstreamIndicator() 
{
  if [[ -z "$(git rev-parse --abbrev-ref HEAD 2> /dev/null)" ]]
  then
    echo ""
    return
  fi

  upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2> /dev/null)

  if [[ -z $upstream ]] then
    echo " #";
  else
    upstream_info=$(git rev-list --left-right --count $upstream...HEAD 2> /dev/null)
    case "$upstream_info" in
      "") # no upstream
        echo "" ;;
      "0	0") # equal to upstream
        echo " =" ;;
      "0	"*) # ahead of upstream
        echo " >" ;;
      *"	0") # behind upstream
        echo " <" ;;
      *)	    # diverged from upstream
        echo " <>" ;;
    esac
  fi
}

topbar_show ()
{
  ZSH_TOP_BAR=""
}

topbar_hide ()
{
  ZSH_TOP_BAR="hidden"
  tput sc
  tput cup 0 0
  tput el
  tput csr 0 $(($(tput lines)))
  tput rc
}

set_topbar_title ()
{
  ZSH_TOP_BAR_TITLE="$1"
}

alias tbh='topbar_hide' 
alias tbs='topbar_show' 
alias tbt='set_topbar_title'

topbar ()
{
  if [[ "$ZSH_TOP_BAR" = "hidden" ]]
  then
    return 0
  fi

  local default="$(tput setab 172)$(tput setaf 0)"
  local fg="$(tput setaf 172)"
  local accent="$(tput setab 32)$(tput setaf 15)"
  local light="$(tput setab 179)$(tput setaf 0)"
  local lighter="$(tput setab 222)$(tput setaf 0)"
  local reset="$(tput sgr0)"
  local nl=$'\n'
  local width=$(tput cols)


  local title=$ZSH_TOP_BAR_TITLE
  if [[ -n $title ]]
  then
    local start="   "
    local end=" "
    local fullMinWidth=$((${#start} + ${#title} + ${#end} + 2))
    local lightMinWidth=$fullMinWidth
    local fill="$(printf "%${$(($width - ${#start} - ${#title} - ${#end} - 2))}s")"
    full="$default$start$fill$reset$fg $title $default$end"
    light=$full
  else
    local start=" "
    local end=" "
    local user=" $(whoami) "
    local host=" $(hostname -s) "
    local repoStatus=$(command git status --porcelain 2> /dev/null | tail -n1)
    local branch=" $(git rev-parse --abbrev-ref HEAD 2> /dev/null)$(upstreamIndicator) "
    local branchColor="$([[ -n $repoStatus ]] && echo $accent || echo $default)"

    local fullMinWidth=$((${#start} + ${#user} + ${#host} + ${#branch} + ${#end} + 6))
    local lightMinWidth=$((${#start} + ${#branch} + ${#end} + 4))
    local fillFull="$(printf "%${$(($width - ${#start} - ${#user} - ${#host} - ${#branch} - ${#end} - 5))}s")"
    local fillLight="$(printf "%${$(($width - ${#start} - ${#branch} - ${#end} - 3))}s")"

    local full="$default$start$reset "
    full+="$light$user$reset "
    full+="$light$host$reset "
    full+="$default$fillFull$reset "
    full+="$branchColor$branch$reset "
    full+="$default$end"

    local light="$default$start$reset "
    light+="$default$fillLight$reset "
    light+="$branchColor$branch$reset "
    light+="$default$end"
  fi

  local mini="$default$(printf "%${width}s")$reset"

  # Save cursor position
  tput sc
  # Move cursor to 0,0
  tput cup 0 0
  # Change scroll region to exclude the first line
  tput csr 1 $(($(tput lines) - 1))
  if [ $width -lt $fullMinWidth ]
  then
    if [ $width -lt $lightMinWidth ]
    then
      echo -ne "$mini"
    else
      echo -ne "$light"
    fi
  else
    echo -ne "$full"
  fi

  # Restore cursor position
  tput rc
}

prefix=$(echo -e '\u276f')
bar='${$(topbar)//\%/%%}'
PROMPT="$bar$nl$greyTile\$elapsedTime$reset$nl$light%(5~|%-1~/…/%3~|%4~)$nl$default$prefix $reset"

ZSH_SOUND=0
