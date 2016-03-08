(defun other-window-prev ()
  (interactive)
  (other-window -1))

(add-hook 'org-mode-hook
          '(lambda ()
             (define-key org-mode-map [(control tab)] nil)))

(defun select-to-beginning-of-line ()
  (interactive)
  (set-mark-command nil)
  (beginning-of-line))

(delete-selection-mode 1)
(global-set-key (kbd "C-,") 'imenu)
(global-set-key (kbd "C-S-A") 'select-to-beginning-of-line)
(global-set-key (kbd "C-<tab>") 'other-window)
(global-set-key (kbd "C-S-<tab>") 'other-window-prev)
