if status is-interactive
  set -gx GPG_TTY $(tty)

  fish_add_path -p ~/.ghcup/bin ~/.local/bin ~/.elan/bin
  fish_vi_key_bindings

  starship init fish                              | source
  zoxide init fish                                | source
  keychain --eval --quiet -Q id_github id_gitlab  | source
  rbenv init - fish                               | source
end

