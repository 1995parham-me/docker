# Vi mode keybindings
bindkey -v
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Shell options
setopt prompt_subst           # Enable parameter expansion in prompt
setopt transient_rprompt      # Only show rprompt on current prompt
setopt auto_cd                # Auto cd by typing directory name
setopt auto_pushd             # Push directories onto directory stack
setopt pushd_ignore_dups      # Don't push duplicate directories
setopt share_history          # Share history between sessions
setopt hist_ignore_dups       # Don't save duplicate commands
setopt hist_ignore_space      # Don't save commands starting with space
setopt hist_reduce_blanks     # Remove extra blanks from history

# Completion system
autoload -Uz compinit
compinit -d ~/.zcompdump

# Enable colors
autoload -U colors && colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Editor
EDITOR=vim
export EDITOR

# Basic aliases
alias vi="vim"
alias ll="ls -lah"
alias ls="ls --color=auto"
alias grep="grep --color=auto"

# Utility functions
function box_name() {
  [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

clean_box() {
  echo "Cleaning box data..."
  rm -rf ~/.config/nats ~/.zsh_history ~/.mycli-history ~/.pgcli-history
}

# Prompt
PS1='%F{red}%/%f $ '
export RPROMPT="%F{241}%B%t%b%f"
