(setq inhibit-splash-screen t)
;; Configure package.el to include MELPA.

(require 'package)
(when (>= emacs-major-version 24)
  (require 'package)

  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
  ;; (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t )
  (package-initialize)
  (assq-delete-all 'org package--builtins)
  (assq-delete-all 'org package--builtin-versions)
)

;; Ensure that use-package is installed.
;; If use-package isn't already installed, it's extremely likely that this is a
;; fresh installation! So we'll want to update the package repository and
;; install use-package before loading the literate configuration.
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
(org-babel-load-file "~/.emacs.d/configuration.org")

