(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; FONTS
(defun font-existsp (font)
  (if (null (x-list-fonts font))
      nil t))

(defun use-font (fonts)
  (if (font-existsp (car fonts))
      (set-face-attribute 'default nil
                          :family (car fonts) :height 120)
      (use-font (cdr fonts))))

(unless (eq system-type 'windows-nt)
  (use-font '("Input" "Consolas")))

(when (eq system-type 'windows-nt)
  (use-font '("Consolas")))

(global-hl-line-mode 1)

;;; NOTE(john): This may not be the right place for this. Consider
;;; putting in init.el. Could be more helpful to check and see how
;;; many window splits there are before calling it.
(split-window-right)

(add-to-list 'custom-theme-load-path "~/.emacs.d/johncoder/twotone")
;;(load-theme 'greymatters t)
;;(load-theme 'zenburn t)
;;(load-theme 'monochrome t)
;; (load-theme 'phoenix-dark-mono t)
;; (load-theme 'punpun-dark t)
;; (load-theme 'punpun-light t)
(load-theme 'twotone-dark t)

;;; NOTE(john): See https://github.com/owainlewis/emacs-color-themes for more sublime themes
;;(load-theme 'dorsey t)
;;(load-theme 'granger t)
;;(load-theme 'brin t)


(set-face-background 'hl-line "#222222")
(setq column-number-mode t)
(defface extra-whitespace-face
   '((t (:background "pale green")))
   "Used for tabs and such.")
(defvar my-extra-keywords
  '(("\t" . 'extra-whitespace-face)))

;; Custom Colors
(require 'paren)
(set-face-background 'show-paren-match (face-foreground 'default))
(set-face-foreground 'show-paren-match (face-background 'default))
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

(set-cursor-color "#88C9F0")
(set-face-attribute 'region nil :background "#387498")

(set-face-foreground 'isearch "#cccccc")
(set-face-background 'isearch "#77597E")
(custom-set-faces '(isearch-fail ((((class color)) (:background "#A12C0A")))))

(require 'ansi-color)
(defun display-ansi-colors ()
  (interactive)
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))

;; Window Management
(defun transpose-windows ()
  "Transpose two windows.  If more or less than two windows are visible, error."
  (interactive)
  (unless (= 2 (count-windows))
    (error "There are not 2 windows."))
  (let* ((windows (window-list))
         (w1 (car windows))
         (w2 (nth 1 windows))
         (w1b (window-buffer w1))
         (w2b (window-buffer w2)))
    (set-window-buffer w1 w2b)
    (set-window-buffer w2 w1b)))
;;; NOTE(john): Use transpose-windows with C-` for a while and see if
;;; it is better without (next-multiframe-window)
