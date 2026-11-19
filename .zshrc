# Shared shell config. Anything that only applies to one OS lives in
# ~/.config/zsh/Linux.zsh or ~/.config/zsh/Darwin.zsh.

# --- oh-my-zsh ---------------------------------------------------------------
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

source "$ZSH/oh-my-zsh.sh"

# --- Environment -------------------------------------------------------------
source "$HOME/.cargo/env"

export SDKMAN_DIR="$HOME/.sdkman"
export BUN_INSTALL="$HOME/.bun"
export ARCHFLAGS="-arch $(uname -m)"
export PATH="$HOME/go/bin:$BUN_INSTALL/bin:$PATH:$HOME/.local/bin:$HOME/.nsccli/bin"

# Secrets live in the Proton Pass "CLI" vault and are only handed to the
# command that asks for them: `secrets stripe listen`
secrets() { pass-cli run --env-file "$HOME/.config/zsh/secrets.env" -- "$@" }

# --- OS-specific paths and tools ---------------------------------------------
source "$HOME/.config/zsh/$(uname).zsh"

# --- Tools -------------------------------------------------------------------
source <(fzf --zsh)
eval "$(just --completions zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"

[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

# --- History -----------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

# --- Aliases -----------------------------------------------------------------
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

# --- Terminal ----------------------------------------------------------------
fastfetch -c "$HOME/.config/fastfetch/config-v2.jsonc"

# Disable terminal focus reporting and discard leaked focus events.
# Zed specific fix.
printf '\e[?1004l'
bindkey -s $'\e[I' ''
bindkey -s $'\e[O' ''

# zoxide must be initialised last so nothing overrides its directory hook.
eval "$(zoxide init zsh)"
