;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Hizbullah Abdul Aziz Jabbar"
      user-mail-address "archbung@gmail.com")

(setq doom-font (font-spec :family "RobotoMono Nerd Font" :size 13 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "RobotoMono Nerd Font" :size 13))

(setq doom-theme 'doom-one)

(setq display-line-numbers-type t)


; Org
(setq org-directory "~/org/"
      +org-capture-todo-file "gtd.org")

; Coq
(after! evil
  (setq evil-want-abbrev-expand-on-insert-exit nil))

(after! company-coq
  (setq company-coq-disabled-features '(smart-subscripts prettify-symbols)))

(setq coq-compile-before-require t)
