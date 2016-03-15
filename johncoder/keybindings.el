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

;;;; TESTING
(defvar testing-command "echo No testing command configured!")

;; Credit: http://jakemccrary.com/blog/2013/08/10/emacs-capture-shell-command-output-in-temporary-buffer/
(defun execute-tests ()
  (interactive)
  (when (and (buffer-modified-p)
             (y-or-n-p (format "Save file %s? " (buffer-file-name))))
    (save-buffer))
  (with-output-to-temp-buffer "*automated tests*"
    (shell-command (concat "echo Running: " testing-command) "*automated tests*")
    (shell-command testing-command
                   "*automated tests*")
    (pop-to-buffer "*automated tests*")))

(global-set-key (kbd "C-,") 'imenu)
(global-set-key (kbd "C-S-A") 'select-to-beginning-of-line)
(global-set-key (kbd "C-<tab>") 'other-window)
(global-set-key (kbd "C-S-<tab>") 'other-window-prev)
(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "C-<f5>") 'next-error)
(global-set-key (kbd "C-S-<f5>") 'previous-error)
(global-set-key (kbd "M-<f5>") 'execute-tests)
