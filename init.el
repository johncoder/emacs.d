(package-initialize)
(require 'package)
(require 'compile)

;; TODO(john): Consider adding code to determine OS.

;;;; PACKAGES
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(when (eq system-type 'windows-nt)
  (package-refresh-contents)) ; NOTE(john): on windows this solves some melpa issues

;; NOTE(john): This should be idempotent, and allow sync across machines
;; SEE: http://emacs.stackexchange.com/questions/408/synchronize-packages-between-different-machines
;; To install one-off packages, use:
;; (package-install 'package-name)
(mapc #'package-install
      (append '(use-package)
              ;; UI
              '(zenburn-theme highlight-chars)
              '(monochrome-theme greymatters-theme phoenix-dark-mono-theme)
              '(smart-mode-line powerline spaceline)
              ;; IDE Modes
              '(js2-mode js-comint flymake-jshint)
              '(go-mode)
              '(markdown-mode handlebars-mode)
              '(rainbow-mode)
              ;; Productivity
              '(org org-sync)
              '(magit magit-popup)))

;; Load Files
(load-file "~/.emacs.d/johncoder/ui.el")
(load-file "~/.emacs.d/johncoder/org.el")
(load-file "~/.emacs.d/johncoder/cpp.el")
(load-file "~/.emacs.d/johncoder/javascript.el")
(load-file "~/.emacs.d/johncoder/go.el")
(load-file "~/.emacs.d/johncoder/keybindings.el")

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)

(setq-default indent-tabs-mode nil) ; default is \t, so disable!

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(setq compilation-read-command nil)

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
 '(js2-basic-offset 2)
 '(powerline-default-separator (quote wave))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
