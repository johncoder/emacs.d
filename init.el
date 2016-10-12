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

;;;; PACKAGES
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(when (eq system-type 'windows-nt)
  (package-refresh-contents)) ; NOTE(john): on windows this solves some melpa issues

(when (eq system-type 'darwin)
  (put 'suspend-frame 'disabled t))

;; NOTE(john): This should be idempotent, and allow sync across machines
;; SEE: http://emacs.stackexchange.com/questions/408/synchronize-packages-between-different-machines
;; To install one-off packages, use:
;; (package-install 'package-name)
(mapc #'package-install
      (append '(use-package)
              ;; UI
              '(zenburn-theme highlight-chars)
              '(monochrome-theme greymatters-theme phoenix-dark-mono-theme sublime-themes)
              '(smart-mode-line powerline spaceline)
              ;; IDE Modes
              '(js2-mode js-comint flycheck) ;; flymake-jshint
              '(go-mode)
              '(markdown-mode handlebars-mode)
              '(smart-comment)
              ;; Productivity
              '(restclient)
              '(org org-sync)
              '(magit magit-popup)))

;; Load Files
(load-file "~/.emacs.d/johncoder/ui.el")
(load-file "~/.emacs.d/johncoder/org.el")
(load-file "~/.emacs.d/johncoder/cpp.el")
(load-file "~/.emacs.d/johncoder/javascript.el")
(load-file "~/.emacs.d/johncoder/go.el")
(load-file "~/.emacs.d/johncoder/keybindings.el")
(load-file "~/.emacs.d/johncoder/erc.el")

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)

(setq-default indent-tabs-mode nil) ; default is \t, so disable!

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(setq compilation-read-command nil)

(setq-default flycheck-disabled-checkers
              (append flycheck-disabled checkers '(javascript-jshint)))

(add-hook 'after-init-hook #'global-flycheck-mode)

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
 '(js2-basic-offset 2 t)
 '(package-selected-packages
   (quote
    (flycheck restclient magit-popup org js2-mode powerline zenburn-theme use-package tao-theme sublime-themes spacemacs-theme spaceline spacegray-theme smart-mode-line smart-comment rainbow-mode phoenix-dark-mono-theme paredit-everywhere org-sync mustard-theme monochrome-theme markdown-mode magit json-snatcher json-reformat js-comint highlight-chars handlebars-mode greymatters-theme go-mode flymake-jshint ac-js2)))
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
