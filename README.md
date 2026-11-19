# Dotfiles

Shared between Linux and macOS, linked into `$HOME` with GNU Stow.

## Install

```sh
git clone --recurse-submodules git@github.com:Kosta-Git/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./init.sh
```

## Layout

| Path | What |
|---|---|
| `.zshrc` | Shell config shared by both systems |
| `.config/zsh/Linux.zsh` | Linux-only paths and tools |
| `.config/zsh/Darwin.zsh` | macOS-only paths and tools |
| `.config/{kitty,nvim,tmux,fastfetch}` | App configs |
| `.config/ghostty/config` | Ghostty settings and keybinds (tuned on macOS; Ctrl+Shift+W close for Linux) |
| `.config/rex/init.lua` | Rex terminal config |

`.zshrc` sources `~/.config/zsh/$(uname).zsh`, so anything specific to one
system goes in that file instead of behind an `if` in `.zshrc`.

## Secrets

No secret values live in this repo or in the shell environment. They are stored
in the Proton Pass `CLI` vault, and `.config/zsh/secrets.env` maps variable
names to `pass://` references. Run a command with them injected:

```sh
secrets stripe listen
```

This needs the Proton Pass CLI installed and `pass-cli login` run once per machine.
