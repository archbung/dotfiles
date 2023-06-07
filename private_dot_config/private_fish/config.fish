# vim:set ts=2 sts=2 sw=2 et:
if status is-interactive

  set -gx GPG_TTY $(tty)
  set -gx EDITOR "nvim"
  set -gx BROWSER "firefox-developer-edition"

  set -gx GHCUP_USE_XDG_DIRS 1

  fish_vi_key_bindings
  fish_add_path ~/.local/bin ~/.cargo/bin

  starship init fish | source
  zoxide init fish   | source
  keychain --eval --quiet -Q id_github id_gitlab id_haskell | source

  if status is-login
    if test -z "$WAYLAND_DISPLAY" -a "$XDG_VTNR" = 1
        exec wrappedhl
    end
  end
end
