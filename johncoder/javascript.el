(setq js2-basic-offset 2)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(add-hook 'js2-mode-hook
          (lambda ()
            (font-lock-add-keywords nil my-extra-keywords)))

;; JavaScript command-interpreter
(require 'js-comint) ; http://js-comint-el.sourceforge.net/
;; NOTE(john): From https://nodejs.org/api/repl.html#repl_repl
(setenv "NODE_NO_READLINE" "1")
(setq inferior-js-program-command "/usr/bin/java org.mozilla.javascript.tools.shell.Main")
(setq inferior-js-program-command "node --use-strict --interactive")
(setq inferior-js-mode-hook
      (lambda ()
	(ansi-color-for-comint-mode-on)))

;; COMPILATION
(add-to-list
 'compilation-error-regexp-alist-alist
 '(jshint "^\\(.*\\): line \\([0-9]+\\), col \\([0-9]+\\), " 1 2 3))

(add-to-list 'compilation-error-regexp-alist 'jshint)

(defun find-root-git ()
  (locate-dominating-file default-directory ".git"))

(defun jshint-compile-command ()
  (concat "jshint " (confat (find-root-git) "")))

;; TODO(john): make this flexible to invoke jshint, jslint, eslint
;; based purely on what dotfiles it finds in the root git folder.
(add-hook 'js2-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
            (compile-js-recursive))))
