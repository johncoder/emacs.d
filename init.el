(package-initialize)
(require 'package)
(require 'compile)
(require 'tls)

(setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
(set-language-environment 'utf-8)
(set-keyboard-coding-system 'utf-8-mac) ; For old Carbon emacs on OS X only
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(unless (eq system-type 'windows-nt)
  (set-selection-coding-system 'utf-8))
(prefer-coding-system 'utf-8)

;; Handle super-tabbify (TAB completes, shift-TAB actually tabs)
(setq dabbrev-case-replace t)
(setq dabbrev-case-fold-search t)
(setq dabbrev-upcase-means-case-search t)

;; Abbrevation expansion
(abbrev-mode 1)
;; TODO(john): Consider adding this key mapping
;; (define-key c++-mode-map "\t" 'dabbrev-expand)


;;;; PACKAGES
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(when (eq system-type 'windows-nt)
  (package-refresh-contents)) ; NOTE(john): on windows this solves some melpa issues

(when (eq system-type 'darwin)
  (put 'suspend-frame 'disabled t))

;; SEE(john): https://github.com/jwiegley/use-package for more information
(when (not (featurep 'use-package))
  (package-install 'use-package))

;; UI Packages
(use-package highlight-chars :ensure t)
;; (use-package zenburn-theme :ensure t)
;; (use-package monochrome-theme :ensure t)
;; (use-package greymatters-theme :ensure t)
;; (use-package phoenix-dark-mono-theme :ensure t)
;; (use-package sublime-themes :ensure t)
;; (use-package punpun-theme :ensure t)

;; SEE(john): http://www.lunaryorn.com/posts/center-buffer-text-in-emacs.html
;; (use-package visual-fill-column
;;   :ensure t
;;   :defer t
;;   :bind (("C-c t v" . visual-fill-column-mode))
;;   :init
;;   (dolist (hook '(visual-line-mode-hook
;;                   prog-mode-hook
;;                   text-mode-hook))
;;     (add-hook hook #'visual-fill-column-mode))
;;   :config (setq-default visual-fill-column-center-text t
;;                         visual-fill-column-width 120
;;                         visual-fill-column-fringes-outside-margins nil))

;; IDE Modes
(use-package js2-mode :ensure t)
(use-package js-comint :ensure t)
(use-package flycheck :ensure t)
;; (use-package flymake-jshint :ensure t)
(use-package go-mode :ensure t)
(use-package markdown-mode :ensure t)
(use-package handlebars-mode :ensure t)

;; Productivity
(use-package smart-comment :ensure t)
(use-package restclient :ensure t)
(use-package org :ensure t)
(use-package org-sync :ensure t)
(use-package magit :ensure t)
(use-package magit-popup :ensure t)

(unless (or (eq system-type 'darwin) (eq system-type 'windows-nt))
  (package-install 'exec-path-from-shell)
  (exec-path-from-shell-initialize))

;; Load Files
;; (require 'twotone-dark "~/.emacs.d/johncoder/twotone/twotone-dark.el")
(load-file "~/.emacs.d/johncoder/twotone/twotone-dark-theme.el")
(load-file "~/.emacs.d/johncoder/ui.el")
(load-file "~/.emacs.d/johncoder/org.el")
(load-file "~/.emacs.d/johncoder/cpp.el")
(load-file "~/.emacs.d/johncoder/javascript.el")
(load-file "~/.emacs.d/johncoder/go.el")
(load-file "~/.emacs.d/johncoder/keybindings.el")
(load-file "~/.emacs.d/johncoder/erc.el")

(unless (eq system-type 'windows-nt)
  (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
  (setq exec-path (append exec-path '("/usr/local/bin"))))

(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)

(setq-default indent-tabs-mode nil) ; default is \t, so disable!

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(setq compilation-read-command nil)

;; (setq-default flycheck-disabled-checkers
;;               (append flycheck-disabled checkers '(javascript-jshint)))

;; (add-hook 'after-init-hook #'global-flycheck-mode)

;;;; GNUS
(require 'gnus)
(setq user-mail-address "jnelson@johncoder.com"
      user-full-name "John Nelson")

(add-to-list 'gnus-secondary-select-methods '(nntp "news.gnus.org"))

;; Custom Variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   (vector "#c5c8c6" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#8abeb7" "#1d1f21"))
 '(fci-rule-color "#373b41")
 '(hl-sexp-background-color "#efebe9")
 '(js-indent-level 2)
 '(package-selected-packages
   (quote
    (use-package smart-comment restclient org-sync markdown-mode magit js2-mode js-comint highlight-chars handlebars-mode go-mode flycheck)))
 '(powerline-default-separator (quote wave))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(isearch-fail ((((class color)) (:background "#A12C0A"))))
 '(org-link ((t (:underline t)))))
