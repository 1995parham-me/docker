bindkey -v
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

alias vi="vim"
alias ll="ls -lah"

EDITOR="$(which vim)"
export EDITOR

setopt prompt_subst # Enable parameter expansion, command substitution, and arithmetic expansion in the prompt
setopt transient_rprompt # only show the rprompt on the current prompt

function prompt_char {
  echo '○'
}

function box_name() {
  [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

function get_kernel_version() {
  uname -rs
}

clean_box() {
  echo "Cleaning box data..."
  rm -rf ~/.config/nats ~/.ash_history ~/.mycli-history
}

PS1='%F{red}%/%f $ '
export RPROMPT="%F{241}%B%t%b%f"

eval "$(starship init zsh)"
