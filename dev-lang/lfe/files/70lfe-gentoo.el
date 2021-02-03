;;; lfe site-lisp configuration

(add-to-list 'load-path "@SITELISP@")

(autoload 'lfe-mode "lfe-mode"
  "Major mode for editing LFE code." t)
(autoload 'lfe-indent-function "lfe-indent"
  "Indent LFE." t)
(autoload 'inferior-lfe-mode "inferior-lfe"
  "Major mode for interacting with an inferior LFE process." t)
(autoload 'inferior-lfe "inferior-lfe"
  "Run an LFE process." t)
(autoload 'run-lfe "inferior-lfe"
  "Run an LFE process." t)

(add-to-list 'auto-mode-alist '("\\.lfe\\'" . lfe-mode) t)
