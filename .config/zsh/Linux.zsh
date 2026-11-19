# Linux-only shell config, sourced from ~/.zshrc.

export PATH="$HOME/.local/share/fnm:$PATH:/usr/local/go/bin:$HOME/.turso"

# Android
export ANDROID_HOME="$HOME/Android/Sdk"
export NDK_HOME="$(print -l "$ANDROID_HOME"/ndk/*(N/) | tail -n 1)"

# CUDA
export CUDA_ROOT=/usr/local/cuda
export CUDA_COMPUTE_CAP=86 # RTX 3080 Ti (GA102) = sm_86
export PATH="$CUDA_ROOT/bin:$PATH"

# Tools only installed on this machine
source "$HOME/.ghcup/env"
eval "$(scw autocomplete script shell=zsh)"
eval "$(cs install --env)"
