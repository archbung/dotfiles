# vim:set ts=2 sts=2 sw=2 et:
if status is-interactive
  set -gx GPG_TTY $(tty)
  set -gx EDITOR "nvim"
  set -gx BROWSER "firefox-developer-edition"

  fish_vi_key_bindings

  keychain --eval --quiet -Q id_github | source
  starship init fish | source
  zoxide init fish | source
end
