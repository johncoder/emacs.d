(add-hook 'before-save-hook 'gofmt-before-save)

;;;; COMPILATION

(defun wrap-go-tool (c)
  (concat
   "pushd "
   (file-at-git-root "")
   " && "
   c
   " && popd"))

(defun compile-go ()
  (wrap-go-tool "go build"))

(add-hook 'go-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
            (compile-go))))

;; TESTING
(defun test-go ()
  (wrap-go-tool "go test"))

(add-hook 'go-mode-hook
          (lambda ()
            (setq tab-width 4)
            (set (make-local-variable 'testing-command)
                 (test-go))))
