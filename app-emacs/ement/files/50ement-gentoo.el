;;; ement site-lisp configuration

(add-to-list 'load-path "/usr/share/emacs/site-lisp/ement")


;;; begin: forms written by `autoload-generate-file-autoloads'


;;;### (autoloads nil "ement" "ement.el" (0 0 0 0))
;;; Generated autoloads from ement.el

(autoload 'ement-connect "ement" "\
Connect to Matrix with USER-ID and PASSWORD, or using SESSION.
Interactively, with prefix, ignore a saved session and log in
again; otherwise, use a saved session if `ement-save-session' is
enabled and a saved session is available, or prompt to log in if
not enabled or available.

If URI-PREFIX is specified, it should be the prefix of the
server's API URI, including protocol, hostname, and optionally
the port, e.g.

  \"https://matrix-client.matrix.org\"
  \"http://localhost:8080\"

\(fn &key USER-ID PASSWORD URI-PREFIX SESSION)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ement" '("ement-")))

;;;***


;;;### (autoloads nil "ement-room-list" "ement-room-list.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from ement-room-list.el

(autoload 'ement-room-list "ement-room-list" "\
Show buffer listing joined rooms.
Calls `pop-to-buffer-same-window'.  Interactively, with prefix,
call `pop-to-buffer'.

\(fn &rest IGNORE)" t nil)

(defalias 'ement-list-rooms 'ement-room-list)

(autoload 'ement-room-list-auto-update "ement-room-list" "\
Automatically update the room list buffer.
Does so when variable `ement-room-list-auto-update' is non-nil.
To be called in `ement-sync-callback-hook'.

\(fn SESSION)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ement-room-list" '("ement-room-list-")))

;;;***


;;;### (autoloads nil "ement-room" "ement-room.el" (0 0 0 0))
;;; Generated autoloads from ement-room.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ement-room" '("ement-")))

;;;***


;;;### (autoloads nil "ement-notify" "ement-notify.el" (0 0 0 0))
;;; Generated autoloads from ement-notify.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ement-notify" '("ement-notify")))

;;;***


;;;### (autoloads nil "ement-api" "ement-api.el" (0 0 0 0))
;;; Generated autoloads from ement-api.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ement-api" '("ement-api-error")))

;;;***


;;;### (autoloads nil "ement-macros" "ement-macros.el" (0 0 0 0))
;;; Generated autoloads from ement-macros.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ement-macros" '("ement-")))

;;;***


;;; end: forms written by `autoload-generate-file-autoloads'
