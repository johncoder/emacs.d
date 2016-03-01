(menu-bar-mode -1)
(tool-bar-mode -1)
(set-face-attribute 'default nil
                    :family "Consolas" :height 140)
(global-hl-line-mode 1)
(set-face-background 'hl-line "#444444")
(load-theme 'zenburn t)
(setq column-number-mode t)
(defface extra-whitespace-face
   '((t (:background "pale green")))
   "Used for tabs and such.")
(defvar my-extra-keywords
  '(("\t" . 'extra-whitespace-face)))
