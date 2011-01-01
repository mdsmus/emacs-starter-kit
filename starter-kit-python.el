;;; starter-kit-python.el --- Some helpful Python code
;;
;; Part of the Emacs Starter Kit

(require 'ipython)

(global-set-key "\C-ch" 'pylookup-lookup)

(setq pylookup-program (concat tools-dir "pylookup.py"))
(setq pylookup-db-file (concat tools-dir "pylookup.db"))
;; FIXME: only works on ubuntu/debian
(defvar python-doc-dir "file:///usr/share/doc/python2.6-doc/html")

(defun python-update-documentation-table ()
  (interactive)
  (start-process "pylookup" "*pylookup*" pylookup-program "-u"
                 python-doc-dir "-d" pylookup-db-file))

(unless (file-exists-p pylookup-db-file)
  (python-update-documentation-table))

(add-hook 'python-mode-hook 'run-coding-hook)

(add-hook 'ipython-mode-hook
          #'(lambda () (define-key py-mode-map (kbd "M-<tab>") 'anything-ipython-complete)))

(add-hook 'py-shell-hook
          (lambda () (local-set-key (kbd "M-<tab>") 'anything-ipython-complete)))

(provide 'starter-kit-python)
;; starter-kit-ruby.el ends here
