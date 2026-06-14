# History
HISTSIZE=100000
SAVEHIST=100000
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"

# Options
setopt prompt_subst always_to_end auto_menu complete_in_word
setopt extended_history hist_expire_dups_first hist_ignore_dups hist_ignore_space
setopt hist_verify inc_append_history share_history
unsetopt menu_complete flowcontrol

# fpath
fpath=("${HOME}/.local/share/nix-zsh-completions/share/zsh/site-functions" $fpath)

# Environment
export FZF_DEFAULT_OPTS="--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

# Git branch function
git_branch() {
  git symbolic-ref --short HEAD 2>/dev/null
}

# Prompt with git branch
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f %F{magenta}$(git_branch)%f %F{yellow}$%f '
RPROMPT='%F{red}%(?..[%?])%f'

# Deferred loading
source "${HOME}/.local/share/zsh-defer/zsh-defer.plugin.zsh"

zsh-defer -c 'source "${HOME}/.local/share/fzf-tab/fzf-tab.plugin.zsh"'
zsh-defer -c '
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#585b70"
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
'
zsh-defer -c '
  source "${HOME}/.local/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
  bindkey "^[[A" history-substring-search-up
  bindkey "^[[B" history-substring-search-down
'
zsh-defer -c 'eval "$(zoxide init zsh)" 2>/dev/null'

# Basic bindings
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# Aliases
alias list-gens="nixos-rebuild list-generations"
alias update-input="nix flake update"
alias sysup="nix flake update --flake ~/dotfiles && rebuild"
alias dots="cd ~/dotfiles/"
alias proj="cd ~/Projects"
alias cls="clear"
alias tls="tmux list-sessions"
alias ls="ls -la --color=auto"
alias em="emacs"
alias ff="fastfetch"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -vI"
alias mkd="mkdir -pv"
alias grep="grep --color=always"

# Global aliases
alias -g G="| grep"
