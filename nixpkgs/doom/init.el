;;; init.el -*- lexical-binding: t; -*-

(doom! :completion
       company
       ivy

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

       :checkers
       syntax
       spell
       grammar

       :tools
       (eval +overlay)
       lookup
       magit

       :os
       (:if IS-MAC macos)

       :lang
       coq
       emacs-lisp
       ledger
       markdown
       (org +journal +pandoc +pomodoro +roam)
       sh

       :config
       (default +bindings +smartparens))
