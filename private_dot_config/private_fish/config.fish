# vim:set ts=2 sts=2 sw=2 et:
if status is-interactive
  set -gx GPG_TTY $(tty)
  set -gx EDITOR "nvim"
  set -gx BROWSER "firefox-developer-edition"

  set -U fish_greeting
  fish_vi_key_bindings

  fish_add_path ~/.local/bin ~/.ghcup/bin ~/.cargo/bin

  keychain --eval --quiet -Q id_github id_gitlab | source
  starship init fish | source
  zoxide init fish | source

  if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
    exec startx -- -keeptty
  end
end
