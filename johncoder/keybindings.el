(delete-selection-mode 1)
(global-set-key (kbd "C-,") 'imenu)

;; NOTE(john): Sucking at elisp, but here's window movement

(defvar window-dirs '(windmove-right windmove-down windmove-left windmove-up))

(defun clear-window-dirs ()
  (interactive)
  (setq window-dirs '(windmove-right windmove-down windmove-left windmove-up)))

(defun movewin-dirs-rotate ()
    (setq window-dirs
          (append
           (cdr window-dirs)
           (list (car window-dirs)))))

(defun movewin-dirs-rotate-reverse ()
  (setq window-dirs
        (append
         (last window-dirs)
         (butlast window-dirs))))

(defun movewin-dirs ()
  (interactive)
  (condition-case nil
      (progn (funcall (car window-dirs)) (movewin-dirs-rotate))
    (error (movewin-dirs-rotate))))

(defun movewin-dirs-reverse ()
  (interactive)
  (condition-case nil
      (progn (funcall (car window-dirs)) (movewin-dirs-rotate-reverse))
    (error (movewin-dirs-rotate-reverse))))

(global-set-key (kbd "C-<tab>") 'movewin-dirs)
(global-set-key (kbd "C-S-<tab>") 'movewin-dirs-reverse)
