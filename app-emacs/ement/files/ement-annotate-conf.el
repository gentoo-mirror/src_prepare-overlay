;; -*- lexical-binding: t -*-

(require 'rx)

(defvar ement--pantalaimon-conf-verbose (member "--verbose" command-line-args))

(defun ement--pantalaimon-conf-message (format-string &rest args)
  (when ement--pantalaimon-conf-verbose
    (apply #'message format-string args)))

(defmacro with-no-messages (&rest body)
  (declare (indent 0))
  `(progn
     (advice-add 'message :around #'ignore)
     (unwind-protect (progn ,@body)
       (advice-remove 'message #'ignore))))

(defun ement--pantalaimon-latest-doc-dir ()
  (car
   (last
    (directory-files "/usr/share/doc/" t (rx string-start "pantalaimon")))))

(defun ement--pantalaimon-annotate (pantalaimon-conf-file)
  (let ((count 0)
        (pantalaimon-options-help
         (ignore-errors
           (with-no-messages
             (find-file-noselect
              (nth 0 (directory-files (ement--pantalaimon-latest-doc-dir)
                                      t (rx string-start "pantalaimon.5.md")
                                      t)))))))
    (if (not pantalaimon-options-help) (message "Can't find pantalaimon doc file to annotate pantalaimon config")
      (ement--pantalaimon-conf-message
       "Annotating file %s..." pantalaimon-conf-file)
      (let ((annotations (get-buffer-create " *annotations*")))
        (with-current-buffer annotations (buffer-disable-undo))
        ;; annotations need to be reformatted in their own buffer
        ;; because md syntax is different from conf syntax
        (defun ement--pantalaimon-conf-insert-annotation (key &optional buffer)
          (setq buffer (or buffer (current-buffer)))
          (with-current-buffer pantalaimon-options-help
            (save-excursion
              (goto-char (point-min))
              (if (not (re-search-forward (rx line-start "**" (literal key) "**"
                                              line-end)
                                          nil t))
                  (progn
                    (ement--pantalaimon-conf-message
                     "Can't find annotation for key %s" key)
                    nil)
                (re-search-forward (rx (zero-or-more whitespace)) nil t)
                (if (not (looking-at-p (rx ?\>)))
                    (progn (ement--pantalaimon-conf-message
                            "Unexpected annotation format for key %s" key)
                           nil)
                  (let ((start (point))
                        (end (re-search-forward
                              (rx line-start
                                  (zero-or-more whitespace) line-end)
                              nil t)))
                    (with-current-buffer annotations
                      (erase-buffer)
                      (insert-buffer-substring-no-properties
                       pantalaimon-options-help start end)
                      (goto-char (point-min))
                      (while (re-search-forward (rx line-start ?\>) nil t)
                        (delete-backward-char 1)
                        (insert ?\#))))
                  (with-current-buffer buffer
                    (insert-buffer-substring-no-properties annotations))
                  t)))))
        (with-current-buffer (find-file-noselect pantalaimon-conf-file)
          (goto-char (point-min))
          (let ((maybe-fail-ungracefully
                 (let ((count 0))
                   (lambda ()
                     (when (>= (setq count (1+ count)) 10000)
                       (error "Annotating config failed ungracefully"))))))
            (while (not (= (point-max) (point)))
              ;; These loops are not very safe
              ;; todo: maybe rewrite with save-restriction
              (funcall maybe-fail-ungracefully)
              (when (looking-at (rx line-start
                                    (group (one-or-more alphabetic))
                                    (zero-or-one ?\s) ?\=))
                (let ((key (match-string-no-properties 1)))
                  (when ement--pantalaimon-conf-verbose
                    "Annotating option %s..." key)
                  (beginning-of-line)
                  (open-line 1)
                  (when (ement--pantalaimon-conf-insert-annotation key)
                    (ement--pantalaimon-conf-message "Done")))
                (while (looking-at-p (rx (or whitespace line-end)))
                  (funcall maybe-fail-ungracefully)
                  (delete-char 1)))
              (next-logical-line)
              (while (looking-at-p (rx line-start ?\#))
                (funcall maybe-fail-ungracefully)
                (next-logical-line))
              (open-line 1)
              (next-logical-line)))
          (save-buffer))
        (kill-buffer annotations)))))

(ement--pantalaimon-annotate (expand-file-name "pantalaimon.conf"
                                               (getenv "S")))
