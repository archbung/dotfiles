# vim:set ts=2 sts=2 sw=2 et:
if status is-interactive
  set -gx GPG_TTY $(tty)
  set -gx EDITOR "nvim"
  set -gx BROWSER "firefox-nightly"

  fish_vi_key_bindings

  keychain --eval --quiet -Q id_github id_gitlab | source
  starship init fish | source
  zoxide init fish | source
end
