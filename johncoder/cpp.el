(setq c-default-style "bsd")
(setq-default c-basic-offset 4)

;; COMPILATION

(defun build-bat-compile-command ()
  (file-at-git-root "build.bat"))

(defun build-sh-compile-command ()
  (file-at-git-root "build.sh"))

(when (eq system-type 'windows-nt)
  (add-hook 'c-mode-common-hook
            (lambda ()
              (set (make-local-variable 'compile-command)
                   (build-bat-compile-command)))))

(when (eq system-type 'darwin)
  (add-hook 'c-mode-common-hook
            (lambda ()
              (set (make-local-variable 'compile-command)
                   (build-sh-compile-command)))))
