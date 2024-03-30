# vim:set ts=2 sts=2 sw=2 et:
if status is-interactive
  set -gx GHCUP_USE_XDG_DIRS 1
  set -gx GPG_TTY $(tty)

  zoxide   init fish                              | source
  starship init fish                              | source
  keychain --eval --quiet -Q id_github id_gitlab  | source

  fish_add_path -p ~/.local/bin
  fish_vi_key_bindings
end
