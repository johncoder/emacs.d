(menu-bar-mode -1)
(tool-bar-mode -1)
(set-face-attribute 'default nil
                    :family "Consolas" :height 140)
(global-hl-line-mode 1)
(add-to-list 'custom-theme-load-path "~/.emacs.d/johncoder/themes")
;;(load-theme 'greymatters t)
;;(load-theme 'zenburn t)
;;(load-theme 'monochrome t)
(load-theme 'phoenix-dark-mono t)

(set-face-background 'hl-line "#222222")
(setq column-number-mode t)
(defface extra-whitespace-face
   '((t (:background "pale green")))
   "Used for tabs and such.")
(defvar my-extra-keywords
  '(("\t" . 'extra-whitespace-face)))

(require 'paren)
(set-face-background 'show-paren-match (face-foreground 'default))
(set-face-foreground 'show-paren-match (face-background 'default))
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

(set-cursor-color "#88C9F0")
(set-face-attribute 'region nil :background "#387498")
