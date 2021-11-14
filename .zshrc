# change prompt style
setopt prompt_subst
PROMPT='
%F{magenta}%n@%m%f: %F{cyan}%~%f `prompt_git_current_branch`
%# '

# history
setopt extended_history
setopt histignorealldups
setopt hist_ignore_all_dups
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# completion
autoload -U compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu true select=1

# history completion
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# color
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
autoload colors
zstyle ':completion:*' list-colors "${LSCOLORS}"

# cd
setopt auto_cd

# export
export LANG=ja_JP.UTF-8
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/homebrew/bin:$PATH
export PATH=$HOME/Library/Android/sdk/platform-tools/:$PATH
export PATH=$HOME/go/bin:$PATH
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export JAVA_HOME=/usr/local/opt/openjdk@11
export PATH=$JAVA_HOME/bin:$PATH
export PBSSC_IMAGE_PATH=~/Downloads

# alias
alias l='ls -laG'
alias p='pwd'
alias g='cd $(ghq root)/$(ghq list | peco)'
alias ga='git add'
alias gst='git status'
alias gd='git diff'
alias gb='git branch'
alias gbd='git branch -d'
alias greset='git reset --hard'
alias gsc='git switch -c'
alias gs='git switch `git branch | peco | sed -e "s/\* //g" | awk "{print \$1}"`'
alias gc='git commit -m'
alias gp='git push'
alias gpp='git push --set-upstream origin `git symbolic-ref --short HEAD`'
alias gpull='git pull'
alias ghr='ghq list --full-path | peco | xargs rm -r'
alias ggraph='git log --graph --date=short --decorate=short --pretty=format:"%Cgreen%h %Creset%cd %C(cyan)%cn %C(auto)%d %Creset%s"'

# initialize brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# function
function prompt_git_current_branch {
  local branch_name st branch_status mark

  if [ ! -e  ".git" ]; then
    # no git repository
    return
  fi

  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # all commited
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # untracked
    branch_status="%F{red}"
    mark="?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # unstaged
    branch_status="%F{red}"
    mark="+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # uncomitted
    branch_status="%F{yellow}"
    mark="!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # conflicted
    echo "%F{red}"
    mark=" conflicted"
    return
  else
    # other
    branch_status="%F{blue}"
  fi

  echo "${branch_status}($branch_name)$mark%f"
}
