;;; starter-kit-lilypond.el --- Some helpful Python code
;;
;; Part of the Emacs Starter Kit

(autoload 'LilyPond-mode "lilypond-mode" nil t)
(setq auto-mode-alist (cons '("\\.ly$" . LilyPond-mode) auto-mode-alist))
(add-hook 'LilyPond-mode-hook (lambda () (turn-on-font-lock)))

(add-to-list 'auto-mode-alist '("\\.lytex$" . latex-mode))
(modify-coding-system-alist 'file "\\.ly" 'utf-8)

(provide 'starter-kit-lilypond)
;; starter-kit-ruby.el ends here
