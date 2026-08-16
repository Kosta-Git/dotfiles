export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="catppuccin"
CATPPUCCIN_FLAVOR="macchiato"

plugins=(
  git
  brew
  npm
  kubectl
  docker
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
source $HOME/.cargo/env
source <(fzf --zsh)

export PATH=$PATH:$HOME/.local/bin
export SDKMAN_DIR="$HOME/.sdkman"
export ARCHFLAGS="-arch $(uname -m)"
export BUN_INSTALL="$HOME/.bun"
export PATH="$HOME/.bun/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$PATH:$HOME/.nsccli/bin"

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

eval "$(zoxide init zsh)"
eval "$(just --completions zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"

if [[ "$(uname)" == "Darwin" ]]; then
  export PATH=$PATH:/Users/kosta/Library/Android/sdk/platform-tools
  export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
fi

if [[ "$(uname)" == "Linux" ]]; then
  export PATH=$PATH:/usr/local/go/bin
  export ANDROID_HOME="$HOME/Android/Sdk"
  export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"
  export PATH="$PATH:/home/kosta/.turso"

  if [[ -d /usr/local/cuda/bin ]]; then
    export CUDA_ROOT=/usr/local/cuda
    export PATH="$CUDA_ROOT/bin:$PATH"
    export CUDA_COMPUTE_CAP=86 # RTX 3080 Ti (GA102) = sm_86
  fi
fi

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

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

fastfetch -c $HOME/.config/fastfetch/config-v2.jsonc

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Disable terminal focus reporting and discard leaked focus events.
printf '\e[?1004l'
bindkey -s $'\e[I' ''
bindkey -s $'\e[O' ''
