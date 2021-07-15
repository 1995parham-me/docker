autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line
alias vi="vim"

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

# http://blog.joshdick.net/2012/12/30/my_git_prompt_for_zsh.html
# copied from https://gist.github.com/4415470
# Adapted from code found at <https://gist.github.com/1712320>.

#setopt promptsubst
autoload -U colors && colors # Enable colors in prompt

function current_pwd {
  echo $(pwd | sed -e "s,^$HOME,~,")
}

# Original prompt with User name and Computer name included...
PROMPT='
${PR_GREEN}%n%{$reset_color%} %{$FG[239]%}at%{$reset_color%} ${PR_BOLD_BLUE}$(box_name)%{$reset_color%} %{$FG[239]%}in%{$reset_color%} ${PR_BOLD_YELLOW}$(current_pwd)%{$reset_color%}
$(prompt_char) '

export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color [(y)es (n)o (a)bort (e)dit]? "

RPROMPT='${PR_GREEN}%@%{$reset_color%} ${PR_RED}$(get_kernel_version)%{$reset_color%}'
