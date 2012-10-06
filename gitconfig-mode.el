;;; gitconfig-mode.el --- Major mode for editing .gitconfig files
;;; -*- coding: utf-8; lexical-binding: t -*-

;; Copyright (c) 2012 Sebastian Wiesner <lunaryorn@gmail.com>
;;
;; Author: Sebastian Wiesner <lunaryorn@gmail.com>
;; URL: https://github.com/lunaryorn/gitconfig-mode
;; Version: 0.1
;; Keywords: convenience vc git

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify it under
;; the terms of the GNU General Public License as published by the Free Software
;; Foundation; either version 2 of the License, or (at your option) any later
;; version.

;; This program is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
;; FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
;; details.

;; You should have received a copy of the GNU General Public License along with
;; this program; if not, write to the Free Software Foundation, Inc., 51
;; Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

;;; Commentary:

;; A major mode for editing .gitconfig files.

;;; Code:

(require 'conf-mode)

(defun gitconfig-indent-line ()
  "Indent the current line."
  (interactive)
  (beginning-of-line)
  (delete-horizontal-space)
  (unless (looking-at "^\\[.*\\]\s*$")
    (insert-tab)
    (back-to-indentation)))

(defvar gitconfig-mode-syntax-table
  (let ((table (make-syntax-table conf-unix-mode-syntax-table)))
    ;; ; is a comment in .gitconfig
    (modify-syntax-entry ?\; "<" table)
    table)
  "Syntax table to use in .gitconfig buffers.")

;;;###autoload
(define-derived-mode gitconfig-mode conf-unix-mode "Gitconfig"
  "A major mode for editing .gitconfig files."
  ;; .gitconfig is indented with tabs only
  (setq indent-tabs-mode t)
  (set (make-local-variable 'indent-line-function)
       'gitconfig-indent-line))

;;;###autoload
(setq auto-mode-alist
      (append '(("/\\.gitconfig\\'" . gitconfig-mode)
                ("/\\.git/config\\'" . gitconfig-mode))
              auto-mode-alist))

(provide 'gitconfig-mode)

;;; gitconfig-mode.el ends here