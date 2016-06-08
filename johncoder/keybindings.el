(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

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

(defun move-and-center ()
  (interactive)
  (forward-line)
  (scroll-up 1))

(defun move-and-center-reverse ()
  (interactive)
  (forward-line -1)
  (scroll-up -1))

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

;;;; RUNNING
(defvar running-command "echo No running command configured!")
(defvar running-process nil)
(defvar running-process-buffer-name "*run application*")

(defun execute-run-command (run-command)
  (interactive
   (list (read-string (format "Run Command (default: %s): " running-command))))
  (when (not (eq (length run-command) 0))
    (setq running-command run-command))
  (when (and (buffer-modified-p)
             (y-or-n-p (format "Save file %s? " (buffer-file-name))))
    (save-buffer))
  (when (not (eq (process-status "run application") nil))
    (kill-process running-process)
    (setq running-process nil))
  (with-output-to-temp-buffer running-process-buffer-name
    (setq running-process
          (start-process-shell-command
           "run application" running-process-buffer-name running-command))
    (pop-to-buffer running-process-buffer-name)))

(defun kill-running-process ()
  (interactive)
  (kill-process running-process))

;;;; SHELL STUFF
;;;; TODO(john): add cases for platforms (darwin, windows-nt)
(defvar default-local-browser-port "80")
(defun open-browser (port)
  (interactive
   (list (read-string (format "Open Browser to (default-local-browser-port: %s) http://localhost:" default-local-browser-port))))
  (when (not (eq (length port) 0))
    (setq default-local-browser-port port))
  (shell-command
   (concat "open -a 'Google Chrome.app' 'http://localhost:'"
           default-local-browser-port)))

(global-set-key (kbd "C-|") 'magit-status)
(global-set-key (kbd "C-,") 'imenu)
(global-set-key (kbd "C-S-A") 'select-to-beginning-of-line)
(global-set-key (kbd "C-<tab>") 'other-window)
(global-set-key (kbd "C-S-<tab>") 'other-window-prev)
(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "C-<f5>") 'next-error)
(global-set-key (kbd "C-S-<f5>") 'previous-error)
(global-set-key (kbd "M-<f5>") 'execute-tests)
(global-set-key (kbd "<f8>") 'execute-run-command)
(global-set-key (kbd "C-S-<f8>") 'kill-running-process)
(global-set-key (kbd "<f7>") 'open-browser)
(global-set-key (kbd "M-<RET>") 'move-and-center)
(global-set-key (kbd "M-\\") 'move-and-center-reverse)
(require 'smart-comment)
(global-set-key (kbd "M-;") 'smart-comment)
(global-set-key (kbd "C-<f11>") 'toggle-frame-maximized)
(global-set-key (kbd "C-`") 'transpose-windows)
