bindkey -v
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line
alias vi="vim"
alias pgcli="PGCLIRC=/tmp/pgcli_config  pgcli"

EDITOR="$(which vim)"
export EDITOR

setopt prompt_subst # Enable parameter expansion, command substitution, and arithmetic expansion in the prompt
setopt transient_rprompt # only show the rprompt on the current prompt

function prompt_char {
  echo '○'
}

function box_name {
  [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

function get_kernel_version() {
  uname -rs
}

PS1='%F{red}%/%f $ '
export RPROMPT="%F{241}%B%t%b%f"
