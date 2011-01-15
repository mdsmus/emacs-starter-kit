(setq *use-highline-current-line* nil
      *use-delete-trailing-whitespace* t
      *use-idle-highlight* nil)

(setq visible-bell nil
      browse-url-browser-function 'browse-url-firefox)

(if (equal window-system 'x)
    (set-default-font "Consolas-12"))

(setq user-mail-address "pedro.kroger@gmail.com"
      user-full-name "Pedro Kroger")

(menu-bar-mode t)

;;; start emacsclient
;;(server-start)

(setq edit-server-new-frame nil)
(edit-server-start)
