  (defun forward-word-correctly (&optional n)
    "Jump forward a word at a time"
    (interactive "P")
    (search-forward-regexp "[][[()_@#A-Za-z0-9&\\*\\\-\\.\\$\-]+")
                                          ; [A-Za-z0-9-]+"
    )

  (defun backward-word-correctly (&optional n)
    "Jump backward a word at a time"
    (interactive "P")
    (let (i)
      (search-backward-regexp "[ ]+")
                                          ;    (search-backward-regexp "[A-Za-z0-9_=)]+")
                                          ;    (search-backward-regexp "[A-Za-z0-9_=\-\\)\\(]+")
      )
    )

  (global-set-key "\C-xg" 'goto-line)
  (global-set-key "\C-b" 'backward-kill-word)
  (global-set-key "\C-n" 'kill-word)
  (global-set-key "\C-f" 'backward-word-correctly)
  (global-set-key "\M-s" 'search-forward-regexp)
  (global-set-key "\C-g" 'forward-word-correctly)
                                          ; New binding to try out
  (global-set-key "\M-b" 'backward-sexp)
  (global-set-key "\M-n" 'forward-sexp)

  (global-set-key "\C-cc" 'comment-region)
  (global-set-key [(control left)]  'backward-word-correctly)
  (global-set-key [(control right)] 'forward-word-correctly)
