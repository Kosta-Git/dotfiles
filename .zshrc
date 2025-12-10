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
  gradle
  rust
)

source $ZSH/oh-my-zsh.sh
source $HOME/.secrets

if [[ "$(uname)" == "Darwin" ]]; then
  export PATH=$PATH:/Users/kosta/Library/Android/sdk/platform-tools
  export OPEN_OCD_SCRIPTS=/opt/homebrew/Cellar/open-ocd/0.12.0_1/share/openocd/scripts
  export OCD_I=$OPEN_OCD_SCRIPTS/interface
  export OCD_T=$OPEN_OCD_SCRIPTS/target
  [ -f "/Users/kosta/.ghcup/env" ] && . "/Users/kosta/.ghcup/env" # ghcup-env
  alias claude="/Users/kosta/.claude/local/claude"
fi

if [[ "$(uname)" == "Linux" ]]; then
  export OPEN_OCD_SCRIPTS=/usr/share/openocd/scripts
  export OCD_I=$OPEN_OCD_SCRIPTS/interface
  export OCD_T=$OPEN_OCD_SCRIPTS/target
fi

fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

source <(fzf --zsh)
eval "$(zoxide init zsh)"

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
alias cd="z"
alias openocd_l5="openocd -f $OCD_I/stlink-v2.cfg -f $OCD_T/stm32l5x.cfg"

# Let's get rusty
source $HOME/.cargo/env

# Scaleway CLI autocomplete initialization.
eval "$(scw autocomplete script shell=zsh)"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export ARCHFLAGS="-arch $(uname -m)"

eval "$(cs install --env)"

[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
