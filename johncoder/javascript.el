;; Colorful Markers
(setq fixme-modes '(c++-mode c-mode emacs-lisp-mode js2-mode go-mode))
(make-face 'font-lock-fixme-face)
(make-face 'font-lock-study-face)
(make-face 'font-lock-important-face)
(make-face 'font-lock-question-face)
(make-face 'font-lock-note-face)
(mapc (lambda (mode)
        (font-lock-add-keywords
         mode
         '(("\\<\\(TODO\\)" 1 'font-lock-fixme-face t)
           ("\\<\\(STUDY\\)" 1 'font-lock-study-face t)
           ("\\<\\(IMPORTANT\\)" 1 'font-lock-important-face t)
           ("\\<\\(QUESTION\\)" 1 'font-lock-question-face t)
           ("\\<\\(NOTE\\)" 1 'font-lock-note-face t))))
      fixme-modes)
(modify-face 'font-lock-fixme-face "#D64C2A" nil nil t nil t nil nil)
(modify-face 'font-lock-study-face "Yellow" nil nil t nil t nil nil)
(modify-face 'font-lock-important-face "Yellow" nil nil t nil t nil nil)
(modify-face 'font-lock-question-face "#ffa500" nil nil t nil t nil nil)
(modify-face 'font-lock-note-face "#8ABB93" nil nil t nil t nil nil)

(setq js2-basic-offset 2)
;; JSON files are opened with js-mode
(add-hook 'js-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))

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

(add-to-list 'compilation-error-regexp-alist-alist
             '(eslint "^\\(\w+\\):\\([0-9]+\\):\\([0-9]+\\):.*$" 1 2 3))
(add-to-list 'compilation-error-regexp-alist 'eslint)

(add-to-list 'compilation-error-regexp-alist-alist
             '(jshint "^\\(.*\\): line \\([0-9]+\\), col \\([0-9]+\\), " 1 2 3))
(add-to-list 'compilation-error-regexp-alist 'jshint)

(defun find-root-git ()
  (locate-dominating-file default-directory ".git"))

(defun file-at-git-root (f)
  (concat (find-root-git) f))

(defun jshint-compile-command ()
  (concat
   "jshint " (file-at-git-root "")))

(defun eslint-compile-command ()
  (concat
   "(cd " (file-at-git-root "")
   " && eslint . --format unix --ignore-path ./.eslintignore)"))

(defun compile-javascript ()
  (cond
   ((file-exists-p (file-at-git-root ".jshintrc")) (jshint-compile-command))
   ((file-exists-p (file-at-git-root ".eslintrc.js")) (eslint-compile-command))
   ((file-exists-p (file-at-git-root ".eslintrc")) (eslint-compile-command))))

(add-hook 'js2-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
            (compile-javascript))))

;; TESTING
(defun test-javascript ()
  (concat "npm run test --prefix " (file-at-git-root "")))

(add-hook 'js2-mode-hook
          (lambda ()
            (set (make-local-variable 'testing-command)
                 (test-javascript))))

;; RUNNING

(defun npm-run ()
  (concat "npm start " (file-at-git-root "") " --no-color"))

(add-hook 'js2-mode-hook
          (lambda ()
            (set (make-local-variable 'running-command)
                 (npm-run))))
