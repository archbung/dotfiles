;;; init.el -*- lexical-binding: t; -*-

(doom! :completion
       company
       vertico

       :ui
       doom
       doom-dashboard
       doom-quit
       hl-todo
       modeline
       ophints
       (popup +defaults)
       vc-gutter
       vi-tilde-fringe
       workspaces
       zen

       :editor
       (evil +everywhere)
       file-templates
       fold
       snippets

       :emacs
       dired
       electric
       undo
       vc

       :term
       vterm

       :checkers
       syntax
       (spell +flyspell)
       grammar

       :tools
       editorconfig
       (eval +overlay)
       lookup
       magit

       :os
       (:if IS-MAC macos)

       :lang
       coq
       emacs-lisp
       latex
       ledger
       markdown
       nix
       (org +journal +pandoc +pomodoro +roam)
       sh

       :config
       (default +bindings +smartparens))
