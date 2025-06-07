# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="catppuccin"
CATPPUCCIN_FLAVOR="macchiato"
plugins=(
  git 
  brew 
  npm 
  nvm 
  lxd 
  terraform 
  kubectl 
  docker 
  golang 
  helm 
  httpie
  dnf
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source $HOME/.secrets

fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

source <(fzf --zsh)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

alias export-idf="source ~/esp/esp-idf/export.sh"
alias ls="lsd"
alias l="ls -l"
alias la="ls -a"
alias vi="nvim"
alias vim="nvim"
alias nano="nvim"
alias cat="bat"
alias zreload="source ~/.zshrc"
alias zcfg="nvim ~/.zshrc"
alias terraform="tofu"

# Scaleway CLI autocomplete initialization.
eval "$(scw autocomplete script shell=zsh)"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
