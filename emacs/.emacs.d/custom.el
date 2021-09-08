(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#000000" "#d54e53" "#b9ca4a" "#e7c547" "#7aa6da" "#c397d8" "#70c0b1" "#eaeaea"))
 '(beacon-color "#d54e53")
 '(column-number-mode t)
 '(compilation-message-face 'default)
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes '(sanityinc-tomorrow-bright))
 '(custom-safe-themes
   '("82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" default))
 '(epa-file-cache-passphrase-for-symmetric-encryption t t)
 '(fci-rule-color "#424242")
 '(flycheck-color-mode-line-face-to-color 'mode-line-buffer-id)
 '(frame-background-mode 'dark)
 '(helm-completion-style 'emacs)
 '(highlight-changes-colors '("#d33682" "#6c71c4"))
 '(highlight-symbol-colors
   '("#eef6d970af00" "#cef5e0cccfbb" "#fd55c91cb29c" "#dadbd2efdc17" "#e0a3de02afa1" "#f84bcba1ad99" "#d28bd9ebdf8a"))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   '(("#eee8d5" . 0)
     ("#b3c34d" . 20)
     ("#6ccec0" . 30)
     ("#74adf5" . 50)
     ("#e1af4b" . 60)
     ("#fb7640" . 70)
     ("#ff699e" . 85)
     ("#eee8d5" . 100)))
 '(hl-bg-colors
   '("#e1af4b" "#fb7640" "#ff6849" "#ff699e" "#8d85e7" "#74adf5" "#6ccec0" "#b3c34d"))
 '(hl-fg-colors
   '("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3"))
 '(hl-paren-colors '("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900"))
 '(lsp-ui-doc-border "#586e75")
 '(markdown-command "pandoc ")
 '(mu4e-get-mail-command "mbsync jdamon-gmail")
 '(mu4e-refile-folder "/jdamon-gmail/archive")
 '(nrepl-message-colors
   '("#dc322f" "#cb4b16" "#b58900" "#5b7300" "#b3c34d" "#0061a8" "#2aa198" "#d33682" "#6c71c4"))
 '(ob-ipython-command "ipython")
 '(org-agenda-files
   '("/home/jdamon/Projects/org/personal.org" "/home/jdamon/Projects/org/archive.org" "/home/jdamon/Projects/org/todo.org" "/home/jdamon/Projects/org/work_projects.org" "/home/jdamon/Dropbox/inbox.org" "/home/jdamon/Projects/org/gtd.org" "/home/jdamon/Projects/org/journal.org"))
 '(org-agenda-todo-ignore-deadlines 'far)
 '(org-agenda-todo-ignore-scheduled 'all)
 '(org-agenda-todo-ignore-timestamp 'future)
 '(org-agenda-todo-list-sublevels nil)
 '(org-babel-python-command "python3")
 '(org-checkbox-hierarchical-statistics nil)
 '(org-format-latex-options
   '(:foreground "Black" :background "White" :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(org-id-link-to-org-use-id t)
 '(org-journal-dir "~/Projects/org/Roam/daily" nil nil "Customized with use-package org-journal")
 '(org-journal-enable-agenda-integration t)
 '(org-journal-file-format "%Y-%m.org")
 '(org-journal-time-format "")
 '(org-lowest-priority 68)
 '(org-modules
   '(org-habit org-bbdb org-bibtex org-ctags org-docview org-gnus org-info org-irc org-mhe org-rmail org-w3m org-learn))
 '(org-priority-lowest 68)
 '(org-priority-start-cycle-with-default t)
 '(org-roam-completion-everywhere t)
 '(org-roam-completion-system 'ivy)
 '(org-roam-directory "~/Projects/org/Roam")
 '(org-tags-match-list-sublevels nil)
 '(package-selected-packages
   '(promise doct helm-bibtexkey biblio org-roam org-ref perspective doom-modeline diminish helm-bibtex magit org-anki notmuch org-chef ox-hugo ob-ess-julia ob-ipython clipboard-collector org-download org-gcal org-roam-bibtex bitbake windresize org-caldav ox-gfm mu4e-alert ess ob-go ob-coffeescript yasnippet-snippets yasnippet highlight-doxygen all-the-icons flycheck-kotlin ledger-mode command-log-mode color-theme-sanityinc-tomorrow sanityinc-tomorrow-night solarized-theme deft ivy helm-org-rifle anki-editor spice-mode projectile forge dumb-jump ag rspec-mode chruby moody org-plus-contrib gnu-elpa-keyring-update org-journal kotlin-mode ensime cedit cdlatex ledger-import flycheck-ledger org-babel-eval-in-repl graphviz-dot-mode dot-mode org-drill-table dash yaml-mode scala-mode polymode passthword org-bullets org neotree markdown-mode json-mode groovy-mode gradle-mode gitignore-mode color-theme-modern cmake-mode chess bind-key auto-complete auctex))
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(send-mail-function 'smtpmail-send-it)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   '((20 . "#d54e53")
     (40 . "#e78c45")
     (60 . "#e7c547")
     (80 . "#b9ca4a")
     (100 . "#70c0b1")
     (120 . "#7aa6da")
     (140 . "#c397d8")
     (160 . "#d54e53")
     (180 . "#e78c45")
     (200 . "#e7c547")
     (220 . "#b9ca4a")
     (240 . "#70c0b1")
     (260 . "#7aa6da")
     (280 . "#c397d8")
     (300 . "#d54e53")
     (320 . "#e78c45")
     (340 . "#e7c547")
     (360 . "#b9ca4a")))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   '(unspecified "#fdf6e3" "#eee8d5" "#a7020a" "#dc322f" "#5b7300" "#859900" "#866300" "#b58900" "#0061a8" "#268bd2" "#a00559" "#d33682" "#007d76" "#2aa198" "#657b83" "#839496"))
 '(window-divider-mode nil)
 '(xterm-color-names
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642"])
 '(xterm-color-names-bright
   ["#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36"])
 '(xterm-mouse-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:height 0.85))))
 '(mode-line-inactive ((t (:height 0.85))))
 '(org-agenda-current-time ((t (:foreground "chartreuse"))))
 '(org-agenda-done ((t (:foreground "sea green"))))
 '(org-done ((t (:foreground "sea green" :weight bold))))
 '(org-level-4 ((t (:foreground "light goldenrod"))))
 '(org-priority ((t (:foreground "light goldenrod"))))
 '(org-scheduled ((t (:foreground "light salmon"))))
 '(org-scheduled-today ((t (:foreground "light goldenrod"))))
 '(org-time-grid ((t (:foreground "PaleGreen4"))))
 '(org-warning ((t (:foreground "salmon" :weight bold)))))
