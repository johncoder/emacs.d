(setq c-default-style "bsd")
(setq-default c-basic-offset 4)

;; COMPILATION

(defun build-bat-compile-command ()
  (file-at-git-root "build.bat"))

(when (eq system-type 'windows-nt)
  (add-hook 'c-mode-common-hook
            (lambda ()
              (set (make-local-variable 'compile-command)
                   (build-bat-compile-command)))))

;;(add-hook 'c++-mode-hook
;;          (lambda ()
;;            (set (make-local-variable 'compile-command)
;;                 (build-bat-compile-command))))
