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
       vc-tilde-fringe
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
       (org +journal +pandoc +pomodoro +roam)

       :config
       (default +binding +smartparens))
