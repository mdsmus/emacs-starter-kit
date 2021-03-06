;;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;
;; "Emacs outshines all other editing software in approximately the
;; same way that the noonday sun does the stars. It is not just bigger
;; and brighter; it simply makes everything else vanish."
;; -Neal Stephenson, "In the Beginning was the Command Line"

;; Benchmarking
(defvar *benchmark-init-p* t)
(defvar *emacs-load-start* (current-time))

;; Turn off mouse interface early in startup to avoid momentary display
;; You really don't need these; trust me.
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Utilities functions
(defun calc-startup-time ()
  (flet ((sum-time (time) (apply #'+ (subseq time 0 2))))
    (- (sum-time (current-time))
       (sum-time *emacs-load-start*))))

(defun dotemacs (&rest things)
  "Concatenate a bunch of things to emacs' configuration directory. "
  (apply #'concat dotfiles-dir things))

;; Load path etc.
(setq dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))
(setq elpa-to-submit-dir (dotemacs "elpa-to-submit/"))
(setq tools-dir (dotemacs "tools/"))
(setq snippet-dir (dotemacs "my-snippets/"))

(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path elpa-to-submit-dir)
(setq autoload-file (dotemacs "loaddefs.el"))
(setq package-user-dir (dotemacs "elpa"))
(setq custom-file (dotemacs "custom.el"))

;; Load up ELPA, the package manager
(require 'package)
(setq elpa-source-list '(("technomancy" . "http://repo.technomancy.us/emacs/")
                         ("elpa" . "http://tromey.com/elpa/")))

(dolist (source elpa-source-list) (add-to-list 'package-archives source t))
(package-initialize)
(require 'starter-kit-elpa)

;; These should be loaded on startup rather than autoloaded on demand
;; since they are likely to be used in every session
(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)
(require 'elscreen)
;;(require 'autopair)
;;(autopair-global-mode)
(electric-pair-mode t)

(setq *use-highline-current-line* t
      *use-save-place* t
      *use-whitespace* t
      *use-paredit* t
      *use-watchwords* t
      *use-idle-highlight* t
      *use-line-numbers* t
      *use-save-as-executable* t
      *use-delete-trailing-whitespace* nil
      )

;; Load custom snippets

(yas/load-directory snippet-dir)

;; Load up starter kit customizations
(require 'starter-kit-defuns)
(require 'starter-kit-bindings)
(require 'starter-kit-misc)
(require 'starter-kit-registers)
(require 'starter-kit-eshell)
(require 'starter-kit-lisp)
(require 'starter-kit-perl)
(require 'starter-kit-ruby)
(require 'starter-kit-python)
(require 'starter-kit-lilypond)
(require 'starter-kit-js)
;; FIXME global debug-on-error
;; (require 'starter-kit-nxhtml)

(if (fboundp 'regen-autoloads) (regen-autoloads))
(load custom-file 'noerror)

;; You can keep system- or user-specific customizations here:
(loop for name in (list system-name user-login-name)
      for file = (dotemacs name ".el") do
      (if (file-exists-p file) (load file)))

(let ((user-specific-dir (dotemacs user-login-name)))
  (if (file-exists-p user-specific-dir)
      (mapc #'load (directory-files user-specific-dir nil ".*el$"))))

;; Benchmarking
(if *benchmark-init-p*
    (message "My .emacs loaded in %ds" (calc-startup-time)))
