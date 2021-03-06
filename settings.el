(setq max-lisp-eval-depth 10000)


;; remove window decoration
(when window-system
  (tooltip-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (set-face-inverse-video-p 'vertical-border nil)
  (scroll-bar-mode -1))

;; encoding
(set-language-environment "UTF-8")
;; (setenv "LANG" "en_US.UTF-8")
(setenv "PYTHONIOENCODING" "utf-8")

(setq create-lockfiles nil)

;; bug emacs 27
;; (require 'semantic/db-file)
;; (advice-add 'semantic-idle-scheduler-function :around #'ignore)

(setq custom--inhibit-theme-enable nil)
(setq-default major-mode 'text-mode)

;; warning
(setq undo-outer-limit 12000000)

(add-hook 'shell-mode-hook 'buffer-disable-undo)


(set-face-attribute 'default nil :family "DejaVu Sans Mono" :height 90)





;; ring
(setq ring-bell-function 'ignore
      visible-bell t)

;; mini-window
(setq resize-mini-windows t
      max-mini-window-height 0.33)

;; scrool
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1
      scroll-error-top-bottom t)

;; mousewheel
(setq mouse-wheel-scroll-amount '(2 ((shift) . 2))
      mouse-wheel-progressive-speed nil)

;; tab
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)
(setq-default tab-width 4)


;; backup
(setq backup-directory-alist '(("." . "~/.emacs.d/backups"))
      delete-old-versions -1
      version-control t
      backup-inhibited t
      auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))


;; hist
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode +1)
(setq savehist-save-minibuffer-history +1
      savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))


;; confirmation
(fset 'yes-or-no-p 'y-or-n-p);; replace yes to y
(setq confirm-nonexistent-file-or-buffer nil)
(setq large-file-warning-threshold 100000000)

;; insert ret if last line
(setq next-line-add-newlines nil)

;; scratch message
(setq initial-scratch-message nil
      initial-major-mode 'org-mode
      inhibit-startup-screen t)

;; replace dabbrev by hippie-expanad
(global-set-key [remap dabbrev-expand] 'hippie-expand)

;; save
(setq auto-save-default nil
      auto-save-interval 0)

;; kill process no prompt
(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))


;; (setq browse-url-browser-function 'browse-url-generic)
;; (pcase system-type
;;   ('darwin (setq browse-url-generic-program "open"))
;;   ('linux (setq browse-url-generic-program "chromium-browser"))
;;   (_ (setq  browse-url-generic-program "chromium-browser")))

(setq browse-url-browser-function 'browse-url-generic)
(pcase system-type
  ('darwin (setq browse-url-generic-program "open"))
  ('linux (setq browse-url-generic-program "chromium"))
  (_ (setq  browse-url-generic-program "chromium")))


;; search regex
(setq case-fold-search nil)

;; default minor mode
;; (fringe-mode 0)
;; FOR SHOWING BREAK POINT
(fringe-mode '(5 . 0))

(use-package dash)
(use-package f)
(use-package s)

;; do not split shell
(push (cons "\\*shell\\*" display-buffer--same-window-action) display-buffer-alist)

;; tabulation
(setq-default electric-indent-inhibit t)

;; shell path
;; (exec-path-from-shell-initialize)
(setq exec-path-from-shell-check-startup-files nil)

;; shell
(setq comint-scroll-to-bottom-on-output t)

;; bugfix for er/expand
(setq shift-select-mode nil)
(setq my-is-toggle-speed-up nil)

;; autorevert
(global-auto-revert-mode t)

;; supress warning for long buffer
;; (add-to-list 'warning-suppress-types '(undo discard-info))


(use-package delight
  :config (progn
            (delight '((beacon-mode nil "beacon")
                       (helm-mode nil)
                       (window-numbering-mode nil)
                       (abbrev-mode nil "abbrev")
                       (projectile-mode nil "projectile")
                       (smartparens-mode nil "smartparens")
                       (magit-gitflow nil "gitflow")
                       (company-mode nil "company")
                       (eldoc-mode nil "eldoc-mode")
                       (undo-tree-mode nil "undo-tree-minor-mode")
                       (yas/minor-mode nil)
                       (yas-minor-mode nil)
                       (elpy-mode nil)
                       (indium-mode nil "js-interaction")
                       (highlight-indent-guides-mode nil)
                       ))))

(use-package undo-tree
  :ensure t
  :commands undo-tree-mode
  :delight
  :config (progn
            (add-hook 'prog-mode-hook 'undo-tree-mode)
            (add-hook 'text-mode-hook 'undo-tree-mode)
            (add-hook 'fundamantal-mode-hook 'undo-tree-mode)
            (add-hook 'hexl-mode-hook 'undo-tree-mode)
            (add-hook 'toml-mode-hook 'undo-tree-mode)
            (add-hook 'rg-mode-hook 'undo-tree-mode)))

;; save on focus out
(defun my/save-out-hook ()
  (interactive)
  (save-some-buffers t))
(add-hook 'focus-out-hook 'my/save-out-hook)

;; save all no prompt
(defun my/save-all ()
  (interactive)
  (save-some-buffers t))

;; mark
(defadvice pop-to-mark-command (around ensure-new-position activate)
  (let ((p (point)))
    (dotimes (i 10)
      (when (= p (point)) ad-do-it))))
(setq set-mark-command-repeat-pop t)


(defun my/toggle-speed-fast ()
  (interactive )
  (smartparens-mode -1)
  (show-smartparens-mode -1)
  (font-lock-mode -1))


(defun my/toggle-speed-slow ()
  (interactive )
  (smartparens-mode 1)
  (show-smartparens-mode 1)
  (font-lock-mode 1))


(defun my/toggle-speed-fast-slow (arg)
  (interactive "P")
  (if (eq arg nil)
      (my/toggle-speed-fast)
    (my/toggle-speed-slow)))


;; shell buffer
(defun my/filter-shell (condp lst)
  (delq nil (mapcar (lambda (x) (and (funcall condp x) x)) lst)))

(defun my/shell-dwim (&optional create)
  (interactive "P")
  (let ((next-shell-buffer) (buffer)
        (shell-buf-list (identity ;;used to be reverse
                         (sort
                          (my/filter-shell (lambda (x) (string-match "^\\*shell\\*" (buffer-name x))) (buffer-list))
                          #'(lambda (a b) (string< (buffer-name a) (buffer-name b)))))))
    (setq next-shell-buffer
          (if (string-match "^\\*shell\\*" (buffer-name buffer))
              (get-buffer (cadr (member (buffer-name) (mapcar (function buffer-name) (append shell-buf-list shell-buf-list)))))
            nil))
    (setq buffer
          (if create
              (generate-new-buffer-name "*shell*")
            next-shell-buffer))
    (shell buffer)))


(defun my/run-in-eshell (code)
  (interactive "M")
  (setq last-executed-code code)
  (let ((current (current-buffer))
        (shell-name "*eshell*"))
    (when (not (get-buffer shell-name ))
      (eshell))
    (when (not (string-equal (buffer-name (current-buffer)) shell-name))
      (switch-to-buffer-other-window (get-buffer shell-name)))
    (end-of-buffer)
    (eshell-kill-input)
    (insert code)
    (eshell-send-input)
    (when (not (string-equal (buffer-name current) shell-name))
      (switch-to-buffer-other-window current))))


(defun my/re-run-in-eshell (&optional dt)
  (interactive "P")
  (save-buffer)
  (my/run-in-eshell last-executed-code))



(defun my/eshell-dwim (&optional create)
  (interactive "P")
  (let ((eshell-buf-list (identity
                          (sort
                           (my/filter-shell (lambda (x) (string-match "^\\*eshell\\*" (buffer-name x))) (buffer-list))
                           #'(lambda (a b) (string< (buffer-name a) (buffer-name b)))))))
    (setq eshell-buffer-name
          (if (string-match "^\\*eshell\\*" (buffer-name))
              (buffer-name (get-buffer (cadr (member (buffer-name) (mapcar (function buffer-name) (append eshell-buf-list eshell-buf-list))))))
            "*eshell*"))
    (if create
        (setq eshell-buffer-name (eshell "new"))
      (eshell))))


(defun my/dirname-buffer ()
  (interactive)
  (let ((dirname (file-name-directory (buffer-file-name))))
    (progn
      (message dirname)
      (kill-new dirname))))

(defun my/project-dirname-buffer ()
  (interactive)
  (let ((dirname (file-name-directory (projectile-project-root))))
    (progn
      (message dirname)
      (kill-new dirname))))

(defun my/filename-buffer ()
  (interactive)
  (let ((filename  (buffer-file-name)))
    (progn
      (message filename)
      (kill-new filename))))

(defun my/basename-buffer ()
  (interactive)
  (let ((filename  (file-name-nondirectory (buffer-file-name))))
    (progn
      (message filename)
      (kill-new filename))))


(defun my/open-with (arg)
  (interactive "P")
  (when buffer-file-name
    (shell-command (concat
                    (cond
                     ((and (not arg) (eq system-type 'darwin)) "open")
                     ((and (not arg) (member system-type '(gnu gnu/linux gnu/kfreebsd))) "xdg-open")
                     (t (read-shell-command "Open current file with: ")))
                    " "
                    (shell-quote-argument buffer-file-name)))))

(defun my/open-file-at-cursor ()
  "Open the file path under cursor.
If there is text selection, uses the text selection for path.
If the path starts with “http://”, open the URL in browser.
Input path can be {relative, full path, URL}.
Path may have a trailing “:‹n›” that indicates line number. If so, jump to that line number.
If path does not have a file extension, automatically try with “.el” for elisp files.
This command is similar to `find-file-at-point' but without prompting for confirmation.

URL `http://ergoemacs.org/emacs/emacs_open_file_path_fast.html'"
  (interactive)
  (let ((ξpath (if (use-region-p)
                   (buffer-substring-no-properties (region-beginning) (region-end))
                 (let (p0 p1 p2)
                   (setq p0 (point))
                   ;; chars that are likely to be delimiters of full path, e.g. space, tabs, brakets.
                   (skip-chars-backward "^  \"\t\n`'|()[]{}<>〔〕“”〈〉《》【】〖〗«»‹›·。\\`")
                   (setq p1 (point))
                   (goto-char p0)
                   (skip-chars-forward "^  \"\t\n`'|()[]{}<>〔〕“”〈〉《》【】〖〗«»‹›·。\\'")
                   (setq p2 (point))
                   (goto-char p0)
                   (buffer-substring-no-properties p1 p2)))))
    (if (string-match-p "\\`https?://" ξpath)
        (browse-url ξpath)
      (progn ; not starting “http://”
        (if (string-match "^\\`\\(.+?\\):\\([0-9]+\\)\\'" ξpath)
            (progn
              (let (
                    (ξfpath (match-string 1 ξpath))
                    (ξline-num (string-to-number (match-string 2 ξpath))))
                (if (file-exists-p ξfpath)
                    (progn
                      (find-file ξfpath)
                      (goto-char 1)
                      (forward-line (1- ξline-num)))
                  (progn
                    (when (y-or-n-p (format "file doesn't exist: 「%s」. Create?" ξfpath))
                      (find-file ξfpath))))))
          (progn
            (if (file-exists-p ξpath)
                (find-file ξpath)
              (if (file-exists-p (concat ξpath ".el"))
                  (find-file (concat ξpath ".el"))
                (when (y-or-n-p (format "file doesn't exist: 「%s」. Create?" ξpath))
                  (find-file ξpath ))))))))))



(defun my/just-one-space-in-region (beg end)
  "replace all whitespace in the region with single spaces"
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (re-search-forward "\\s-+" nil t)
        (replace-match " ")))))


(defun prepare-tramp-sudo-string (tempfile)
  (if (file-remote-p tempfile)
      (let ((vec (tramp-dissect-file-name tempfile)))
        (tramp-make-tramp-file-name
         "sudo"
         (tramp-file-name-user nil)
         (tramp-file-name-host vec)
         (tramp-file-name-localname vec)
         (format "ssh:%s@%s|"
                 (tramp-file-name-user vec)
                 (tramp-file-name-host vec))))
    (concat "/sudo:root@localhost:" tempfile)))



(defun my/sudo-edit-current-file ()
  (interactive)
  (let ((my/file-name) ; fill this with the file to open
        (position))    ; if the file is already open save position
    (if (equal major-mode 'dired-mode) ; test if we are in dired-mode
        (progn
          (setq my/file-name (dired-get-file-for-visit))
          (find-alternate-file (prepare-tramp-sudo-string my/file-name)))
      (setq my/file-name (buffer-file-name); hopefully anything else is an already opened file
            position (point))
      (find-alternate-file (prepare-tramp-sudo-string my/file-name))
      (goto-char position))))



(defun my/kill-all-dired-buffers ()
  (interactive)
  (save-excursion
    (let ((count 0))
      (dolist (buffer (buffer-list))
        (set-buffer buffer)
        (when (equal major-mode 'dired-mode)
          (setq count (1+ count))
          (kill-buffer buffer)))
      (message "Killed %i dired buffer(s)." count))))



(defun my/smart-ret()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(defun my/smart-ret-reverse()
  (interactive)
  (beginning-of-line)
  (newline)
  (previous-line)
  (indent-for-tab-command))


(defun my/cut-line-or-region ()
  (interactive)
  (if current-prefix-arg
      (progn ; not using kill-region because we don't want to include previous kill
        (kill-new (buffer-string))
        (delete-region (point-min) (point-max)))
    (progn (if (use-region-p)
               (kill-region (region-beginning) (region-end) t)
             (kill-region (line-beginning-position) (line-beginning-position 2))))))

(defun my/copy-line-or-region (&optional arg)
  "Copy current line, or current text selection."
  (interactive "P")
  (cond
   ((and (boundp 'cua--rectangle) cua--rectangle cua-mode)
    (cua-copy-rectangle arg))
   ((and (region-active-p) cua-mode)
    (cua-copy-region arg))
   ((region-active-p)
    (kill-ring-save (region-beginning) (region-end)))
   (t
    (kill-ring-save
     (save-excursion
       (let ((pt (point)))
         (when (= pt (point))
           (call-interactively 'move-beginning-of-line)))
       (when (not (bolp))
         (beginning-of-line))
       (point))
     (save-excursion
       (let ((pt (point)))
         (when (= pt (point))
           (call-interactively 'move-end-of-line)))
       (re-search-forward "\\=\n" nil t) ;; Include newline
       (point)))))
  (deactivate-mark))

(defun my/join-line-or-lines-in-region ()
  (interactive)
  (cond ((region-active-p)
         (let ((min (line-number-at-pos (region-beginning))))
           (goto-char (region-end))
           (while (> (line-number-at-pos) min)
             (join-line))))
        (t (call-interactively 'join-line))))

(defun my/duplicate-current-line-or-region (arg)
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and (region-active-p) (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if (region-active-p)
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

(defun push-mark-no-activate ()
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))

(defun jump-to-mark ()
  (interactive)
  (set-mark-command 1))

(defun my/forward-block (&optional number)
  (interactive "p")
  (if (and number
           (> 0 number))
      (ergoemacs-backward-block (- 0 number))
    (if (search-forward-regexp "\n[[:blank:]\n]*\n+" nil "NOERROR" number)
        (progn (backward-char))
      (progn (goto-char (point-max))))))

(defun my/backward-block (&optional number)
  (interactive "p")
  (if (and number
           (> 0 number))
      (ergoemacs-forward-block (- 0 number))
    (if (search-backward-regexp "\n[\t\n ]*\n+" nil "NOERROR" number)
        (progn
          (skip-chars-backward "\n\t ")
          (forward-char 1))
      (progn (goto-char (point-min))))))

(defun my/beginning-of-line-or-block (&optional n)
  (interactive "p")
  (let ((n (if (null n) 1 n)))
    (if (equal n 1)
        (if (or (equal (point) (line-beginning-position))
                (equal last-command this-command))
            (my/backward-block n)
          (beginning-of-line)
          (back-to-indentation))
      (my/backward-block n))))

(defun my/end-of-line-or-block (&optional n)
  (interactive "p")
  (let ((n (if (null n) 1 n)))
    (if (equal n 1)
        (if (or (equal (point) (line-end-position))
                (equal last-command this-command))
            (my/forward-block)
          (end-of-line))
      (progn (my/forward-block n)))))

(defun my/select-current-line ()
  (interactive)
  (end-of-line)
  (set-mark (line-beginning-position)))

(defun my/select-current-block ()
  (interactive)
  (let (p1)
    (if (re-search-backward "\n[ \t]*\n" nil "move")
        (progn (re-search-forward "\n[ \t]*\n")
               (setq p1 (point)))
      (setq p1 (point)))
    (if (re-search-forward "\n[ \t]*\n" nil "move")
        (re-search-backward "\n[ \t]*\n"))
    (set-mark p1)))

(defun my/kill-line-backward (arg)
  (interactive "p")
  (kill-line (- 1 arg))
  (indent-for-tab-command))

(defun my/toggle-letter-case (φp1 φp2)
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (let ((ξbds (bounds-of-thing-at-point 'word)))
       (list (car ξbds) (cdr ξbds)))))
  (let ((deactivate-mark nil))
    (when (not (eq last-command this-command))
      (put this-command 'state 0))
    (cond
     ((equal 0 (get this-command 'state))
      (upcase-initials-region φp1 φp2)
      (put this-command 'state 1))
     ((equal 1  (get this-command 'state))
      (upcase-region φp1 φp2)
      (put this-command 'state 2))
     ((equal 2 (get this-command 'state))
      (downcase-region φp1 φp2)
      (put this-command 'state 0)))))

(defun my/new-empty-buffer ()
  (interactive)
  (let ((ξbuf (generate-new-buffer "untitled")))
    (switch-to-buffer ξbuf)
    (funcall (and initial-major-mode))
    (setq buffer-offer-save t)))

(defun my/kill-buffer ()
  (interactive)
  (when (not (string-match "^\*.*\*$" (buffer-name (current-buffer))))
    (save-buffer))
  (kill-this-buffer))

(defun my/previous-user-buffer ()
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (or
                 (string-equal "*" (substring (buffer-name) 0 1))
                 (string-equal "dired-mode" (message "%s" major-mode)))
                (< i 20))
      (setq i (1+ i)) (previous-buffer) )))

(defun my/next-user-buffer ()
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (or
                 (string-equal "*" (substring (buffer-name) 0 1))
                 (string-equal "dired-mode" (message "%s" major-mode)))
                (< i 20))
      (setq i (1+ i)) (next-buffer) )))

(defun my/previous-user-dired-buffer ()
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and
            (not (string-equal "dired-mode" (message "%s" major-mode)))
            (< i 20))
      (setq i (1+ i)) (previous-buffer))))

(defun my/next-user-dired-buffer ()
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and
            (not (string-equal "dired-mode" (message "%s" major-mode)))
            (< i 20))
      (setq i (1+ i)) (next-buffer))))

(defun my/toggle-case ()
  (interactive)
  (if case-fold-search
      (progn
        (setq case-fold-search nil)
        (message "toogle off"))
    (progn
      (setq case-fold-search t)
      (message "toggle on"))))

(defun my/toggle-indent-level ()
  (interactive)
  (setq tab-width (if (= tab-width 2) 4 2))
  (message "Indent level %d"
           tab-width))

(defun my/revert-buffer-no-confirm ()
  (interactive)
  (revert-buffer t t))

(defun my/close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))


(defun my/open (x)
  "Use xdg-open shell command on X."
  (interactive)
  (call-process shell-file-name nil
                nil nil
                shell-command-switch
                (format "%s %s"
                        (if (eq system-type 'darwin)
                            "open"
                          "xdg-open")
                        (shell-quote-argument x))))



(defun my/youtube-dl (arg)
  (interactive "Murl:")
  (let* ((arg-list (s-split " " arg))
         (url (-first-item arg-list))
         (folder (if (>= (length arg-list) 2)
                     (-last-item arg-list)))
         (output (if folder
                     (concat "--output " folder "/\"%(uploader)s%(title)s.%(ext)s\"")
                   "--output \"%(uploader)s%(title)s.%(ext)s\""))
         (command (concat "youtube-dl " url " " output " --extract-audio --audio-format mp3" " &")))
    (shell-command command)))



(defun my/youtube-dl-2 (arg)
  (interactive "Murl:")
  (let* ((arg-list (s-split " " arg))
         (url (-first-item arg-list))
         (folder (if (>= (length arg-list) 2)
                     (-last-item arg-list)))
         (command (concat "youtube-dl " url "  --extract-audio --audio-format mp3" " &")))
    (shell-command command)))


(defun my/http-dl (arg)
  (interactive "Murl:")
  (let* ((arg-list (s-split " " arg))
         (url (-first-item arg-list))
         (folder (if (>= (length arg-list) 2)
                     (-last-item arg-list)))
         (basename (-last-item (s-split "/" url)))
         (full-path (concat folder "/" basename))
         (command-1 (concat "http " url " --download" " -o " full-path " &"))
         (command-2 (concat "http " url " --download" " &")))
    (if folder
        (shell-command command-1)
      (shell-command command-2))))


(defun my/toggle-shell-scroll ()
  (interactive)
  (if comint-scroll-to-bottom-on-output
      (progn
        (setq comint-scroll-to-bottom-on-output nil)
        (message "scroll off "))
    (progn
      (setq comint-scroll-to-bottom-on-output t )
      (message "scroll on"))))

(defun my/difference-line-point-end-buffer ()
  (interactive)
  (string-to-number
   (substring
    (car (last  (split-string (count-lines-page))))
    0 1)))

;; WINDOW PROJECT
(defun my/split-project-1 ()
  (interactive)
  (delete-other-windows)
  (split-window-horizontally))


(defun my/split-project-2 ()
  (interactive)
  (delete-other-windows)
  (split-window-vertically)
  (enlarge-window 20)
  (windmove-down)
  (my/shell-dwim)
  (windmove-up)
  (split-window-horizontally))


(defun my/split-project-3 ()
  (interactive)
  (delete-other-windows)
  (split-window-vertically)
  (split-window-horizontally)
  (enlarge-window 20)
  (windmove-down)
  (shell "*shell*")
  (split-window-horizontally)
  (windmove-right)
  (shell "*shell*<2>")
  (windmove-up)
  (windmove-left))


(defun my/split-project-4 ()
  (interactive)
  (delete-other-windows)
  (split-window-vertically)
  (enlarge-window 20)
  (windmove-down)
  (my/shell-dwim)
  (split-window-horizontally)
  (windmove-right)
  (my/shell-dwim)
  (my/shell-dwim)
  (windmove-up)
  (split-window-horizontally)
  (shrink-window-horizontally 90)
  (if (string-equal (projectile-project-name) "-")
      (my/previous-user-dired-buffer)
    (projectile-dired))
  (windmove-right)
  (split-window-horizontally))

(defun my/split-2-shell ()
  (interactive)
  (delete-other-windows)
  (shell "*shell*")
  (split-window-horizontally)
  (windmove-right)
  (shell "*shell*<2>")
  (balance-windows))

(defun my/split-2-2-shell ()
  (interactive)
  (delete-other-windows)
  (shell "*shell*")
  (split-window-horizontally)
  (windmove-right)
  (shell "*shell*<4>")
  (windmove-left)
  (split-window-vertically)
  (windmove-down)
  (shell "*shell*<3>")
  (windmove-right)
  (split-window-vertically)
  (shell "*shell*<2>")
  (windmove-left)
  (windmove-up)
  (balance-windows))

(use-package helm
  :init (progn
          (require 'helm-config)
          (bind-key "C-c h" #'helm-command-prefix)
          (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
                helm-input-idle-delay 0.01  ; this actually updates things
                helm-yas-display-key-on-candidate t
                helm-candidate-number-limit 100
                helm-quick-update t
                helm-M-x-requires-pattern nil
                helm-M-x-fuzzy-match t
                helm-ff-skip-boring-files t
                helm-move-to-line-cycle-in-source nil
                helm-buffers-fuzzy-matching t
                helm-recentf-fuzzy-match t
                helm-locate-fuzzy-match t
                helm-split-window-inside-p t
                helm-always-two-windows t
                helm-scroll-amount 8
                helm-autoresize-mode 1
                helm-follow-mode-persistent nil
                helm-buffer-max-length 30
                helm-M-x-reverse-history t
                ;; helm-mode-handle-completion-in-region t
                helm-persistent-help-string nil
                helm-boring-buffer-regexp-list
                (quote ("\\` " "\\*helm" "\\*helm-mode" "\\*Echo Area" "\\*Minibuf" "\\*.*\\*" "\\*magit" "settings.org" "life.org" "work.org" "my-sql-*" "magit-*" )))
          (setq helm-c-source-swoop-match-functions
                '(helm-mm-exact-match
                  helm-mm-match
                  ;;helm-fuzzy-match
                  ;;helm-mm-3-migemo-match
                  ))
          (defadvice helm-display-mode-line (after undisplay-header activate)
            (setq header-line-format nil ))
          (helm-mode))
  :config
  (progn
    (bind-key "<tab>" #'helm-execute-persistent-action helm-map)
    (bind-key "C-i" #'helm-execute-persistent-action helm-map)
    (bind-key "C-z" #'helm-select-action helm-map)
    (bind-key "C-c C-z" #'helm-select-action helm-map)
    (bind-key "M-c" #'helm-previous-line helm-map)
    (bind-key "M-t" #'helm-next-line helm-map)
    (bind-key "M-o" #'helm-next-source helm-map)
    (bind-key "M-C" #'helm-previous-page helm-map)
    (bind-key "M-T" #'helm-next-page helm-map)
    (bind-key "M-T" #'helm-next-page helm-find-files-map)
    (bind-key "M-b" #'helm-beginning-of-buffer helm-map)
    (bind-key "M-B" #'helm-end-of-buffer helm-map)
    (bind-key "C-h" #'helm-find-files-up-one-level helm-find-files-map)
    (bind-key "C-n" #'helm-find-files-down-last-level helm-find-files-map)
    (bind-key "M-C" #'helm-previous-page helm-find-files-map)
    (bind-key "M-B" #'helm-end-of-buffer helm-find-files-map)
    (bind-key "C-f" #'helm-ff-run-find-sh-command helm-find-files-map)
    (bind-key "C-S-f" #'helm-ff-run-locate helm-find-files-map)
    (bind-key "C-e" #'helm-ff-run-eshell-command-on-file helm-find-files-map)
    (bind-key "C-r" #'helm-ff-run-rename-file helm-find-files-map)
    (bind-key "C-j" #'helm-ff-run-copy-file helm-find-files-map)
    (bind-key "C-d" #'helm-ff-run-delete-file helm-find-files-map)
    (bind-key "C-s" #'helm-ff-run-grep helm-find-files-map)
    (bind-key "<C-return>" #'helm-ff-run-switch-other-window helm-map)
    (bind-key "C-S-d" #'helm-buffer-run-kill-persistent helm-buffer-map)
    (bind-key "C-d" #'helm-buffer-run-kill-buffers helm-buffer-map)
    (bind-key "<C-return>" #'helm-buffer-switch-other-window helm-buffer-map)
    (bind-key "C-c C-o" #'helm-buffer-switch-other-window helm-buffer-map)
    (bind-key "C-c o" #'helm-buffer-switch-other-window helm-buffer-map)
    (bind-key "C-c C-e" #'wgrep-change-to-wgrep-mode helm-map)))



(use-package helm-swoop
  ;; :straight (:host github :repo "ashiklom/helm-swoop" :branch "master")
  :init (progn
          (defun my/helm-multi-swoop-projectile ()
            (interactive)
            (if
                (string-equal (projectile-project-name) "-")
                (helm-multi-swoop-all)
              (helm-multi-swoop-projectile)))
          (setq helm-c-source-swoop-search-functions
                '(helm-mm-exact-search
                  helm-mm-search
                  helm-candidates-in-buffer-search-default-fn)
                helm-swoop-split-with-multiple-windows t
                 helm-swoop-pre-input-function (lambda () (thing-at-point 'symbol))
                ))
  :config (progn
            (bind-key "C-c C-t" 'toggle-case-fold-search helm-swoop-map)
            ;; (bind-key "C-c C-e" 'helm-swoop-edit helm-swoop-map)
            (bind-key "C-c C-e" 'helm-swoop-edit helm-swoop-map)
            ;;(bind-key "C-c C-e" 'helm-ag-edit helm-swoop-map)
             (bind-key "C-c C-o" 'helm-swoop--edit-buffer helm-swoop-map)
            (bind-key "C-c C-t" 'toggle-case-fold-search helm-swoop-edit-map)
            (bind-key "C-c C-c" 'helm-swoop--edit-complete helm-swoop-edit-map)))


(use-package wgrep-helm)
(use-package wgrep)


(use-package helm-ag
  :init (progn
          (defun my/helm-do-ag-project-root ()
            (interactive)
            (if (string-equal (projectile-project-name) "-")
                (helm-do-ag)
              (helm-do-ag-project-root)))
          (setq helm-grep-ag-command "ag --line-numbers -S --hidden --color --color-match '31;43' --nogroup %s %s %s --ignore=*po*" )

          (setq helm-ag-command-option " -U"
                helm-ag-use-agignore t)
          )
  :config(progn
           (bind-key "C-c C-e" 'helm-ag-edit helm-do-ag-map)
           (bind-key "<C-return>" #'helm-ag--run-other-window-action helm-do-ag-map)
           (bind-key "C-c C-g" 'helm-ag--edit-abort helm-ag-edit-map)))


(use-package helm-css-scss)

(use-package helm-projectile)

(use-package swiper)

(use-package company-quickhelp)

(use-package company
  :delight
  :init (progn
          (defun my/company-show-doc-buffer-at-point ()
            (interactive)
            (save-excursion
              (sp-forward-sexp)
              (company-show-doc-buffer)))

          (defun my/company-show-doc-location-at-point ()
            (interactive)
            (save-excursion
              (sp-forward-sexp)
              (company-show-location)))

          ;; (global-company-mode 1)



          (add-hook 'prog-mode-hook 'company-mode)
          (add-hook 'html-mode-hook 'company-mode)
          (add-hook 'css-mode-hook 'company-mode)
          (add-hook 'scss-mode-hook 'company-mode)
          (setq company-tooltip-limit 20
                company-tooltip-minimum-width 40
                company-idle-delay 0
                company-echo-delay 0
                company-show-numbers t
                company-minimum-prefix-length 2
                company-async-timeout 5
                company-backends '(company-capf)
                company-frontends '(company-pseudo-tooltip-frontend
                                    company-echo-metadata-frontend)
                company-quickhelp-delay nil))

  :config (progn
            (bind-key "<tab>" 'company-complete company-active-map)
            (bind-key "C-h" 'company-select-previous company-active-map)
            (bind-key "C-n" 'company-select-next company-active-map)
            (bind-key "C-t" 'company-quickhelp-manual-begin company-active-map)
            (bind-key "C-l" 'company-show-location company-active-map)
            (bind-key "C-d" 'company-show-doc-buffer company-active-map)
            (unbind-key "M-h" company-active-map)
            (unbind-key "M-n" company-active-map)
            (bind-key "C-i" 'yas-expand company-active-map)))


(use-package eldoc
  :delight
  :config (progn
            (add-hook 'prog-mode-hook 'eldoc-mode)))

(use-package yasnippet
  :delight
  :init(progn
         (yas-global-mode 1))
  :config(progn
           (setq yas-installed-snippets-dir "~/.emacs.d/snippets")
           (define-key yas-minor-mode-map (kbd "TAB") nil)
           (define-key yas-minor-mode-map (kbd "<tab>") nil)))


(use-package hydra)

;; npm i -g typescript-language-server typescript
;; npm i -g bash-language-server
;; npm i -g vscode-html-languageserver-bin
;; npm i -g vscode-css-languageserver-bin
;; npm install vls -g
;; npm i -g intelephense
;; pip install python-language-server[all]
;; gem install solargraph rdoc pry irb



(use-package spinner)
(use-package lsp-ui
  :init (progn
          (setq lsp-ui-doc-enable nil
                lsp-ui-doc-header nil
                lsp-ui-doc-include-signature nil)))



;; "~/.vscode-oss/extensions/lanza.lldb-vscode-0.2.2/bin/darwin/bin/lldb-vscode"
;; RUST LLDB debugger
;; sudo pacman -S lldb



(use-package dap-mode
  :straight (:host github :repo "emacs-lsp/dap-mode" :branch "master")
  :hook ((after-init . dap-mode)
         (dap-mode . dap-ui-mode)
         (python-mode . (lambda () (require 'dap-python)))
         (ruby-mode . (lambda () (require 'dap-ruby)))
         (php-mode . (lambda () (require 'dap-php)))
         (rustic-mode . (lambda ()
                          (require 'dap-gdb-lldb)
                          (dap-register-debug-template
                           "GDB::Run"
                           (list :type "gdb"
                                 :request "launch"
                                 :valuesFormatting "prettyPrinters"
                                 :name "GDB::Run"
                                 :target nil
                                 :cwd nil))

                          (dap-register-debug-template
                           "LLDB::Run"
                           (list :type "lldb"
                                 :request "launch"
                                 :name "LLDB::Run"
                                 :target nil
                                 :cwd nil))))
         ((js-mode js2-mode typescript-mode vue-mode) . (lambda () (require 'dap-firefox))))
  :config (progn
            (setq dap-output-buffer-filter '("stdout" "stderr" "console")
                  dap-python-terminal "terminator -x "
                  )

            (defhydra my-dap-hydra (:color pink :hint nil :foreign-keys run)
              "
^Stepping^          ^Switch^                 ^Breakpoints^           ^Eval
^^^^^^^^-----------------------------------------------------------------------------------------
_n_: Next           _ss_: Session            _bb_: Toggle            _ee_: Eval
_i_: Step in        _st_: Thread             _ba_: Delete all        _er_: Eval region
_o_: Step out       _sf_: Stack frame        ^ ^                     _es_: Eval thing at point
_c_: Continue       _sl_: List locals        _bc_: Set condition     _ea_: Add expression.
_r_: Restart frame  _sb_: List breakpoints   _bh_: Set hit count     _ed_: remove expression
_Q_: Disconnect     _sS_: List sessions      _bl_: Set log message
^^                  _sa_: Del all session
"
              ("n" dap-next)
              ("i" dap-step-in)
              ("o" dap-step-out)
              ("c" dap-continue)
              ("r" dap-restart-frame)
              ("u" dap-ui-repl :color blue)
              ("ss" dap-switch-session)
              ("st" dap-switch-thread)
              ("sf" dap-switch-stack-frame)
              ("sl" dap-ui-locals)
              ("sb" dap-ui-breakpoints)
              ("sS" dap-ui-sessions)
              ("sa" dap-delete-all-sessions)
              ("bb" dap-breakpoint-toggle)
              ("ba" dap-breakpoint-delete-all)
              ("bc" dap-breakpoint-condition)
              ("bh" dap-breakpoint-hit-condition)
              ("bl" dap-breakpoint-log-message)
              ("ee" dap-eval)
              ("ea" dap-ui-expressions-add)
              ("ed" dap-ui-expressions-remove)
              ("er" dap-eval-region)
              ("es" dap-eval-thing-at-point)
              ("1" dap-debug-restart )
              ("2" dap-debug-last)
              ("3" dap-debug)
              ("4" dap-debug-recent)
              ("-" dap-go-to-output-buffer )
              ("q" nil "quit" :color blue)
              ("Q" dap-disconnect :color red)
              )
            
            
            ;; (add-hook 'dap-stopped-hook
            ;;           (lambda (arg) (call-interactively #'my-dap-hydra)))

            ))



(use-package helm-lsp
  :config
  (defun netrom/helm-lsp-workspace-symbol-at-point ()
    (interactive)
    (let ((current-prefix-arg t))
      (call-interactively #'helm-lsp-workspace-symbol)))

  (defun netrom/helm-lsp-global-workspace-symbol-at-point ()
    (interactive)
    (let ((current-prefix-arg t))
      (call-interactively #'helm-lsp-global-workspace-symbol))))


(use-package lsp-java)
(use-package ccls)

(use-package lsp-mode
  :diminish
  :init (progn
          (require 'lsp-mode)
          ;; (require 'lsp-clients)
          (setq lsp-completion-provider :capf
                lsp-ui-doc-enable nil
                lsp-diagnostic-package :none
                lsp-enable-indentation nil
                lsp-ui-doc-enable nil
                lsp-ui-sideline-show-diagnostics nil
                lsp-ui-sideline-show-code-actions nil
                lsp-highlight-symbol-at-point t
                lsp-rust-server 'rust-analyzer
                lsp-vetur-format-default-formatter-css "none"
                lsp-vetur-format-default-formatter-html "none"
                lsp-vetur-format-default-formatter-js "none"
                lsp-vetur-validation-template nil
                lsp-python-ms-auto-install-server t
                gc-cons-threshold 600000000
                read-process-output-max (* 4096 1024))
          

          ;;          (add-hook 'lsp-managed-mode-hook (lambda () (setq-local company-backends '(company-capf))))

          (add-hook 'lsp-mode-hook
                    (lambda ()
                      (bind-key "C-c C-o" 'xref-find-definitions-other-window lsp-mode-map)
                      (bind-key "C-c C-." 'lsp-find-references lsp-mode-map)
                      (bind-key "C-c C-d" 'lsp-describe-thing-at-point lsp-mode-map)
                      (bind-key "C-c C-a" 'lsp-execute-code-action lsp-mode-map)
                      (bind-key "C-c C-s" 'lsp-rename lsp-mode-map)
                      (bind-key "C-c C-t" 'lsp-goto-type-definition lsp-mode-map)
                      (bind-key "C-c C-i" 'lsp-goto-implementation lsp-mode-map)
                      (bind-key "C-c C-f" 'lsp-format-buffer lsp-mode-map)))

          (add-hook 'js2-mode-hook (lambda () (lsp)))
          (add-hook 'typescript-mode-hook (lambda () (lsp)))
          (add-hook 'vue-mode-hook (lambda () (lsp)))
          ;; (add-hook 'vue-mode-hook (lambda (require 'lsp-vetur) (lsp)))
          (add-hook 'css-mode-hook (lambda () (lsp)))
          (add-hook 'java-mode-hook (lambda () (lsp)))
          (add-hook 'ruby-mode-hook (lambda () (lsp)))
          (add-hook 'php-mode-hook (lambda () (lsp)))
          (add-hook 'rustic-mode-hook (lambda () (lsp)))
          (add-hook 'python-mode-hook (lambda ()
                                        (require 'lsp-pyls)
                                        (lsp)))
          (add-hook 'elixir-mode-hook (lambda () (lsp)))
          (add-hook 'c++-mode-hook (lambda () (require 'ccls) (lsp)))
          (add-hook 'c-mode-hook (lambda () (require 'ccls) (lsp)))
          ;;(my/lsp-auto-configure)
          
          ))

(use-package prettier-js)

(use-package flycheck
  :init (progn
          (setq flycheck-check-syntax-automatically '(save mode-enabled)
                flycheck-display-errors-function nil)
          (setq-default flycheck-disabled-checkers '(javascript-jshint
                                                     typescript-tslint))

          (set-variable 'flycheck-python-mypy-executable "mypy")
          (set-variable 'flycheck-python-mypy-args '("--py2"  "--ignore-missing-imports" "--check-untyped-defs"))))

(use-package ido
  :init(progn
         (setq ido-enable-flex-matching t
               ido-use-filename-at-point nil
               ibuffer-saved-filter-groups
               (quote (("default"
                        ("dired" (or
                                  (mode . dired-sidebar-mode)
                                  (mode . dired-mode)))
                        ("code" (or
                                 (mode . python-mode)
                                 (mode . ruby-mode)
                                 (mode . c-mode-common-hook)
                                 (mode . clojure-mode)
                                 (mode . haskell-mode)
                                 (mode . php-mode)
                                 (mode . emacs-lisp-mode)
                                 (mode . js2-mode)
                                 (mode . js2-jsx-mode)
                                 (mode . rustic-mode)
                                 (mode . go-mode)
                                 (mode . es-mode)
                                 (mode . vue-mode)
                                 (mode . typescript-mode)
                                 (mode . vue-html)
                                 (mode . coffee-mode)))
                        ("mark" (or
                                 (mode . html-mode)
                                 (mode . web-mode)
                                 (mode . jinja2-mode)
                                 (mode . scss-mode)
                                 (mode . css-mode)
                                 (mode . stylus-mode)
                                 (mode . vue-mode)
                                 (mode . vue-javascript-mode)
                                 (mode . json-mode)
                                 (mode . xml-mode)
                                 (mode . yaml-mode)
                                 (mode . csv-mode)
                                 (mode . txt-mode)
                                 (mode . org-mode)
                                 (mode . markdown-mode)))
                        ("Magit" (or (derived-mode . magit-mode)
                                     (filename . "\\.git\\(ignore\\|attributes\\)$")))
                        ("Shell" (or
                                  (mode . shell-mode)
                                  (mode . term-mode)
                                  (mode . sh-mode)
                                  (mode . conf-unix-mode)
                                  (mode . inferior-python-mode)
                                  (name . "^\\*Shell Command Output\\*$")))
                        ("Emacs" (or
                                  (mode . emacs-lisp-mode)
                                  (mode . lisp-interaction-mode)
                                  (mode . help-mode)
                                  (mode . Info-mode)
                                  (mode . package-menu-mode)
                                  (mode . finder-mode)
                                  (mode . Custom-mode)
                                  (mode . apropos-mode)
                                  (mode . ioccur-mode)
                                  (mode . occur-mode)
                                  (mode . reb-mode)
                                  (mode . calc-mode)
                                  (mode . calc-trail-mode)
                                  (mode . messages-buffer-mode)))
                        ("Files" (name . "^[^\*].*[^\*]$"))
                        ("Others" (name . "^\*[^Hh].*\*$"))
                        ("junk" (name . "^\*[Hh]elm.*\*$"))))))
         (add-hook 'ibuffer-mode-hook
                   (lambda ()
                     (ibuffer-switch-to-saved-filter-groups "default")))))

(use-package ediff
  :init(progn
         (defun ora-ediff-hook ()
           (ediff-setup-keymap))

         (setq ediff-window-setup-function 'ediff-setup-windows-plain
               ediff-split-window-function 'split-window-horizontally
               ediff-diff-options "-w")

         (defvar ediff-last-windows nil "Last ediff window configuration.")

         (defun ediff-restore-windows ()
           "Restore window configuration to `ediff-last-windows'."
           (set-window-configuration ediff-last-windows)
           (remove-hook 'ediff-after-quit-hook-internal
                        'ediff-restore-windows))

         (defadvice ediff-buffers (around ediff-restore-windows activate)
           (setq ediff-last-windows (current-window-configuration))
           (add-hook 'ediff-after-quit-hook-internal 'ediff-restore-windows)
           ad-do-it)

         (add-hook 'ediff-mode-hook 'ora-ediff-hook)))

(use-package magit
  :init(progn
         (setq magit-diff-use-overlays nil)))

(use-package git-gutter-fringe+)
(use-package git-timemachine)
(use-package magit-find-file)
(use-package forge)

(use-package shell
  :init (progn
          (defun comint-clear-buffer ()
            (interactive)
            (let ((comint-buffer-maximum-size 0))
              (comint-truncate-buffer)))
          (defun my-comint-restart ()
            (interactive)
            (end-of-buffer)
            (comint-interrupt-subjob)
            (comint-interrupt-subjob)
            (comint-previous-input 1)
            (comint-send-input)))
  :config (progn
            (bind-key "<up>" 'comint-previous-input shell-mode-map)
            (bind-key "<down>" 'comint-next-input shell-mode-map)
            (bind-key "C-M-c" 'comint-previous-input shell-mode-map)
            (bind-key "C-M-t" 'comint-next-input shell-mode-map)
            (bind-key "C-r" 'comint-history-isearch-backward-regexp shell-mode-map)
            (bind-key "C-c C-q" 'comint-kill-subjob shell-mode-map)
            (bind-key "C-S-r" 'helm-swoop shell-mode-map)
            (bind-key "C-l" 'comint-clear-buffer shell-mode-map)
            (bind-key "C-p" 'helm-comint-input-ring shell-mode-map)
            (bind-key "C-y" 'helm-comint-input-ring shell-mode-map)
            (bind-key "C-c C-r" 'my-comint-restart shell-mode-map)
            (unbind-key "M-r" shell-mode-map )))



(use-package eshell
  :init (progn
          (defun eshell/clear ()
            (let ((inhibit-read-only t))
              (erase-buffer)
              (eshell-send-input)))
          (add-hook 'eshell-mode-hook (lambda ()
                                        (bind-key "M-d" 'eshell-bol eshell-mode-map)
                                        (bind-key "M-q" 'eshell-kill-input eshell-mode-map)
                                        (bind-key "M-H" 'eshell-previous-prompt eshell-mode-map)
                                        (bind-key "M-N" 'eshell-next-prompt eshell-mode-map)
                                        (bind-key "C-l" 'eshell/clear eshell-mode-map)
                                        (bind-key "<up>" 'eshell-previous-input eshell-mode-map)
                                        (bind-key "<down>" 'eshell-next-input eshell-mode-map)
                                        (bind-key "<tab>" 'completion-at-point eshell-mode-map)
                                        (bind-key "TAB" 'completion-at-point eshell-mode-map)))))


(use-package exec-path-from-shell
  :init (progn
          (exec-path-from-shell-initialize)))


(use-package tramp
  :straight nil
  :init (progn
          (setq tramp-default-method "ssh"
                password-cache-expiry nil)))


(use-package vagrant)

(use-package docker)

(use-package docker-tramp)

;; (use-package vagrant-tramp)

(use-package helm-tramp
  :init (progn
          (setq tramp-default-method "ssh")))


(use-package dockerfile-mode
  :init (progn
          (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))))


(use-package docker-compose-mode)

(use-package kubernetes
  :commands (kubernetes-overview))


(use-package prodigy)

(use-package quickrun
  :init (progn
          (setq quickrun-focus-p nil)))

(use-package inf-mongo
  :init(progn
         (setq inf-mongo-command "mongo")))

(use-package redis)

(use-package awscli-capf
  :commands (awscli-capf-add)
  :hook (shell-mode . awscli-capf-add))

(use-package projectile
  :init(progn
         (defun my/toggle-project-explorer ()
           "Toggle the project explorer window."
           (interactive)
           (let* ((buffer (dired-noselect (projectile-project-root)))
                  (window (get-buffer-window buffer)))
             (if window
                 (my/hide-project-explorer)
               (my/show-project-explorer))))

         (defun my/show-project-explorer ()
           "Project dired buffer on the side of the frame.
Shows the projectile root folder using dired on the left side of
the frame and makes it a dedicated window for that buffer."
           (let ((buffer (dired-noselect (projectile-project-root))))
             (progn
               (display-buffer-in-side-window buffer '((side . left) (window-width . 0.2)))
               (set-window-dedicated-p (get-buffer-window buffer) t)
)))

         (defun my/hide-project-explorer ()
           "Hide the project-explorer window."
           (let ((buffer (dired-noselect (projectile-project-root))))
             (progn
               (delete-window (get-buffer-window buffer))
               (kill-buffer buffer))))

         (defun my/goto-projectile-dired ()
           "Go to projectile dired window"
           (interactive)
           (let* ((buffer (dired-noselect (projectile-project-root)))
                  (window (get-buffer-window buffer)))
             (my/select-window-by-number 1)))


         (setq projectile-enable-caching t
               projectile-indexing-method 'alien
               projectile-completion-system 'helm
               projectile-switch-project-action 'helm-projectile-find-file
               projectile-mode-line "Projectile"
               projectile-use-native-indexing nil)
         (helm-projectile-on)
         (projectile-mode)))

(use-package ag)

;; RG
(use-package rg
  :ensure
  :after wgrep
  :config
  (setq rg-group-result t)
  (setq rg-hide-command t)
  (setq rg-show-columns nil)
  (setq rg-show-header t)
  (setq rg-custom-type-aliases nil)
  (setq rg-default-alias-fallback "all")
  (rg-define-search prot/rg-vc-or-dir
                    "RipGrep in project root or present directory."
                    :query ask
                    :format regexp
                    :files "everything"
                    :dir (let ((vc (vc-root-dir)))
                           (if vc
                               vc                         ; search root project dir
                             default-directory))          ; or from the current dir
                    :confirm prefix
                    :flags ("--hidden -g !.git"))

  (rg-define-search prot/rg-ref-in-dir
                    "RipGrep for thing at point in present directory."
                    :query point
                    :format regexp
                    :files "everything"
                    :dir default-directory
                    :confirm prefix
                    :flags ("--hidden -g !.git"))

  (defun prot/rg-save-search-as-name ()
    "Save `rg' buffer, naming it after the current search query.

This function is meant to be mapped to a key in `rg-mode-map'."
    (interactive)
    (let ((pattern (car rg-pattern-history)))
      (rg-save-search-as-name (concat "«" pattern "»"))))

  :bind (("M-s g" . prot/rg-vc-or-dir)
         ("M-s r" . prot/rg-ref-in-dir)
         :map rg-mode-map
         ("s" . prot/rg-save-search-as-name)
         ("C-n" . rg-next-file)
         ("C-p" . rg-prev-file)
         ))

(use-package smart-shift)

(use-package smartparens
  
  :init (progn
          ;; (use-package smartparens-config)
          (setq sp-highlight-pair-overlay nil)
          (setq sp-highlight-wrap-overlay nil)
          (setq sp-highlight-wrap-tag-overlay nil)
          (show-smartparens-global-mode)
          (smartparens-global-mode t)))

(use-package smartscan)
(use-package highlight-symbol)
(use-package drag-stuff)
(use-package expand-region)
(use-package goto-chg)
(use-package phi-search)
(use-package visual-regexp
  :config (progn
            (bind-key "C-c ." 'hide-lines-show-all  vr/minibuffer-keymap )))

(use-package multiple-cursors
  :config (progn
            (bind-key "C--" 'mc-hide-unmatched-lines-mode mc/keymap)))

(use-package imenu
  :init(progn
         (setq imenu-auto-rescan t)))


(use-package  dumb-jump
  :init (progn
          (setq dumb-jump-selector 'helm)))

(use-package winner
  :init (progn
         (winner-mode)))


(use-package window-numbering
  :init (progn
          (defun my/select-window-by-number (i &optional arg)
            "Select window given number I by `window-numbering-mode'.
If prefix ARG is given, delete the window instead of selecting it."
            (interactive "P")
            (let ((windows (car (gethash (selected-frame) window-numbering-table)))
                  window)
              (if (and (>= i 0) (< i 10)
                       (setq window (aref windows i)))
                  (if arg
                      (delete-window window)
                    (select-window window))
                nil)))
          (window-numbering-mode t)
          (window-numbering-clear-mode-line)))

(use-package buffer-move)


;; (use-package eyebrowse
;;   :init (progn
;;           (setq eyebrowse-keymap-prefix "")
;;           (eyebrowse-mode t)))


(use-package elscreen
  :init (progn
  (defun my/elscreen-create-or-clone (arg)
    (interactive "p")
    (if (= arg 1)
        (elscreen-create)
      (elscreen-clone)))
          (setq elscreen-display-screen-number t
                elscreen-display-tab nil
                elscreen-tab-display-control nil
                elscreen-default-buffer-initial-major-mode (quote lisp-interaction-mode)
                elscreen-default-buffer-initial-message nil)
          (elscreen-start)))

(use-package rainbow-delimiters
  :init (progn
          (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)))

(use-package popwin
  :init (progn
          (defun *-popwin-help-mode-off ()
            (when (boundp 'popwin:special-display-config)
              (customize-set-variable 'popwin:special-display-config
                                      (delq 'help-mode popwin:special-display-config))))

          (defun *-popwin-help-mode-on ()
            (when (boundp 'popwin:special-display-config)
              (customize-set-variable 'popwin:special-display-config
                                      (add-to-list 'popwin:special-display-config 'help-mode nil #'eq))))
          (add-hook 'helm-minibuffer-set-up-hook #'*-popwin-help-mode-off)
          (add-hook 'helm-cleanup-hook #'*-popwin-help-mode-on)))


(use-package highlight-symbol :ensure t)

(use-package highlight-indent-guides
  :diminish
  :hook
  ((prog-mode yaml-mode) . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-auto-enabled t)
  (highlight)
  ;; (highlight-indent-guides-responsive t)
  (highlight-indent-guides-method 'column))

(use-package comment-dwim-2)


(setq uniquify-buffer-name-style 'post-forward
      uniquify-separator ":")

(use-package recentf
  :init(progn
         (recentf-mode t)))

;; (use-package desktop
;;   :init (progn
;;           (desktop-save-mode 1)))


(use-package doc-view
  :init (progn
          (with-eval-after-load 'doc-view
            (bind-key "h" 'doc-view-previous-page doc-view-mode-map)
            (bind-key "n" 'doc-view-next-page doc-view-mode-map)
            (bind-key "<left>" 'doc-view-previous-page doc-view-mode-map)
            (bind-key "<right>" 'doc-view-next-page doc-view-mode-map)
            (bind-key "c" 'previous-line doc-view-mode-map)
            (bind-key "t" 'next-line doc-view-mode-map)
            (bind-key "g" 'scroll-down-command doc-view-mode-map)
            (bind-key "r" 'scroll-up-command doc-view-mode-map)
            (bind-key "b" 'doc-view-first-page doc-view-mode-map)
            (bind-key "B" 'doc-view-last-page doc-view-mode-map)
            (bind-key "l" 'doc-view-goto-page doc-view-mode-map)
            (bind-key "/" 'doc-view-shrink doc-view-mode-map)
            (bind-key "=" 'doc-view-enlarge doc-view-mode-map ))))


(use-package pandoc-mode)
(use-package password-generator)

(use-package dired-subtree
  :init (progn
          (setq dired-subtree-use-backgrounds nil)))

(use-package dired-filter)
(use-package dired-ranger)
(use-package dired-open)


(use-package dired-sidebar
  :init (progn
          (setq dired-sidebar-subtree-line-prefix "  "
                dired-sidebar-theme "nerd"
                dired-sidebar-use-custom-font t
                dired-sidebar-use-term-integration t))
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config (progn
            (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
            (push 'rotate-windows dired-sidebar-toggle-hidden-commands)
            (bind-key "o" 'dired-sidebar-find-file-alt dired-sidebar-mode-map)
            (bind-key "M-g" 'dired-subtree-previous-sibling dired-sidebar-mode-map)
            (bind-key "M-r" 'dired-subtree-next-sibling dired-sidebar-mode-map)
            (bind-key "M-H" 'dired-subtree-previous-sibling dired-sidebar-mode-map)
            (bind-key "M-N" 'dired-subtree-next-sibling dired-sidebar-mode-map)
            (bind-key "M-G" 'dired-subtree-beginning dired-sidebar-mode-map)
            (bind-key "M-R" 'dired-subtree-end dired-sidebar-mode-map)
            (bind-key "M-d" 'dired-subtree-up dired-sidebar-mode-map)))



(use-package dired
  :straight nil
  :init (progn
          (defun my/dired-create-file (file)
            (interactive
             (list (read-file-name "Create file: " (dired-current-directory))))
            (let* ((expanded (expand-file-name file))
                   (try expanded)
                   (dir (directory-file-name (file-name-directory expanded)))
                   new)
              (if (file-exists-p expanded)
                  (error "Cannot create file %s: file exists" expanded))
              ;; Find the topmost nonexistent parent dir (variable `new')
              (while (and try (not (file-exists-p try)) (not (equal new try)))
                (setq new try
                      try (directory-file-name (file-name-directory try))))
              (when (not (file-exists-p dir))
                (make-directory dir t))
              (write-region "" nil expanded t)
              (when new
                (dired-add-file new)
                (dired-move-to-filename))
              (revert-buffer)))


          (defun my/display-buffer (buffer window-number)
            (let ((window (cond
                           ((get-buffer-window buffer)
                            (select-window (get-buffer-window buffer)))
                           ((my/select-window-by-number (+ window-number 1)))
                           (t
                            (split-window (selected-window) nil 'right)))))
              ;; (window--display-buffer buffer window 'window nil)
              (window--display-buffer buffer window 'window nil display-buffer-mark-dedicated)
              window))

          (defun my/dired-display (arg)
            (interactive "p")
            (let* ((file-or-dir (dired-get-file-for-visit)))
              (if (f-directory? file-or-dir)
                  (dired-subtree-toggle)
                (my/display-buffer (find-file-noselect file-or-dir) arg))))


          (defun my/dwim-toggle-or-open ()
            "Toggle subtree or open the file."
            (interactive)
            (if (file-directory-p (dired-get-file-for-visit))
                (progn
                  (dired-subtree-toggle)
                  (revert-buffer))
              (dired-find-file)))


          (defun my/dired-back (arg)
            (interactive "p")
            (let* ((file-or-dir (dired-get-file-for-visit)))
              (if (f-directory? file-or-dir)
                  (dired-subtree-toggle)
                (progn
                  (dired-subtree-up)
                  (dired-subtree-toggle)))))


          (defun my/dired-display-in-place (arg)
            (interactive "p")
            (let* ((file-or-dir (dired-get-file-for-visit)))
              (progn
                (my/display-buffer (find-file-noselect file-or-dir) arg)
                (my/select-window-by-number 1))))

          (setq wdired-allow-to-change-permissions t)
          (put 'dired-find-alternate-file 'disabled nil)

          (add-hook 'dired-mode-hook 'auto-revert-mode)
          (add-hook 'dired-mode-hook
                    (lambda ()
                      (dired-hide-details-mode))))
  :config (progn
            (bind-key "a" 'dired-toggle-marks dired-mode-map)
            (bind-key "<tab>" 'my/dired-display dired-mode-map)
            (bind-key "<backtab>" 'my/dired-back dired-mode-map)
            (bind-key "t" 'my/dired-create-file dired-mode-map)
            (bind-key "M-c" 'dired-previous-line dired-mode-map)
            (bind-key "M-C" 'scroll-down-command dired-mode-map)
            (bind-key "M-t" 'dired-next-line dired-mode-map)
            (bind-key "M-T" 'scroll-up-command dired-mode-map)
            (bind-key "M-b" 'beginning-of-buffer dired-mode-map)
            (bind-key "M-B" 'end-of-buffer dired-mode-map)
            (bind-key "l" 'dired-hide-details-mode dired-mode-map)
            (bind-key "'" 'dired-ranger-copy dired-mode-map)
            (bind-key "," 'dired-ranger-paste dired-mode-map)
            (bind-key "." 'dired-ranger-move dired-mode-map)
            (bind-key "C-w" 'kill-this-buffer dired-mode-map)
            (bind-key "@" 'dired-do-async-shell-command dired-mode-map)
            (bind-key "#" 'dired-open-xdg dired-mode-map)
            (bind-key "M-g" 'dired-subtree-previous-sibling dired-mode-map)
            (bind-key "M-r" 'dired-subtree-next-sibling dired-mode-map)
            (bind-key "M-H" 'dired-subtree-previous-sibling dired-mode-map)
            (bind-key "M-N" 'dired-subtree-next-sibling dired-mode-map)
            (bind-key "M-G" 'dired-subtree-beginning dired-mode-map)
            (bind-key "M-R" 'dired-subtree-end dired-mode-map)
            (bind-key "M-d" 'dired-subtree-up dired-mode-map)
            (bind-key "C-r" 'dired-isearch-filenames-regexp dired-mode-map)
            (define-key dired-mode-map (kbd "p") dired-filter-map)))

(use-package treemacs
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-/") #'treemacs))
  :config
  (progn
    (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay      0.5
          treemacs-display-in-side-window        t
          treemacs-eldoc-display                 t
          treemacs-file-event-delay              5000
          treemacs-file-follow-delay             0.2
          treemacs-follow-after-init             nil
          treemacs-git-command-pipe              ""
          treemacs-goto-tag-strategy             'refetch-index
          treemacs-indentation                   2
          treemacs-indentation-string            " "
          treemacs-is-never-other-window         nil
          treemacs-max-git-entries               5000
          treemacs-missing-project-action        'ask
          treemacs-no-png-images                 nil
          treemacs-no-delete-other-windows       t
          treemacs-project-follow-cleanup        nil
          treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                      'left
          treemacs-recenter-distance             0.1
          treemacs-recenter-after-file-follow    nil
          treemacs-recenter-after-tag-follow     nil
          treemacs-recenter-after-project-jump   'always
          treemacs-recenter-after-project-expand 'on-distance
          treemacs-show-cursor                   nil
          treemacs-show-hidden-files             t
          treemacs-silent-filewatch              nil
          treemacs-silent-refresh                nil
          treemacs-sorting                       'alphabetic-asc
          treemacs-space-between-root-nodes      t
          treemacs-tag-follow-cleanup            t
          treemacs-tag-follow-delay              1.5
          treemacs-width                         35)

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'extended))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-follow-mode nil)
    (treemacs-tag-follow-mode nil)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)

    (bind-key "e" 'treemacs-visit-node-ace treemacs-mode-map)
    (bind-key "'" 'treemacs-previous-neighbour treemacs-mode-map)
    (bind-key "," 'treemacs-next-neighbour treemacs-mode-map)
    (bind-key "C-c C-p" 'treemacs-previous-project treemacs-mode-map)
    (bind-key "C-c C-n" 'treemacs-next-project treemacs-mode-map)    
    (bind-key "C-r" 'search-forward treemacs-mode-map)    
    (bind-key "C-l" 'search-backward treemacs-mode-map)    
    (bind-key "C-r" 'swiper treemacs-mode-map)    
    (bind-key "M-," 'swiper-isearch treemacs-mode-map)    
    (bind-key "M-'" 'swiper-backward treemacs-mode-map)    
    )
  )

(use-package treemacs-projectile :after treemacs projectile)
(use-package treemacs-magit :after treemacs magit)

(use-package broadcast)

(use-package emmet-mode
  :init(progn
         (setq emmet-indentation 4
               emmet-preview-default nil)

         (add-hook 'web-mode-hook 'emmet-mode)
         (add-hook 'html-mode-hook 'emmet-mode)
         (add-hook 'jinja2-mode-hook 'emmet-mode)
         (add-hook 'css-mode-hook 'emmet-mode)
         (add-hook 'emmet-mode-hook (lambda()
                                      (unbind-key "C-j" emmet-mode-keymap)
                                      (bind-key "C-c C-w" #'emmet-wrap-with-markup emmet-mode-keymap)
                                      (bind-key "C-c w" #'emmet-wrap-with-markup emmet-mode-keymap)))))



(use-package web-mode
  :init (progn
          (defun my/web-mode-toggle-indent ()
            (interactive)
            (setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
            (setq web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
            (setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))
            (setq emmet-indentation (if (= emmet-indentation 2) 4 2))
            (message "markup-offset, css-offset, code-offset set to %d"
                     web-mode-markup-indent-offset))

          (flycheck-add-mode 'javascript-eslint 'web-mode)


          (add-to-list 'auto-mode-alist '("\\.phtml\\'" . php-mode))
          (add-to-list 'auto-mode-alist '("\\.mjml\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.html\\.eex\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.ejs?\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.tmpl\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.mako\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.jade\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.pug\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.styl\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
          (setq web-mode-engines-alist
                '(("php"   . "\\.phtml\\'")
                  ("mako"  . "\\.tmpl\\'"))
                web-mode-markup-indent-offset 4
                web-mode-css-indent-offset 4
                web-mode-code-indent-offset 4
                web-mode-script-padding 0
                web-mode-style-padding 0
                web-mode-enable-auto-indentation nil
                ))
  :config (progn
            (bind-key "C-c C-/" 'my/web-mode-toggle-indent web-mode-map)
            (bind-key "C-c C-p" 'prettier-js web-mode-map)
            (bind-key "C-c C-=" 'web-mode-set-engine web-mode-map)

            ))


(use-package css-mode
  :init (progn
          (defun my/css-toggle-indent ()
            (interactive)
            (setq c-basic-offset (if (= c-basic-offset 2) 4 2))
            (message "c-basic-offset, js2-indent-level, and js2-basic-offset set to %d"
                     c-basic-offset)))
  :config (progn
            (bind-key "C-c C-/" 'my/css-toggle-indent css-mode-map)
            (bind-key "C-c C-/" 'prettier-js css-mode-map)))
(use-package scss-mode)

(use-package nxml-mode
  :straight nil
  :init (progn
          (add-hook 'nxml-mode-hook
                    (lambda ()
                      (set (make-local-variable 'company-backends) '((company-dabbrev)))            
                      (company-mode t)))))

(use-package xml-format
  :demand t
  :after nxml-mode)


(use-package graphql-mode)
(use-package graphql)

(use-package markdown-mode
  :init(progn
         (setq markdown-xhtml-standalone-regexp ""
               markdown-command "pandoc")
         (add-hook 'markdown-mode-hook
                   (lambda ()
                     (dumb-jump-mode t))))
  :config (progn
            (bind-key "C-c C-," 'dumb-jump-go markdown-mode-map)
            (bind-key "C-c C-'" 'dumb-jump-back markdown-mode-map)))

(use-package json-navigator)

(use-package json-mode
  :init(progn
         (defun my/js2-toggle-indent ()
           (interactive)
           (setq js-indent-level (if (= js-indent-level 2) 4 2))
           (message "js-indent-level, js2-indent-level, and js2-basic-offset set to %d"
                    js-indent-level))
         (add-hook 'json-mode-hook
                   (lambda ()
                     (company-mode 1)
                     (set (make-local-variable 'company-backends) '((company-files company-dabbrev))))))
  :config (progn
            (bind-key "C-c C-/" 'my/js2-toggle-indent json-mode-map)
            (bind-key "C-c C-f" 'json-pretty-print-buffer json-mode-map)
            (bind-key "C-c f" 'json-pretty-print-buffer json-mode-map)
            (bind-key "C-c C-F" 'json-pretty-print-buffer-ordered json-mode-map)
            (bind-key "C-c F" 'json-pretty-print-buffer-ordered json-mode-map)
            (bind-key "C-c C-r" 'json-pretty-print json-mode-map)
            (bind-key "C-c r" 'json-pretty-print json-mode-map)
            (bind-key "C-c C-R" 'json-pretty-print-ordered json-mode-map)
            (bind-key "C-c R" 'json-pretty-print-ordered json-mode-map)
            (bind-key "C-c C-c" 'json-navigator-navigate-after-point json-mode-map)
            (bind-key "C-c C-l" 'json-navigator-navigate-region json-mode-map)))

(use-package yaml-mode
  :config(progn
           (add-hook 'yaml-mode-hook (lambda () (flycheck-mode 1)))
           (bind-key "C-c C-1" 'ansible-doc-mode yaml-mode-map)
           (bind-key "C-c C-d" 'ansible-doc yaml-mode-map)
           (bind-key "C-c 1" 'ansible-doc-mode yaml-mode-map)))


(use-package toml-mode)
(use-package csv-mode)

;; gem install anbt-sql-formatter
;; gem install sqlint
(use-package sql-indent)

(use-package sql
  :init (progn
          (setq sql-connection-alist
                '((localhost (sql-product 'postgres)
                             (sql-port 5432)
                             (sql-server "")
                             (sql-user "postgres")
                             (sql-password nil)
                             (sql-database "postgres"))
                  (odoo-docker (sql-product 'postgres)
                               (sql-port 5433)
                               (sql-server "localhost")
                               (sql-user "odoo")
                               (sql-password "odoo")
                               (sql-database "odoo"))
                  (odoo-local (sql-product 'postgres)
                              (sql-port 5432)
                              (sql-server "localhost")
                              (sql-user "odoo")
                              (sql-password "odoo")
                              (sql-database "odoo"))))

          (defun my-sql-localhost ()
            (interactive)
            (my-sql-connect 'postgres 'localhost))

          (defun my-sql-odoo-local ()
            (interactive)
            (my-sql-connect 'postgres 'odoo-local))

          (defun my-sql-odoo-docker ()
            (interactive)
            (my-sql-connect 'mysql 'odoo-docker))


          (defvar my-sql-servers-list
            '(("localhost" my-sql-localhost)
              ("odoo-local" my-sql-odoo-local)
              ("odoo-docker" my-sql-odoo-docker))
            "Alist of server name and the function to connect")

          (defun my-sql-connect-server (func)
            "Connect to the input server using my-sql-servers-list"
            (interactive
             (helm-comp-read "Select server: " my-sql-servers-list))
            (funcall func))

          (defun my-sql-connect (product connection)
            (let ((connection-info (assoc connection sql-connection-alist)))
              (setq sql-connection-alist (assq-delete-all connection sql-connection-alist))
              (add-to-list 'sql-connection-alist connection-info)
              ;; connect to database
              (setq sql-product product)
              (if current-prefix-arg
                  (sql-connect connection connection)
                (sql-connect connection))))

          (defun sql-beautify-region (beg end)
            "Beautify SQL in region between beg and END."
            (interactive "r")
            (save-excursion
              (shell-command-on-region beg end "anbt-sql-formatter" nil t)))
          ;; change sqlbeautify to anbt-sql-formatter if you
          ;;ended up using the ruby gem

          (defun sql-beautify-buffer ()
            "Beautify SQL in buffer."
            (interactive)
            (sql-beautify-region (point-min) (point-max)))


          (add-hook 'sql-mode-hook
                    (lambda ()
                      (sqlind-minor-mode)
                      (company-mode 1)
                      (set (make-local-variable 'company-backends) '((company-dabbrev-code)))))

          (add-hook 'sql-interactive-mode-hook
                    (lambda ()
                      (toggle-truncate-lines t))))
  :config (progn
            (bind-key "C-c C-f" 'sql-beautify-buffer sql-mode-map)

            (bind-key "C-l" 'comint-clear-buffer sql-interactive-mode-map)
            (bind-key "C-r" 'comint-history-isearch-backward-regexp sql-interactive-mode-map)
            (bind-key "C-M-c" 'comint-previous-input sql-interactive-mode-map)
            (bind-key "C-M-t" 'comint-next-input sql-interactive-mode-map)
            ))

(use-package es-mode
  :init (progn
          (defun my-set-authentication-es (auth)
            (interactive "Mauthentication: ")
            (setq es-default-headers
                  (if (string-blank-p auth)
                      '(( "Content-Type" . "application/json; charset=UTF-8"))
                    (cons (cons "Content-Type" "application/json; charset=UTF-8")
                          (cons "Authorization" (base64-encode-string auth))))))

          (setq es-always-pretty-print 1
                es-default-headers '(("Content-Type" . "application/json; charset=UTF-8")
                                     ("Authorization" . "Basic ZWxhc3RpYzplbGFzdGlj"))))
  :config (progn
            (bind-key "<f8>" 'es-command-center es-mode-map)
            (bind-key "<f9>" 'my-set-authentication-es es-mode-map)))

(use-package company-restclient)
(use-package restclient
  :init (progn
          (setq restclient-inhibit-cookies t)
          (add-to-list 'auto-mode-alist '("\\.rest\\'" . restclient-mode))
          (add-hook 'restclient-mode-hook
                    (lambda ()
                    (company-mode 1)
                    (set (make-local-variable 'company-backends) '((company-dabbrev-code company-restclient)))))))

;; (use-package zenburn-theme)
;; (use-package leuven-theme)
(use-package cyberpunk-theme)

(add-hook 'after-init-hook (lambda () (load-theme 'cyberpunk)))
(setq active-theme 'cyberpunk)
(defun my/toggle-theme ()
  (interactive)
  (disable-theme active-theme)
  (if (eq active-theme 'cyberpunk)
      (setq active-theme 'leuven)
    (setq active-theme 'cyberpunk))
  (load-theme active-theme))

(use-package ob-async)
(use-package ob-sql-mode)
(use-package ob-elixir)
(use-package ob-mongo)
(use-package ob-http)
(use-package ox-rst)

(use-package org-plus-contrib
  :straight nil
  :ensure t
  :mode (("\\.org$" . org-mode))
  :init (progn
          (setq org-CUA-compatible nil
                org-src-preserve-indentation t
                org-pretty-entities nil
                org-pretty-entities-include-sub-superscripts t
                org-startup-truncated t
                org-replace-disputed-keys nil
                ;; org-confirm-babel-evaluate nil
                org-src-fontify-natively t
                org-src-tab-acts-natively t
                org-babel-clojure-backend 'cider
                org-confirm-babel-evaluate nil
                org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar"
                org-agenda-files '("~/.emacs.d/agenda.org")

                org-babel-python-command "python3")
          (org-babel-do-load-languages
           'org-babel-load-languages
           '(
             (shell . t)
             (python . t)
             (R . t)
             (ruby . t)
             (ditaa . t)
             (dot . t)
             (octave . t)
             (js . t)
             (http .t)
             (sqlite . t)
             (elasticsearch . t)
             (sql . t)
             (perl . t)

             ))
          (add-hook 'org-mode-hook (lambda ()
                                     (visual-line-mode)))
          (bind-key "C-c C-;" 'org-attach org-mode-map)
          (bind-key "C-c C-a" 'org-agenda org-mode-map)
          (bind-key "C-c a" 'org-agenda org-mode-map)
          (bind-key "C-c C-q" 'org-edit-src-abort org-src-mode-map)
          (bind-key "M-s" 'er/expand-region org-mode-map)
          (bind-key "M-s" 'er/expand-region org-src-mode-map)
          (bind-key "C-j" 'my/join-line-or-lines-in-region org-mode-map)
          (bind-key "C-j" 'my/join-line-or-lines-in-region org-src-mode-map)
          (unbind-key "C-e" org-mode-map)
          (unbind-key "M-;" org-mode-map)
          (unbind-key "M-;" org-src-mode-map)
          (unbind-key "M-s" org-mode-map)
          (unbind-key "M-s" org-src-mode-map)
          (unbind-key "C-c C-k" org-mode-map)
          (unbind-key "C-c C-k" org-src-mode-map)))

(use-package ledger-mode)
(use-package ledger-import)

(use-package google-translate
  :init (progn
          (setq google-translate-default-source-language "en"
                google-translate-default-target-language "nl")))

(use-package google-this)

(use-package bongo
  :init (progn
          (setq bongo-enabled-backends (quote (vlc))
                bongo-default-directory "~/Music")))

(use-package nov
  :init (progn
          (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
          (setq nov-text-width 80)))

(bind-key "<up>" 'comint-previous-input comint-mode-map)
(bind-key "<down>" 'comint-next-input comint-mode-map)
(bind-key "C-M-c" 'comint-previous-input comint-mode-map)
(bind-key "C-M-t" 'comint-next-input comint-mode-map)
(bind-key "C-r" 'comint-history-isearch-backward-regexp comint-mode-map)
(bind-key "C-c C-q" 'comint-kill-subjob comint-mode-map)
(bind-key "C-S-r" 'helm-swoop comint-mode-map)
(bind-key "C-l" 'comint-clear-buffer comint-mode-map)

(require 'hexl)
(bind-key "M-c" 'previous-line hexl-mode-map)
(bind-key "M-t" 'next-line hexl-mode-map)
(bind-key "M-d" 'beginning-of-line hexl-mode-map)
(unbind-key  "M-b" hexl-mode-map)

(use-package  grammarly
  :config (progn
            (defun test-on-message (data)
              "On message callback with DATA."
              (message "[DATA] %s" data))            
            )
  (add-to-list 'grammarly-on-message-function-list 'test-on-message))

;; Set up a mode for YAML based templates if yaml-mode is installed
;; Get yaml-mode here https://github.com/yoshiki/yaml-mode
(when (featurep 'yaml-mode)

  (define-derived-mode cfn-yaml-mode yaml-mode
    "CFN-YAML"
    "Simple mode to edit CloudFormation template in YAML format.")
  
  (add-to-list 'magic-mode-alist
               '("\\(---\n\\)?AWSTemplateFormatVersion:" . cfn-yaml-mode)))

;; Set up cfn-lint integration if flycheck is installed
;; Get flycheck here https://www.flycheck.org/
(when (featurep 'flycheck)
  (flycheck-define-checker cfn-lint
    "AWS CloudFormation linter using cfn-lint.

Install cfn-lint first: pip install cfn-lint

See `https://github.com/aws-cloudformation/cfn-python-lint'."

    :command ("cfn-lint" "-f" "parseable" source)
    :error-patterns ((warning line-start (file-name) ":" line ":" column
                              ":" (one-or-more digit) ":" (one-or-more digit) ":"
                              (id "W" (one-or-more digit)) ":" (message) line-end)
                     (error line-start (file-name) ":" line ":" column
                            ":" (one-or-more digit) ":" (one-or-more digit) ":"
                            (id "E" (one-or-more digit)) ":" (message) line-end))
    :modes (cfn-json-mode cfn-yaml-mode))

  (add-to-list 'flycheck-checkers 'cfn-lint)
  (add-hook 'cfn-yaml-mode-hook 'flycheck-mode))

(use-package pyvenv
  :config (progn
            (defun my/python-pipenv-activate ()
              (interactive)
              (s-trim (concat "~/.local/share/virtualenvs/"
                              (file-name-nondirectory
                               (shell-command-to-string "pipenv --venv"))))))


  (defun my/python-pipenv-toggle ()
    (interactive)
    (if pyvenv-virtual-env
        (progn
          (message (concat "deactivate " pyvenv-virtual-env))
          (pyvenv-deactivate))
      (progn
        (my/python-pipenv-activate)
        (message (concat "activate " pyvenv-virtual-env)))))
  )

(use-package python
  :init (progn

          (defun my/company-transform-python (candidates)
            (let ((deleted))
              (mapcar #'(lambda (c)
                          (if (or (string-prefix-p "_" c) (string-prefix-p "._" c))
                              (progn
                                (add-to-list 'deleted c)
                                (setq candidates (delete c candidates)))))
                      candidates) 
              (append candidates (nreverse deleted))))



          (defun my/python-switch-version ()
            (interactive)
            (setq python-shell-interpreter
                  (if (string-equal python-shell-interpreter "python3") "python2" "python3"))
            (setq elpy-rpc-python-command
                  (if (string-equal elpy-rpc-python-command "python3") "python2" "python3"))
            (message python-shell-interpreter))

          (defun my/python-toggle-ipython ()
            (interactive)
            (setq python-shell-interpreter
                  (if (string-equal (substring python-shell-interpreter 0 1) "p")
                      (concat "i" python-shell-interpreter)
                    (substring python-shell-interpreter 1)))

            (setq python-shell-interpreter-args
                  (if (string-equal (substring python-shell-interpreter 0 1) "i")
                      "--simple-prompt -i" ""))
            (message python-shell-interpreter))

          (setq expand-region-preferred-python-mode (quote fgallina-python)
                python-shell-completion-native-enable nil
                python-shell-interpreter-args ""
                python-shell-prompt-detect-failure-warning nil
                python-shell-interpreter "python3")
          (add-hook 'inferior-python-mode-hook
                    (lambda ()
                      (show-smartparens-mode -1)))
          (add-hook 'python-mode-hook
                    (lambda ()
                      (flycheck-remove-next-checker 'python-flake8 'python-pylint)
                      (flycheck-select-checker 'python-flake8)
                      (setq-local company-transformers
                                  (append company-transformers '(my/company-transform-python)
                      )))))
  :config (progn
            (bind-key "C-c C-/" 'my/python-switch-version python-mode-map)
            (bind-key "C-c C-=" 'my/python-toggle-ipython python-mode-map)
            (bind-key "C-c C-r" 'python-shell-send-region python-mode-map)
            (bind-key "C-c C-k" 'python-shell-send-buffer python-mode-map)
            (bind-key "C-x C-e" 'python-shell-send-statement python-mode-map)
            (bind-key "C-c C-c" 'python-shell-send-statement python-mode-map)
            (bind-key "C-c C-l" 'python-shell-send-defun python-mode-map)
            (bind-key "C-c C-/" 'python-shell-send-string python-mode-map)
            (bind-key "C-c C-z" 'python-shell-switch-to-shell python-mode-map)
            
            (bind-key "C-l" 'comint-clear-buffer inferior-python-mode-map)
            (bind-key "C-r" 'comint-history-isearch-backward-regexp inferior-python-mode-map)
            (bind-key "C-M-c" 'comint-previous-input inferior-python-mode-map)
            (bind-key "C-M-t" 'comint-next-input inferior-python-mode-map)
            ))


(use-package python-pytest)

;; gem install rdoc pry pry-doc bundler solargraph
(use-package ruby-mode
  :config (progn
          (bind-key "<f8>" 'inf-ruby ruby-mode-map)
          (bind-key "C-c C-z" 'ruby-switch-to-inf ruby-mode-map)
          (bind-key "C-c C-k" 'ruby-send-buffer ruby-mode-map)
          (bind-key "C-c C-b" 'ruby-send-block ruby-mode-map)
          (bind-key "C-c C-l" 'ruby-load-file ruby-mode-map)
          (bind-key "C-c C-r" 'ruby-send-region ruby-mode-map)
          (bind-key "C-c C-c" 'ruby-send-definition ruby-mode-map)
          (bind-key "C-c C-l" 'ruby-send-line ruby-mode-map)
          (bind-key "C-x C-e" 'ruby-send-last-sexp ruby-mode-map)
          (bind-key "C-M-x" 'ruby-send-definition ruby-mode-map)
          (bind-key "C-c M-b" 'ruby-send-block-and-go ruby-mode-map)
          (bind-key "C-c M-r" 'ruby-send-region-and-go ruby-mode-map)
          (bind-key "C-c M-x" 'ruby-send-definition-and-go ruby-mode-map)))

(use-package inf-ruby
  :config (progn
          (setq inf-ruby-default-implementation "pry")
          (bind-key "C-l" 'comint-clear-buffer inf-ruby-mode-map)))

(use-package ess
  :init (progn
          (setq ess-ask-for-ess-directory nil
                ess-eval-visibly t
                ess-eval-empty t)
          (add-hook 'ess-mode-hook
                    (lambda()
                      (bind-key "C-c C-k" 'ess-eval-buffer ess-mode-map)
                      (bind-key "C-c C-l" 'ess-eval-line ess-mode-map)
                      (bind-key "C-l" 'comint-clear-buffer inferior-ess-mode-map)
                      (unbind-key "M-j" ess-mode-map)))))

(use-package add-node-modules-path)
(use-package rjsx-mode)
(use-package xref-js2)
(use-package js2-mode
  :mode (("\\.js\\'" . js2-mode))
  :init (progn
          (defun my/js2-toggle-indent ()
            (interactive)
            (setq js-indent-level (if (= js-indent-level 2) 4 2))
            (setq js-switch-indent-offset (if (= js-switch-indent-offset 2) 4 2))
            (setq js2-indent-level (if (= js2-indent-level 2) 4 2))
            (setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))
            (setq js2-highlight-level (if (= js2-highlight-level 2) 4 2))
            (setq sgml-basic-offset (if (= sgml-basic-offset 2) 4 2))
            (message "js-indent-level, js2-indent-level, and js2-basic-offset set to %d"
                     js-indent-level))

          (defun my/eslint-fix ()
            "Format the current file with ESLint."
            (interactive)
            (if (executable-find "eslint")
                (progn (call-process "eslint" nil "*ESLint Errors*" nil "--fix" buffer-file-name)
                       (revert-buffer t t t))
              (message "ESLint not found.")))


          (setq js-indent-level 4
                js2-basic-offset 4
                js2-highlight-level 4
                js-switch-indent-offset 4
                js-indent-align-list-continuation nil
                sgml-basic-offset 4
                js2-bounce-indent-p nil
                js2-auto-indent-p nil
                js2-indent-on-enter-key t
                js2-global-externs (list "window" "module" "require" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON" "jQuery" "$")
                js2-mode-show-parse-errors nil
                js2-mode-show-strict-warnings nil
                flycheck-temp-prefix ".")

          ;; (setq js-expr-indent-offset -2)
          (advice-add 'js--multi-line-declaration-indentation :around (lambda (orig-fun &rest args) nil))

          (add-hook 'js2-mode-hook
                    (lambda ()
                      (add-node-modules-path)
                      (flycheck-select-checker 'javascript-eslint)
                      (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t))))

  :config (progn
            (bind-key "C-c C-/" 'my/js2-toggle-indent js2-mode-map)
            (bind-key "C-c /" 'my/js2-toggle-indent js2-mode-map)
            (bind-key "C-c C-f" 'my/eslint-fix js2-mode-map)
            (bind-key "C-c f" 'my/eslint-fix js2-mode-map)
            (bind-key "C-c C-p" 'prettier-js js2-mode-map)
            (unbind-key "C-c C-s" js2-mode-map)))


(use-package js2-refactor
  :init(progn
         (add-hook 'js2-mode-hook #'js2-refactor-mode))
  :config(progn
           (bind-key "C-c C-s" 'hydra-js2-refactor/body js2-refactor-mode-map)))

;; JS2-REFACTOR
(defhydra hydra-js2-refactor (:hint nil)
  "
 ^Function^          ^Variables^       ^Contract^          ^Struct^          ^Misc^
 ╭───────────────────────────────────────────────────────────────────────────────────────╯
 [_ef_] extract f    [_ev_] extract    [_cu_] contract f   [_ti_] ternary    [_lt_] log
 [_em_] extract m    [_iv_] inline     [_eu_] expand f     [_uw_] unwrap     [_sl_] slurp
 [_ip_] extract ip   [_rv_] rename     [_ca_] contract a   [_ig_] inject g   [_ba_] barf
 [_lp_] extract lp   [_vt_] var-this   [_ea_] expand a     [_wi_] wrap b
 [_ao_] args-obj     [_sv_] split      [_co_] contract o
  ^ ^                ^ ^               [_eo_] contract o
"
  ("ef" js2r-extract-function)
  ("em" js2r-extract-method)
  ("ip" js2r-introduce-parameter)
  ("lp" js2r-localize-parameter)
  ("ao" js2r-arguments-to-object)
  ("ev" js2r-extract-var)
  ("iv" js2r-inline-var)
  ("rv" js2r-rename-var)
  ("vt" js2r-var-to-this)
  ("sv" js2r-split-var-declaration)
  ("cu" js2r-contract-function)
  ("eu" js2r-expand-function)
  ("ca" js2r-contract-array)
  ("ea" js2r-expand-array)
  ("co" js2r-contract-object)
  ("eo" js2r-expand-object)
  ("ti" js2r-ternary-to-if)
  ("uw" js2r-unwrap)
  ("ig" js2r-inject-global-in-iife)
  ("wi" js2r-wrap-buffer-in-iife)
  ("lt" js2r-log-this)
  ("sl" js2r-forward-slurp)
  ("ba" js2r-forward-barf)
  ("q" nil))



(use-package indium
  :diminish
  :init (progn
          (defun my/cacheclear ()
            (interactive)
            (insert "delete require.cache")
            (indium-repl-return)
            (message "cache cleared"))
          (setq indium-client-debug t)
          (add-hook 'js2-mode-hook (lambda () (indium-interaction-mode)))
          (add-hook 'typescript-mode-hook (lambda () (indium-interaction-mode))))
  :config(progn
           (bind-key "C-c C-1" 'indium-connect indium-interaction-mode-map)
           (bind-key "C-c 1" 'indium-connect indium-interaction-mode-map)
           (bind-key "C-c C-2" 'indium-launch indium-interaction-mode-map)
           (bind-key "C-c 2" 'indium-launch indium-interaction-mode-map)
           (bind-key "C-c C-3" 'indium-reload indium-interaction-mode-map)
           (bind-key "C-c 3" 'indium-reload indium-interaction-mode-map)
           (bind-key "C-c C-4" 'indium-scratch indium-interaction-mode-map)
           (bind-key "C-c 4" 'indium-scratch indium-interaction-mode-map)
           (bind-key "C-c C-5" 'indium-quit indium-interaction-mode-map)
           (bind-key "C-c 5" 'indium-quit indium-interaction-mode-map)
           (bind-key "C-x C-e" 'indium-eval-last-node indium-interaction-mode-map)
           (bind-key "C-c C-k" 'indium-eval-buffer indium-interaction-mode-map)
           (bind-key "C-c C-c" 'indium-eval-defun indium-interaction-mode-map)
           (bind-key "C-c C-r" 'indium-eval-region indium-interaction-mode-map)
           (bind-key "<up>" 'indium-repl-previous-input indium-repl-mode-map)
           (bind-key "<down>" 'indium-repl-next-input indium-repl-mode-map)
           (bind-key "C-c C-r" 'indium-reload indium-repl-mode-map)
           (bind-key "C-c C-l" 'indium-repl-clear-output indium-repl-mode-map)
           (bind-key "C-c C-c" 'my/cacheclear indium-repl-mode-map)))

(use-package typescript-mode
  :mode (("\\.ts\\'" . typescript-mode)
         ("\\.tsx\\'" . typescript-mode ))
  :init (progn
          (defun my/ts2-toggle-indent ()
            (interactive)
            (setq typescript-indent-level(if (= typescript-indent-level 2) 4 2) )
            (message "ts-indent-level set to %d"
                     typescript-indent-level))

          (defun my/eslint-fix ()
            (interactive)
            "Format the current file with ESLint."
            (if (executable-find "eslint")
                (progn (call-process "eslint" nil "*ESLint Errors*" nil "--fix" buffer-file-name)
                       (revert-buffer t t t))
              (message "ESLint not found.")))

          (defun my/tslint-fix ()
            "Tslint fix file."
            (interactive)
            (message (concat "tslint --fixing the file " (buffer-file-name)))
            (shell-command (concat "tslint --fix " (buffer-file-name))))

          (setq typescript-indent-level 4)

          (add-hook 'typescript-mode-hook
                    (lambda ()
                      ;; (flycheck-select-checker 'javascript-eslint)
                      
                      )))

  :config (progn
            (bind-key "C-c /" 'my/ts2-toogle-indent typescript-mode-map)
            (bind-key "C-c C-p" 'prettier-js typescript-mode-map)
            ))

(use-package elm-mode
  :init (progn
          (defun my/elm-toggle-indent ()
            (interactive)
            (setq elm-indent-offset (if (= elm-indent-offset 2) 4 2) )
            (message "elm-indent-level set to %d" elm-indent-offset))
          (add-hook 'elm-mode-hook
                    (lambda()
                      (eldoc-mode -1)
                      (set (make-local-variable 'company-backends) '((company-elm company-dabbrev-code))))))
  :config (progn
            (bind-key "C-c C-d" 'elm-oracle-doc-at-point elm-mode-map)
            (bind-key "C-c M-d" 'elm-documentation-lookup elm-mode-map)
            (bind-key "C-c C-/" 'my/elm-toggle-indent elm-mode-map)))

(use-package coffee-mode
  :init (progn
          (defun my/coffee-toggle-indent ()
            (interactive)
            (if (= coffee-tab-width 2)
                (custom-set-variables '(coffee-tab-width 4))
              (custom-set-variables '(coffee-tab-width 2)))
            (message "indent: %d" coffee-tab-width))

          (add-hook 'coffee-mode-hook
                    (custom-set-variables '(coffee-tab-width 2))
                    (lambda ()
                      (tern-mode 1))))
  :config (progn
            (bind-key "C-c C-/" 'my/coffee-toggle-indent coffee-mode-map)))

;; npm install -g vls

(use-package vue-mode
  :mode "\\.vue\\'"
  :config
  ;; (setq prettier-js-args '("--parser vue")

  )

(use-package emacs-lisp
  :straight nil
  :ensure nil
  :no-require t
  :init (progn
          (defun my-describe-symbol-at-point ()
            (interactive)
            (describe-symbol (or (symbol-at-point) (error "No symbol-at-point"))))
          
          (add-hook 'emacs-lisp-mode-hook
                    (lambda ()
                      (set (make-local-variable 'company-backends) '((company-elisp company-dabbrev-code)))))
          (bind-key "C-c C-c" 'eval-defun emacs-lisp-mode-map)
          (bind-key "C-c C-r" 'eval-region emacs-lisp-mode-map)
          (bind-key "C-c C-k" 'eval-buffer emacs-lisp-mode-map)
          (bind-key "C-c C-e" 'eval-last-sexp emacs-lisp-mode-map)
          (bind-key "C-c e" 'eval-last-sexp emacs-lisp-mode-map)
          (bind-key "C-x C-e" 'eval-last-sexp emacs-lisp-mode-map)
          (bind-key "C-c C-f" 'eval-last-sexp emacs-lisp-mode-map)
          (bind-key "C-c C-d" 'my-describe-symbol-at-point emacs-lisp-mode-map)
          ))

(use-package clojure-mode)
(use-package cider
  :init (progn
          (defun my/cider-load-buffer (&optional BUFFER)
            (interactive)
            (save-buffer)
            (cider-load-buffer BUFFER))
          (add-hook 'cider-mode-hook
                    (lambda ()
                      (set (make-local-variable 'company-backends) '(company-capf)))))
  :config (progn
            (bind-key "C-c d l" 'clojure-cheatsheet cider-mode-map)
            (bind-key "C-c C-b" 'my/cider-load-buffer cider-mode-map)
            (bind-key "C-c C-k" 'cider-load-buffer cider-mode-map)
            (bind-key "C-c C-r" 'cider-eval-region cider-mode-map)
            (bind-key "C-c f f" 'cider-format-defun cider-mode-map)
            (bind-key "C-c f k" 'cider-format-buffer cider-mode-map)
            (unbind-key "C-j" cider-repl-mode-map)
            ))


(use-package clj-refactor
  :init(progn
         (setq cljr-suppress-middleware-warnings t
               cljr-auto-clean-ns nil
               cljr-auto-sort-ns nil
               cljr-auto-eval-ns-form nil)
         (add-hook 'clojure-mode-hook (lambda ()
                                        (clj-refactor-mode 1)
                                        (cljr-add-keybindings-with-prefix "C-c a")))))

(use-package scala-mode
  :interpreter
  ("scala" . scala-mode))

(use-package slime
  :init (progn
          (setq inferior-lisp-program "/usr/bin/sbcl")
          (slime-setup '(slime-fancy)))
  :config (progn
            (bind-key "<f8>" 'slime slime-mode-map)))

(use-package company-lua)
(use-package lua-mode
  :init(progn
         (setq lua-indent-level 2
               lua-prefix-key "C-c")
         (add-hook 'lua-mode-hook
                   (lambda ()
                     (set (make-local-variable 'company-backends) '((company-lua company-dabbrev-code)))))
         (bind-key "C-c C-c" 'lua-send-buffer lua-mode-map)
         (bind-key "C-c C-d" 'lua-search-documentation lua-mode-map)
         (bind-key "C-c C-k" 'lua-send-defun lua-mode-map)
         (bind-key "C-c C-r" 'lua-send-region lua-mode-map))
  :config(progn
           (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
           (add-to-list 'interpreter-mode-alist '("lua" . lua-mode))))

(use-package elixir-mode)

(use-package alchemist
  :init(progn
         (setq alchemist-goto-elixir-source-dir "/usr/local/lib/elixir/"
               alchemist-goto-erlang-source-dir "/usr/local/lib/elixir/lib")
         (add-hook 'alchemist-mode-hook
                   (lambda ()
                     (set (make-local-variable 'company-backends) '((alchemist-company)))))
         (add-hook 'alchemist-iex-mode-hook
                   (lambda ()
                     (company-mode-on)
                     (set (make-local-variable 'company-backends) '((alchemist-company))))))
  :config (progn
            (bind-key "<f8>" 'alchemist-iex-run alchemist-mode-map)
            (bind-key "<f9>" 'alchemist-iex-project-run alchemist-mode-map)
            (bind-key "C-c C-c" 'alchemist-iex-send-current-line alchemist-mode-map)
            (bind-key "C-x C-e" 'alchemist-iex-send-last-sexp alchemist-mode-map)
            (bind-key "C-c C-r" 'alchemist-iex-send-region alchemist-mode-map)
            (bind-key "C-c C-k" 'alchemist-iex-compile-this-buffer alchemist-mode-map)
            (bind-key "C-c C-l" 'alchemist-iex-reload-module alchemist-mode-map)
            (bind-key "C-c C-z" 'alchemist-iex-run alchemist-mode-map)
            ;; (bind-key "C-c C-f" 'elixir-format alchemist-mode-map)
            ;; (bind-key "C-c C-," 'alchemist-goto-definition-at-point alchemist-mode-map)
            ;; (bind-key "C-c C-'" 'alchemist-goto-jump-back alchemist-mode-map)
            ;; (bind-key "C-c C-d" 'alchemist-help-search-at-point alchemist-mode-map)
            (unbind-key "M-,"  alchemist-mode-map)
            (unbind-key "M-'"  alchemist-mode-map)
            (bind-key "C-M-c" 'comint-previous-input alchemist-iex-mode-map)
            (bind-key "C-M-t" 'comint-next-input alchemist-iex-mode-map)
            ;; (unbind-key "C-M-c"  alchemist-iex-mode-map)
            ;; (unbind-key "C-M-t"  alchemist-iex-mode-map)
            (bind-key "C-l" 'alchemist-iex-clear-buffer alchemist-iex-mode-map)))

(use-package company-shell)
(use-package sh-script
  :init (progn
          (defun sh-send-line-or-region (&optional step)
            (interactive ())
            (let ((proc (get-process "shell"))
                  pbuf min max command)
              (unless proc
                (let ((currbuff (current-buffer)))
                  (shell)
                  (switch-to-buffer currbuff)
                  (setq proc (get-process "shell"))
                  ))
              (setq pbuff (process-buffer proc))
              (if (use-region-p)
                  (setq min (region-beginning)
                        max (region-end))
                (setq min (point-at-bol)
                      max (point-at-eol)))
              (setq command (concat (buffer-substring min max) "\n"))
              (with-current-buffer pbuff
                (goto-char (process-mark proc))
                (insert command)
                (move-marker (process-mark proc) (point))
                (setq comint-scroll-to-bottom-on-output t)
                ) 
              (process-send-string  proc command)
              ;; (display-buffer (process-buffer proc) t)
              (when step 
                (goto-char max)
                (next-line))
              ))
          (defun sh-send-line-or-region-and-step ()
            (interactive)
            (sh-send-line-or-region t))

          (add-hook 'sh-mode-hook
                    (lambda ()
                      (set (make-local-variable 'company-backends) '((company-shell))))
                    
                    )
          (bind-key "C-c C-c" 'sh-send-line-or-region-and-step sh-mode-map)
          (bind-key "C-c C-r" 'sh-send-line-or-region-and-step sh-mode-map)))

(use-package php-mode
  :mode (("\\.php\\'" . php-mode))
  :config (progn
          (unbind-key "M-q" php-mode-map)
          (unbind-key "M-j" php-mode-map)
          (unbind-key "C-d" php-mode-map)
          (unbind-key "C-." php-mode-map)))

(use-package c-mode-common
  :straight nil
  :ensure nil
  :no-require t
  :init(progn
         (setq-default c-basic-offset 4 c-default-style "linux")
         (setq-default tab-width 4 indent-tabs-mode nil)
         (setq irony-supported-major-modes '(c++-mode c-mode objc-mode))
         (add-hook 'c-mode-hook
                   (lambda ()
                     (bind-key "C-c C-z" 'gdb c-mode-map)
                     (unbind-key "C-d" c-mode-map)
                     (unbind-key "M-q" c-mode-map)
                     (unbind-key "C-c C-d" c-mode-map)))
         (add-hook 'c++-mode-hook
                   (lambda ()
                     (unbind-key "C-d" c++-mode-map)
                     (unbind-key "M-q" c++-mode-map)
                     (unbind-key "C-c C-d" c++-mode-map)))))

(use-package cc-mode
  :init (progn
          (add-hook 'java-mode-hook
                    (add-hook 'before-save-hook nil))
  :config (progn
            (unbind-key "M-q" java-mode-map)
            (unbind-key "C-d" java-mode-map)
            (unbind-key "C-C C-c" java-mode-map)
            )))

(use-package go-mode
 
  :init (progn
          (setenv "GOROOT" "/opt/go")
          (setenv "GOPATH" "/home/vince/.go")
          (setq gofmt-command "goimports")
          (add-hook 'go-mode-hook
                    (lambda ()
                      (add-hook 'before-save-hook 'gofmt-before-save)
                      (flycheck-mode 1))))
  :config (progn
            (bind-key "C-c C-a" 'go-goto-imports go-mode-map)
            (bind-key "C-c C-o" 'go-import-add go-mode-map)
            (bind-key "C-c C-e" 'go-remove-unused-imports go-mode-map)
            (bind-key "C-c C-'" 'go-goto-function go-mode-map)
            (bind-key "C-c C-," 'go-goto-arguments go-mode-map)
            (bind-key "C-c C-." 'go-goto-function-name go-mode-map)
            (bind-key "C-c C-p" 'go-goto-return-values go-mode-map)
            (bind-key "C-c C-d" 'godef-describe go-mode-map)
            (bind-key "C-c C-l" 'godef-jump go-mode-map)
            (bind-key "C-c C-/" 'godef-jump-other-window go-mode-map)
            (bind-key "C-c C--" 'godoc-at-point go-mode-map)
            (bind-key "C-c C-\\" 'godoc go-mode-map)
            (bind-key "C-c C-f" 'gofmt go-mode-map)))

(use-package company-go)


(use-package go-eldoc
  :init (progn
          (add-hook 'go-mode-hook 'go-eldoc-setup)))

;; curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
;;curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o ~/.local/bin/rust-analyzer
;; ln -s ~/.local/bin/rust-analyzer /home/vince/.cargo/bin
;; rustup component add --toolchain nightly clippy
;; rustup toolchain install nightly --allow-downgrade --profile minimal --component clippy

(use-package flycheck-rust)
(use-package rustic
  ;; :straight (:host github :repo "brotzeit/rustic" :branch "master")
  :config (progn
             (setq rustic-lsp-server 'rust-analyzer
                   lsp-rust-analyzer-server-command "~/.local/bin/rust-analyzer"
                   rustic-flycheck-clippy-params "--message-format=json"
)
             (add-to-list 'flycheck-checkers 'rustic-clippy)))

(use-package ron-mode
  :straight (:host github :repo "rhololkeolke/ron-mode" :branch "master")
  :mode "\\.ron\\'"
)

(use-package gdscript-mode)

;; sudo pacman -S ganache
;; sudo pacman -S solidity
;; npm install -g solium

(bind-key "C-M-c" 'previous-line-or-history-element minibuffer-local-map)
(bind-key "C-M-t" 'next-line-or-history-element minibuffer-local-map)

;; MARK COMMAND, COMPLETE, YAS, TAB, SAVE
(unbind-key "<tab>" minibuffer-local-completion-map)
(unbind-key "<tab>" minibuffer-local-map)
(bind-key "M-SPC" 'set-mark-command)
(bind-key "C-SPC" 'company-complete)
(bind-key "C-M--" 'smart-shift-left)
(bind-key "C-M-\\" 'smart-shift-right)
(bind-key "<backtab>" 'smart-shift-left)
(bind-key "C-<tab>" 'smart-shift-right)
(bind-key "M--" 'yas-expand)
(bind-key "M-\\" 'my/open-file-at-cursor)
(bind-key "C-\\" 'flycheck-mode)
(bind-key "C-|" 'global-flycheck-mode)
(bind-key* "C-a" 'mark-whole-buffer)
(bind-key "C-c C-/" 'my/toggle-indent-level)
(bind-key "<M-return>" 'my/smart-ret)
(bind-key "<S-return>" 'my/smart-ret-reverse)
(bind-key "<escape>" 'keyboard-espace-quit)
(bind-key "M-m" 'emmet-expand-line)
(bind-key "C-c w" 'emmet-wrap-with-markup)
(bind-key "C-c C-w" 'emmet-wrap-with-markup)
(bind-key "C-s" 'my/save-all)
(bind-key "C-x C-s" 'save-buffer)
(bind-key "C-x s" 'my/revert-buffer-no-confirm)
(bind-key "C-c C-."'xref-find-references)
(bind-key "C-c C-,"'xref-find-definitions)
(bind-key "C-c C-'" 'xref-pop-marker-stack)


;; MOVE KEY
(bind-key "M-c" 'previous-line)
(bind-key "M-t" 'next-line)
(bind-key* "M-h" 'backward-char)
(bind-key* "M-n" 'forward-char)
(bind-key "M-g" 'backward-word)
(bind-key* "M-r" 'forward-word)
(bind-key "M-C" 'scroll-down-command)
(bind-key "M-T" 'scroll-up-command)
(bind-key "M-G" 'my/backward-block)
(bind-key "M-R" 'my/forward-block)
(bind-key "M-d" 'my/beginning-of-line-or-block)
(bind-key "M-D" 'end-of-line)
(bind-key "M-b" 'beginning-of-buffer)
(bind-key "M-B" 'end-of-buffer)

;; SP
(bind-key* "C-M-v" 'sp-next-sexp)
(bind-key* "C-M-w" 'sp-previous-sexp)
(bind-key* "M-v" 'sp-end-of-sexp)
(bind-key* "M-w" 'sp-beginning-of-sexp)
(bind-key* "M-V" 'sp-down-sexp)
(bind-key* "M-W" 'sp-backward-down-sexp)
(bind-key* "C-M-S-v" 'sp-beginning-of-next-sexp)
(bind-key* "C-M-S-w" 'sp-beginning-of-previous-sexp)
(bind-key* "C-S-w" 'sp-up-sexp)
(bind-key* "C-S-v" 'sp-backward-up-sexp)
(bind-key "M-Z" 'scroll-other-window)
(bind-key "C-M-Z" 'scroll-other-window-down)


;; SHOW DOC
(bind-key "C-c C-t" 'my/company-show-doc-buffer-at-point)
(bind-key "C-c C-l" 'my/company-show-doc-location-at-point)


;; DUMP JUMP
(bind-key "M-\," 'helm-swoop)
(bind-key "M-\'" 'helm-swoop-back-to-last-point)

;; ELSCREEN
;; (bind-key* "C-M-t" 'my/elscreen-create-or-clone)
;; (bind-key* "C-M-c" 'elscreen-kill)
(bind-key* "C-M-h" 'winner-undo)
(bind-key* "C-M-n" 'winner-redo)

;; PERSP
;; (bind-key* "C-M-\'" 'persp-prev)
;; (bind-key* "C-M-," 'persp-next)
;; (bind-key* "C-M-." 'persp-switch)
;; (bind-key* "C-M-p" 'persp-kill)


(bind-key "M-H" 'sp-backward-sexp)
(bind-key "M-N" 'sp-forward-sexp)
(bind-key* "M-9" 'sp-splice-sexp)
(bind-key* "M-0" 'sp-rewrap-sexp)
(bind-key* "M-[" 'sp-forward-barf-sexp)
(bind-key* "M-]" 'sp-forward-slurp-sexp)
(bind-key* "M-{" 'sp-backward-barf-sexp)
(bind-key* "M-}" 'sp-backward-slurp-sexp)
(bind-key "C-S-j" 'sp-join-sexp)


;; DELETE KEY
(bind-key* "M-e" 'backward-delete-char-untabify)
(bind-key* "M-u" 'delete-char)
(bind-key "M-E" 'sp-backward-kill-sexp)
(bind-key "M-U" 'sp-kill-sexp)
(bind-key* "M-." 'backward-kill-word)
(bind-key* "M->" 'zap-to-char)
(bind-key* "M-p" 'kill-word)
(bind-key* "M-i" 'kill-line)
(bind-key* "M-I" 'my/kill-line-backward)

;; COPY, CUT, PASTE, REDO, UNDO ,DUPLICATE, JOIN
(bind-key "M-q" 'my/cut-line-or-region)
(bind-key "M-Q" 'my/cut-line-or-region)
(bind-key "M-j" 'my/copy-line-or-region)
(bind-key "M-J" 'sp-backward-copy-sexp)
(bind-key* "C-M-J" 'sp-copy-sexp)
(bind-key* "M-k" 'yank)
(bind-key "M-K" 'yank-pop)
(bind-key* "C-z" 'undo-tree-undo)
(bind-key* "C-S-z" 'undo-tree-redo)

(bind-key "C-x u" 'undo-tree-visualize)
(bind-key "C-d" 'my/duplicate-current-line-or-region)
(bind-key "C-j" 'my/join-line-or-lines-in-region)


;; POP, GOTO, INFO, SCALE, CAMEL, RECENTER, REPLACE
(bind-key* "M-f" 'goto-last-change)
(bind-key* "M-F" 'goto-last-change-reverse)

;; (bind-key* "M-f" 'jump-tree-jump-prev)
;; (bind-key* "M-F" 'jump-tree-jump-next)

(bind-key* "C-S-s" 'ido-write-file)
(bind-key "C-l" 'goto-line)
(bind-key* "C-=" 'text-scale-increase)
(bind-key* "C-+" 'text-scale-decrease)
(bind-key* "M-z" 'my/toggle-letter-case)

;; FRAME CLOSE BUFFER, COMMENT
(bind-key* "C-b" 'make-frame-command)
(bind-key "C-w" 'my/kill-buffer)
(bind-key* "C-S-w" 'my/kill-all-dired-buffers)
(bind-key* "C-x C-w" 'my/close-all-buffers)
(bind-key* "M-;" 'comment-dwim-2)
(bind-key* "M-:" 'comment-box)

;; COMMAND, SHELL, RUN, EMMET
(bind-key* "M-a" 'helm-M-x)
(bind-key* "M-A" 'shell-command)
(bind-key* "M-C-a" 'shell-command-on-region)
(bind-key* "M-C-S-a" 'eval-expression)
(bind-key* "M-1" 'my/shell-dwim)
(bind-key* "M-!" 'my/eshell-dwim)
;; (bind-key "M-/" 'dired-sidebar-toggle-sidebar)
(bind-key "M-/" 'treemacs)
(bind-key "M-?" 'treemacs-find-file)
(bind-key "M-)" 'balance-windows)
(bind-key* "<f4>" 'kmacro-end-or-call-macro-repeat)
(bind-key "S-<f5>" 'compile)
(bind-key "<f5>" 'recompile)
(bind-key "S-<f6>" 'my/run-in-eshell)
(bind-key "<f6>" 'my/re-run-in-eshell)
(bind-key* "<f7>" 'helm-bookmarks)
(bind-key* "S-<f10>" 'quick-calc)
(bind-key* "<f10>" 'calc)
(bind-key* "<f12>" 'toggle-frame-fullscreen)
(bind-key* "C-o" 'helm-find-files)
(global-set-key (kbd "M-o") 'projectile-find-file)
(bind-key* "C-S-o" 'find-name-dired)
(bind-key* "C-M-o" 'helm-recentf)
(bind-key* "C-M-S-o" 'helm-tramp)
(global-set-key (kbd "C-e") 'helm-buffers-list)
(bind-key* "C-S-e" 'ibuffer)
(bind-key* "C-M-e" 'ibuffer)
;; (global-set-key (kbd "C-M-e") 'helm-projectile-switch-to-buffer)

;; HELM AG
(bind-key* "C-f" 'my/helm-do-ag-project-root)
(bind-key* "C-S-f" 'helm-do-ag)
(bind-key* "C-M-f" 'helm-do-ag-buffers)

;; SWIPER
(bind-key "C-r" 'swiper)
(bind-key "C-S-r" 'pop-global-mark)

(bind-key "C-p" 'helm-semantic-or-imenu)
(bind-key* "C-y" 'helm-show-kill-ring)
(bind-key* "M-y" 'helm-all-mark-rings)
(bind-key "C-h a" 'helm-apropos)
(bind-key "C-h o" 'helm-man-woman)


;; DIRED
(bind-key* "C-x j" 'dired-jump)
(bind-key "C-x C-j" 'find-name-dired)
(bind-key "C-x J" 'find-grep-dired)
(bind-key "C-x C-J" 'find-lisp-find-dired)
(bind-key "C-x M-j" 'locate)
(bind-key "C-x M-J" 'locate-with-filter)
(bind-key* "C-/" 'projectile-dired)

;; UNWRAP
(bind-key "C-c ("  'wrap-with-parens)
(bind-key "C-c ["  'wrap-with-brackets)
(bind-key "C-c {"  'wrap-with-braces)
(bind-key "C-c '"  'wrap-with-single-quotes)
(bind-key "C-c \"" 'wrap-with-double-quotes)
(bind-key "C-c _"  'wrap-with-underscores)
(bind-key "C-c `"  'wrap-with-back-quotes)

;; JUMP TREE
(bind-key "C-x i"  'jump-tree-visualize)
;; MAGIT
(bind-key "C-x g" 'magit-status)
(bind-key* "C-x G" 'magit-file-dispatch)
(bind-key "C-x M-G" 'git-timemachine)
(bind-key "C-x C-M-S-G" 'magit-find-file)

;; SELECTION
(bind-key "M-l" 'my/select-current-line)
(bind-key "M-L" 'my/select-current-block)
(bind-key "C-M-l" 'er/mark-defun)
(bind-key* "M-s" 'er/expand-region)
(bind-key* "M-S" 'er/mark-symbol)
(bind-key* "C-M-s" 'er/mark-inside-pairs)
(bind-key* "C-S-M-s" 'er/mark-inside-quotes)

;; SWITCH BUFFER
(bind-key* "C-'" 'my/next-user-buffer)
(bind-key* "C-," 'my/previous-user-buffer)
(bind-key* "C-\"" 'my/previous-user-dired-buffer)
(bind-key* "C-<" 'my/next-user-dired-buffer)

;; NEXT SYMBOL
(bind-key* "C-M-\"" 'flycheck-previous-error)
(bind-key* "C-M-<" 'flycheck-next-error)
(bind-key* "C-M-." 'flycheck-list-errors)


;; WINDOW MOVE
(bind-key* "C-S-h" 'windmove-left)
(bind-key* "C-S-n" 'windmove-right)
(bind-key* "C-S-c" 'windmove-up)
(bind-key* "C-S-t" 'windmove-down)


;; WINDOW SWITCH
(bind-key* "C-S-M-h" 'buf-move-left)
(bind-key* "C-S-M-n" 'buf-move-right)
(bind-key* "C-S-M-c" 'buf-move-up)
(bind-key* "C-S-M-t" 'buf-move-down)


;; WINDOW CREATE SPLIT CLOSE
(bind-key* "M-2" 'delete-window)
(bind-key* "M-3" 'delete-other-windows)
(bind-key* "M-4" 'split-window-below)
(bind-key* "M-$" 'split-window-right)
(bind-key* "M-@" 'balance-windows)

(defhydra hydra-window (:hint nil :color pink)
  "
    ^Movement^      ^Split^             ^Switch^     ^Resize^     ^Buffer^
  ╭───────────────────────────────────────────────────────────────────╯
    [_h_] ←         [_r_] vertical      [_C-h_] ←    [_H_] X←     [_e_] buffer
    [_t_] ↓         [_g_] horizontal    [_C-t_] ↓    [_T_] X↓     [_o_] find
    [_c_] ↑         [_z_] undo          [_C-c_] ↑    [_C_] X↑     [_'_] previous
    [_n_] →         [_y_] redo         [_C-n_] →    [_N_] X→     [_,_] next
    [_F_] follow    [_d_] delete        ^     ^      [_b_] bal    [_w_] delete
    ^ ^             [_l_] other
"
  ("h" windmove-left)
  ("t" windmove-down)
  ("c" windmove-up)
  ("n" windmove-right)
  ("F" follow-mode)
  ("r" split-window-right)
  ("g" split-window-below)
  ("z" winner-undo)
  ("y" winner-redo)
  ("d" delete-window)
  ("l" delete-other-windows)
  ("C-h" buf-move-left)
  ("C-t" buf-move-down)
  ("C-c" buf-move-up)
  ("C-n" buf-move-right)
  ("H" shrink-window-horizontally)
  ("T" shrink-window)
  ("C" enlarge-window)
  ("N" enlarge-window-horizontally)
  ("b" balance-windows)
  ("e" helm-mini)
  ("o" helm-find-files)
  ("'" my/previous-user-buffer)
  ("," my/next-user-buffer)
  ("w" kill-this-buffer)
  ("1" my/split-project-1 :color blue)
  ("2" my/split-project-2 :color blue)
  ("3" my/split-project-3 :color blue)
  ("4" my/split-2-shell :color blue)
  ("5" my/split-2-2-shell :color blue)
  ("q" nil))

(defhydra hydra-docker (:color blue :hint nil)
  "
     ^Images^           ^Containers^         ^volumes^         ^networks^
  ╭─────────────────────────────────────────────────────────────────────╯
     _i_: list          _c_: list            _v_: list         _n_: list
     _f_: pull          _o_: stop            _V_: delete       _N_: delete
     _p_: push          _p_: pause
     _r_: run           _u_: unpause
     _D_: delete        _d_: delete
     ^ ^                _s_: start
     ^ ^                _r_: restart
     ^ ^                _k_: kill

"
  ("i" docker-images :color blue)
  ("f" docker-pull :color blue)
  ("p" docker-push :color blue)
  ("r" docker-restart :color blue)
  ("D" docker-rmi :color blue)
  ("c" docker-containers :color blue)
  ("o" docker-stop :color blue)
  ("p" docker-pause :color blue)
  ("u" docker-upause :color blue)
  ("k" docker-kill :color blue)
  ("r" docker-restart :color blue)
  ("s" docker-start :color blue)
  ("d" docker-rm :color blue)
  ("v" docker-volumes :color blue)
  ("V" docker-volume-rm :color blue)
  ("n" docker-networks :color blue)
  ("N" docker-network-rm :color blue)
  ("q" nil :color blue))




(defhydra hydra-execute (:color blue :hint nil)
  "
    [_a_] hs       [_/_] fast            [_w_] dirname    [_p_] pandoc  [_l_] higlight
    [_o_] search   [_=_] slow            [_W_] pdirname   [_b_] qcalc   [__]
    [_e_] ediff    [_f_] flycheck        [_v_] filename   [_B_] calc
    [_._] revert   [_u_] shell-scroll    [_V_] basename   [_;_] sudo
"
  ("a" hydra-hs/body)
  (";" my/sudo-edit-current-file)
  ("f" prot/rg-vc-or-dir)
  ("o" prot/rg-vc-or-dir)
  ("O" prot/rg-ref-in-dir)
  ("e" hydra-ediff/body)
  ("f" hydra-flycheck/body)
  ("u" my/toggle-shell-scroll)
  ("l" highlight-symbol)
  ("L" highlight-symbol-remove-all)
  ("b" quick-calc )
  ("B" calc )
  ("p" pandoc-main-hydra/body)
  ("\\" my/toggle-theme)
  ("w" my/dirname-buffer)
  ("W" my/project-dirname-buffer)
  ("v" my/filename-buffer)
  ("V" my/basename-buffer)
  ("." my/revert-buffer-no-confirm)
  ("h" (elscreen-goto 0))
  ("t" (elscreen-goto 1))
  ("n" (elscreen-goto 2))
  ("s" (elscreen-goto 3))
  ("H" (elscreen-goto 4))
  ("T" (elscreen-goto 5))
  ("N" (elscreen-goto 6))
  ("S" (elscreen-goto 7))
  ("r" rg)
  ("-" hydra-lsp/body)
  ("<return>" my-dap-hydra/body)
  ("C-<return>" dap-debug-last)
  ("S-<return>" dap-debug)
  ("/" my/toggle-speed-fast)
  ("=" my/toggle-speed-slow)
  ("1" hydra-docker/body)
  ("!" docker-compose)
  ("2" my-sql-connect-server)
  ("@" sql-set-sqli-buffer)
  ("4" elpy-shell-switch-to-shell)
  ("$" my/python-toggle-ipython)
  ("'" persp-prev)
  ("\," persp-next)
  ("q" nil :color blue))


(defhydra hydra-lsp (:exit t :hint nil)
  "
 ^Buffer^               ^ ^                     ^Server^          ^Lens^
-------------------------------------------------------------------------------------
 [_d_] describe        [_o_] definition        [_ws_] describe    [_ls_] show
 [_a_] execute         [_e_] references        [_wS_] shutdown    [_lh_] hide
 [_f_] format          [_t_] to-definition     [_wr_] restart     [_lt_] toggle
 [_r_] rename          [_i_] to-implem         [_wa_] add         [_ll_] saveLogs
 [_s_] search                                  [_wm_] switch
 [_S_] search G         ^ ^                    [_wd_] remove
"
  ("," xref-find-definitions )
  ("'" xref-pop-marker-stack)
  ("." xref-find-references)
  ("o" xref-find-definitions-other-window )
  ("d" lsp-describe-thing-at-point)
  ("a" lsp-execute-code-action)
  ("f" lsp-format-buffer)
  ("r" lsp-rename)
  ("s" netrom/helm-lsp-workspace-symbol-at-point "Helm search")
  ("S" netrom/helm-lsp-global-workspace-symbol-at-point "Helm global search")
  ("d" lsp-describe-thing-at-point)
  ("wr" lsp-restart-workspace)
  ("wS" lsp-shutdown-workspace)
  ("wa" lsp-workspace-folders-add)
  ("wd" lsp-workspace-folders-remove)
  ("wm" lsp-workspace-folders-switch)
  ("ws" lsp-describe-session)
  ("o" lsp-find-definition)
  ("e" lsp-find-references)
  ("t" lsp-goto-type-definition)
  ("i" lsp-goto-implementation)
  ("ls" lsp-lens-show)
  ("lh" lsp-lens-hide)
  ("lt" lsp-lens-mode)
  ("ll" lsp-save-logs)
  ("q" nil :color blue)
)


(defhydra hydra-eyebrowse (:color red :hint nil)
  "
  [_c_] create    [_n_] next        [_d_] kill     [_e_] helm
  [_r_] rename    [_h_] previous
"
  ("c" eyebrowse-create-window-config)
  ("d" eyebrowse-close-window-config)
  ("n" eyebrowse-next-window-config)
  ("h" eyebrowse-prev-window-config)
  ("e" eyebrowse-switch-to-window-config)
  ("r" eyebrowse-rename-window-config)
  ("g" keyboard-quit)
  ("q" nil :color blue))



(defhydra hydra-elscreen (:color red :hint nil)
  "
  [_t_] create    [_n_] next        [_c_] kill     [_e_] helm     [_i_] show-tab
  [_T_] clone     [_h_] previous    [_C_] killB    [_j_] dired    [_b_] show-buf
  [_a_] toggle    [_d_] goto        [_s_] swap     [_l_] list
"
  ("t" elscreen-create)
  ("T" elscreen-clone)
  ("a" elscreen-toggle)
  ("n" elscreen-next)
  ("h" elscreen-previous)
  ("d" elscreen-goto)
  ("c" elscreen-kill)
  ("C" elscreen-kill-screen-and-buffers)
  ("s" elscreen-swap)
  ("e" helm-elscreen :color blue)
  ("j" elscreen-dired)
  ("i" elscreen-toggle-display-tab)
  ("b" elscreen-toggle-display-screen-number)
  ("l" elscreen-display-screen-name-list)
  ("1" (elscreen-goto 0) :color blue)
  ("2" (elscreen-goto 1) :color blue)
  ("3" (elscreen-goto 2) :color blue)
  ("4" (elscreen-goto 3) :color blue)
  ("5" (elscreen-goto 4) :color blue)
  ("g" keyboard-quit)
  ("q" nil :color blue))


(defhydra hydra-persp (:color red :hint nil)
  "
  [_h_] previous  [_s_] switch       [_d_] kill     [a] add  [l] last
  [_n_] next      [_r_] rename       [_i_] import   [o] set  [b] buffer
"
  ("h" persp-prev)
  ("n" persp-next)
  ("s" persp-switch)
  ("r" persp-rename)
  ("d" persp-kill)
  ("i" persp-import)
  ("a" persp-add-buffer)
  ("o" persp-set-buffer)
  ("g" keyboard-quit)
  ("q" nil :color blue))


(defhydra hydra-yasnippet (:color blue :hint nil)
  "
     ^Modes^   ^Load/Visit^   ^Actions^
  ╭────────────────────────────────────╯
     _o_lobal  _d_irectory   _i_nsert
     _m_inor   _f_ile        _t_ryout
     _e_xtra   _l_ist        _n_ew
     _a_ll
"
  ("d" yas-load-directory)
  ("e" yas-activate-extra-mode)
  ("i" yas-insert-snippet)
  ("f" yas-visit-snippet-file :color blue)
  ("n" yas-new-snippet)
  ("t" yas-tryout-snippet)
  ("l" yas-describe-tables)
  ("o" yas/global-mode)
  ("m" yas/minor-mode)
  ("a" yas-reload-all)
  ("g" keyboard-quit)
  ("q" nil :color blue))



(defhydra hydra-project (:color teal :hint nil)
  "
    Files             Search          Buffer             Do         │ Projectile │
  ╭─────────────────────────────────────────────────────────────────┴────────────╯
    [_f_] file        [_a_] grep          [_e_] switch         [_g_] magit
    [_o_] file dwim   [_s_] occur         [_v_] show all       [_p_] project
    [_r_] recent file [_S_] replace       [_V_] ibuffer        [_i_] info
    [_d_] dir         [_t_] find tag      [_K_] kill all
    [_l_] other       [_T_] make tags
    [_u_] test file
    [_h_] root
                                                                        ╭────────┐
    Other Window      Run             Cache              Do             │ Fixmee │
  ╭──────────────────────────────────────────────────╯ ╭────────────────┴────────╯
    [_F_] file          [_U_] test        [_kc_] clear         [_x_] TODO & FIXME
    [_O_] dwim          [_m_] compile     [_kk_] add current   [_X_] toggle
    [_D_] dir           [_c_] shell       [_ks_] cleanup
    [_L_] other         [_C_] command     [_kd_] remove
    [_E_] buffer
  "
  ("<tab>" hydra-master/body "back")
  ("<ESC>" nil "quit")
  ("a"  helm-projectile-grep)
  ("b"  projectile-switch-to-buffer)
  ("e"  helm-projectile-switch-to-buffer)
  ("E"  projectile-switch-to-buffer-other-window)
  ("c"  projectile-run-async-shell-command-in-root)
  ("C"  projectile-run-command-in-root)
  ("d"  helm-projectile-find-dir)
  ("D"  projectile-find-dir-other-window)
  ("f"  helm-projectile-find-file)
  ("F"  projectile-find-file-other-window)
  ("g"  projectile-vc)
  ("h"  projectile-dired)
  ("i"  projectile-project-info)
  ("kc" projectile-invalidate-cache)
  ("kd" projectile-remove-known-project)
  ("kk" projectile-cache-current-file)
  ("K"  projectile-kill-buffers)
  ("ks" projectile-cleanup-known-projects)
  ("o"  helm-projectile-find-file-dwim)
  ("O"  projectile-find-file-dwim-other-window)
  ("m"  projectile-compile-project)
  ("l"  helm-projectile-find-other-file)
  ("L"  projectile-find-other-file-other-window)
  ("p"  projectile-switch-project)
  ("r"  helm-projectile-recentf)
  ("s"  projectile-multi-occur)
  ("S"  projectile-replace)
  ("t"  projectile-find-tag)
  ("T"  projectile-regenerate-tags)
  ("u"  projectile-find-test-file)
  ("U"  projectile-test-project)
  ("v"  projectile-display-buffer)
  ("V"  projectile-ibuffer)
  ("X"  fixmee-mode)
  ("x"  fixmee-view-listing)
  ("q"  nil :color blue))


(defhydra hydra-navigate (:color pink :hint nil)
  "
 ^Align^             ^Sort^              ^Replace^        ^Occur^          ^Grep s/j^     ^Fill Lines^
╭────────────────────────────────────────────────────────────────────────────────────────────╯
 [_aa_] align        [_ol_] lines        [_e_] regexp     [_po_] occur     [_;g_] grep     [_ik_] keep
 [_ac_] current      [_op_] paragraphs   [_E_] replace    [_pm_] multi     [_;l_] lgrep    [_is_] flush
 [_ae_] entire       [_oP_] Pages        [_._] mark       [_pa_] match     [_;r_] rgrep    [_if_] paragrah
 [_ah_] highlight    [_of_] fields       [_\'_] prev      [_pp_] project   [_;d_] delete   [_ir_] region
 [_an_] new          [_on_] numerics     [_,_] next       [_ph_] helm      [_;j_] join     [_iw_] column
 [_ar_] regex        [_oc_] columns      ^^               [_pt_] helm-m    [_;o_] ins      [_i._] prefix
 [_au_] un-hilight   [_or_] regex        ^^               [_d_] unique     ^   ^           [_il_] centerL
 [_w_]  whitespace   [_oR_] reverse      ^^               ^   ^            ^   ^           [_ih_] centerR
"
  ("n" forward-char)
  ("h" backward-char)
  ("r" forward-word)
  ("R" my/forward-block)
  ("g" backward-word)
  ("G" my/backward-block)
  ("l" my/select-current-line)
  ("L" my/select-current-block)
  ("t" next-line)
  ("c" previous-line)
  ("T" scroll-up-command)
  ("C" scroll-down-command)
  ("m" org-mark-ring-push)
  ("/" org-mark-ring-goto :color blue)
  ("b" beginning-of-buffer)
  ("B" end-of-buffer)
  ("d" delete-duplicate-lines)
  ("[" backward-sexp)
  ("]" forward-sexp)
  ("j" my/copy-line-or-region)
  ("Q" append-next-kill)
  ("k" yank)
  ("K" yank-pop)
  ("aa" align)
  ("ac" align-current)
  ("ae" align-entire)
  ("ah" align-highlight-rule)
  ("an" align-newline-and-indent)
  ("ar" align-regexp)
  ("au" align-unhighlight-rule)
  ("oP" sort-pages)
  ("oR" reverse-region)
  ("oc" sort-columns)
  ("of" sort-fields)
  ("ol" sort-lines)
  ("on" sort-numeric-fields)
  ("op" sort-paragraphs)
  ("or" sort-regexp-fields)
  ("e" vr/replace :color blue)
  ("E" vr/query-replace :color blue)
  ("." vr/mc-mark :color blue)
  ("po" occur :color blue)
  ("pm" multi-occur :color blue)
  ("pa" multi-occur-in-matching-buffers :color blue)
  ("pp" projectile-multi-occur :color blue)
  ("ph" helm-occur :color blue)
  ("pt" multi-occur-in-matching-buffers :color blue)
  ("\'" highlight-symbol-prev)
  ("," highlight-symbol-next)
  (";g" grep :color blue)
  (";l" lgrep :color blue)
  (";r" rgrep :color blue)
  (";d" delete-blank-lines)
  (";j" my/join-line-or-lines-in-region)
  (";o" open-line)
  ("ik" keep-lines :color blue)
  ("is" flush-lines :color blue)
  ("if" fill-paragraph)
  ("ir" fill-region)
  ("iw" set-fill-column)
  ("i." set-fill-prefix)
  ("il" center-line)
  ("ih" center-region)
  ("ij" my/join-line-or-lines-in-region)
  ("C-t" my/toggle-case)
  ("x" exchange-point-and-mark)
  ("w" delete-trailing-whitespace)
  ("s" er/expand-region)
  ("!" shell-command-on-region)
  ("u" universal-argument)
  ("z" undo-tree-undo)
  ("y" undo-tree-redo)
  ("SPC" set-mark-command)
  ("C-\'" mc-hide-unmatched-lines-mode)
  ("q" nil :color blue))



(defhydra hydra-transpose (:color pink :hint nil)
  "
      ^^^^Drag^^^^          ^Transpose^                          ^Org^
╭──────────────────────────────────────────────────────────────────────────╯
       ^^^_c_^^^            [_s_] characters  [_r_] sentences    [_o_] word
       ^^^^↑^^^^            [_w_] words       [_p_] paragraphs   [_e_] elements
_H_  _h_ ←   → _n_ _N_      [_l_] line        [_d_] fix          [_i_] table
       ^^^^↓^^^           ╭─────────────────────┐
       ^^^_t_^^^            [_z_] cancel   [_y_ redo]
"
  ("c" drag-stuff-up)
  ("h" (transpose-sexps -1))
  ("n" transpose-sexps)
  ("H" drag-stuff-left)
  ("N" drag-stuff-right)
  ("t" drag-stuff-down)
  ("s" transpose-chars)
  ("S" (transpose-chars -1))
  ("w" transpose-words)
  ("W" (transpose-words -1))
  ("l" transpose-lines)
  ("L" (transpose-lines -1))
  ("r" transpose-sentences)
  ("R" (transpose-sentences -1))
  ("p" transpose-paragraphs)
  ("P" (transpose-paragraphs -1))
  ("d" transpose-chars :color blue)
  ("o" org-transpose-words)
  ("e" org-transpose-elements)
  ("i" org-table-transpose-table-at-point)
  ("z" undo-tree-undo)
  ("y" undo-tree-redo)
  ("q" nil :color blue)
  ("g" keyboard-quit))


(defun ora-ex-point-mark ()
  (interactive)
  (if rectangle-mark-mode
      (exchange-point-and-mark)
    (let ((mk (mark)))
      (rectangle-mark-mode 1)
      (goto-char mk))))

(defhydra hydra-rectangle (:hint nil
                                 :body-pre (rectangle-mark-mode 1)
                                 :color pink
                                 :post (deactivate-mark))
  "
        ^_c_^
        ^^↑^^        [_e_] delete      [_j_] copy     [_r_] reset   [_l_] mark
    _h_ ←   → _n_    [_s_] tring       [_k_] paste    [_z_] undo
        ^^↓^^        [_x_] xchange     [_d_] kill     [_y_] redo
        ^_t_^
"
  ("h" backward-char nil)
  ("n" forward-char nil)
  ("c" previous-line nil)
  ("t" next-line nil)
  ("e" delete-rectangle nil)
  ("s" string-rectangle nil)
  ("x" ora-ex-point-mark nil)
  ("j" copy-rectangle-as-kill nil)
  ("k" yank-rectangle nil)
  ("l" vr/mc-mark)
  ("d" kill-rectangle nil)
  ("r" (if (region-active-p)
           (deactivate-mark)
         (rectangle-mark-mode 1)) nil)
  ("z" undo-tree-undo)
  ("y" undo-tree-redo)
  ("q" nil)
  ("g" keyboard-quit))



(defun my/mark-previous-like-this (x)
  (interactive "p")
  (if (use-region-p)
      (mc/mark-previous-like-this 1)
    (progn
      (er/expand-region 1)
      (mc/mark-previous-like-this 1))))

(defun my/mark-next-like-this (x)
  (interactive "p")
  (if (use-region-p)
      (mc/mark-next-like-this 1)
    (progn
      (er/expand-region 1)
      (mc/mark-next-like-this 1))))



(defhydra hydra-multiple-cursors (:hint nil :color pink)
  "
^Up^            ^Down^          ^Multiple^    ^Other^       ^Search^        ^Special^
╭────────────────────────────────────────────────────────────────────────────────────────╯
[_h_] Next      [_n_] Next      [_r_] Line    [_a_] All     [_._] Next       [_in_] numbers
[_H_] Skip      [_N_] Skip      [_l_] Begin   [_d_] Regex   [_,_] Previous   [_il_] letters
[_c_] Unmark    [_t_] Unmark    [_/_] End     [_j_] Copy    [_k_] Paste      [_is_] sort
^ ^             ^ ^             ^ ^           [_e_] del     [_o_] fun        [_ir_] reverse
"
  ("h" my/mark-previous-like-this)
  ("H" mc/skip-to-previous-like-this)
  ("t" mc/unmark-previous-like-this)
  ("n" my/mark-next-like-this)
  ("N" mc/skip-to-next-like-this)
  ("c" mc/unmark-next-like-this)
  ("r" mc/edit-lines :color blue)
  ("l" mc/edit-beginnings-of-lines :color blue)
  ("/" mc/edit-ends-of-lines :color blue)
  ("a" mc/mark-all-like-this :color blue)
  ("o" mc/mark-all-like-this-dwim :color blue)
  ("d" vr/mc-mark :color blue)
  ("e" backward-delete-char-untabify)
  ("." phi-search)
  ("," phi-search-backward)
  ("j" copy-rectangle-as-kill)
  ("k" yank-rectangle)
  ("s" er/expand-region)
  ("in" mc/insert-numbers)
  ("il" mc/insert-letters)
  ("is" mc/sort-regions)
  ("ir" mc/reverse-regions)
  ("z" undo-tree-undo)
  ("y" undo-tree-redo)
  ("q" nil :color blue)
  ("g" mc/keyboard-quit)
  ("\'" mc-hide-unmatched-lines-mode)
  ("-" mc-hide-unmatched-lines-mode)
  ("C-\'" mc-hide-unmatched-lines-mode)
  ("C--" mc-hide-unmatched-lines-mode))



(defhydra hydra-bookmark (:hint nil :color blue)
  "
     ^all^
╭────────────────────────────╯
     [_h_] jump
     [_d_] delete
"
  ("h" helm-bookmarks)
  ("d" bookmark-delete)
  ("n" bmkp-desktop-jump)
  ("N" bmkp-set-desktop-bookmark)
  ("\'" (switch-to-buffer "*scratch*"))
  ("," (switch-to-buffer "*scratch-2*"))
  ("." (switch-to-buffer "*scratch-3*"))
  ("s1" (find-file "~/.emacs.d/files/sql/my_sql_1.sql"))
  ("s2" (find-file "~/.emacs.d/files/sql/my_sql_2.sql"))
  ("s3" (find-file "~/.emacs.d/files/sql/my_sql_3.sql"))
  ("s4" (find-file "~/.emacs.d/files/sql/my_sql_4.sql"))
  ("s5" (find-file "~/.emacs.d/files/sql/my_sql_5.sql"))
  ("b1" (find-file "~/.emacs.d/files/sh/my_sh_1.sh"))
  ("b2" (find-file "~/.emacs.d/files/sh/my_sh_2.sh"))
  ("b3" (find-file "~/.emacs.d/files/sh/my_sh_3.sh"))
  ("b4" (find-file "~/.emacs.d/files/sh/my_sh_4.sh"))
  ("b5" (find-file "~/.emacs.d/files/sh/my_sh_5.sh"))
  ("o1" (find-file "~/.emacs.d/files/org/my_org_1.org"))
  ("o2" (find-file "~/.emacs.d/files/org/my_org_2.org"))
  ("o3" (find-file "~/.emacs.d/files/org/my_org_3.org"))
  ("o4" (find-file "~/.emacs.d/files/org/my_org_4.org"))
  ("o5" (find-file "~/.emacs.d/files/org/my_org_5.org"))
  ("e1" (find-file "~/.emacs.d/files/elasticsearch/my_es_1.es"))
  ("e2" (find-file "~/.emacs.d/files/elasticsearch/my_es_2.es"))
  ("e3" (find-file "~/.emacs.d/files/elasticsearch/my_es_3.es"))
  ("e4" (find-file "~/.emacs.d/files/elasticsearch/my_es_4.es"))
  ("e5" (find-file "~/.emacs.d/files/elasticsearch/my_es_5.es"))
  ("p1" (find-file "~/.emacs.d/files/python/my_python_1.py"))
  ("p2" (find-file "~/.emacs.d/files/python/my_python_2.py"))
  ("p3" (find-file "~/.emacs.d/files/python/my_python_3.py"))
  ("p4" (find-file "~/.emacs.d/files/python/my_python_4.py"))
  ("p5" (find-file "~/.emacs.d/files/python/my_python_5.py"))
  ("j1" (find-file "~/.emacs.d/files/js/my_js_1.js"))
  ("j2" (find-file "~/.emacs.d/files/js/my_js_2.js"))
  ("j3" (find-file "~/.emacs.d/files/js/my_js_3.js"))
  ("j4" (find-file "~/.emacs.d/files/js/my_js_4.js"))
  ("j5" (find-file "~/.emacs.d/files/js/my_js_5.js"))
  ("t1" (find-file "~/.emacs.d/files/typescript/my_ts_1.ts"))
  ("t2" (find-file "~/.emacs.d/files/typescript/my_ts_2.ts"))
  ("t3" (find-file "~/.emacs.d/files/typescript/my_ts_3.ts"))
  ("t4" (find-file "~/.emacs.d/files/typescript/my_ts_4.ts"))
  ("t5" (find-file "~/.emacs.d/files/typescript/my_ts_5.ts"))
  ("r1" (find-file "~/.emacs.d/files/ruby/my_ruby_1.rb"))
  ("r2" (find-file "~/.emacs.d/files/ruby/my_ruby_2.rb"))
  ("r3" (find-file "~/.emacs.d/files/ruby/my_ruby_3.rb"))
  ("r4" (find-file "~/.emacs.d/files/ruby/my_ruby_4.rb"))
  ("r5" (find-file "~/.emacs.d/files/ruby/my_ruby_5.rb"))
  ("c1" (find-file "~/.emacs.d/files/clojure/play/src/play/core.clj"))
  ("c2" (find-file "~/.emacs.d/files/clojure/music/src/music/core.clj"))
  ("c3" (find-file "~/.emacs.d/files/clojure/my_clojure_3.clj"))
  ("c4" (find-file "~/.emacs.d/files/clojure/my_clojure_4.clj"))
  ("c5" (find-file "~/.emacs.d/files/clojure/my_clojure_5.clj"))
  ("l1" (progn (find-file "~/.emacs.d/files/restclient/my_restclient_1.el") (restclient-mode)))
  ("l2" (progn (find-file "~/.emacs.d/files/restclient/my_restclient_2.el") (restclient-mode)))
  ("l3" (progn (find-file "~/.emacs.d/files/restclient/my_restclient_3.el") (restclient-mode)))
  ("l4" (progn (find-file "~/.emacs.d/files/restclient/my_restclient_4.el") (restclient-mode)))
  ("l5" (progn (find-file "~/.emacs.d/files/restclient/my_restclient_5.el") (restclient-mode)))
  ("/1" (progn (find-file "~/.emacs.d/files/redis/my_redis_1.redis") (redis-mode)))
  ("/2" (progn (find-file "~/.emacs.d/files/redis/my_redis_2.redis") (redis-mode)))
  ("/3" (progn (find-file "~/.emacs.d/files/redis/my_redis_3.redis") (redis-mode)))
  ("/4" (progn (find-file "~/.emacs.d/files/redis/my_redis_4.redis") (redis-mode)))
  ("/5" (progn (find-file "~/.emacs.d/files/redis/my_redis_5.redis") (redis-mode)))
  ("1" (find-file "~/.emacs.d/settings.org"))
  ("2" (find-file "~/.emacs.d/life.org"))
  ("3" (find-file "~/.emacs.d/work.org"))
  ("4" (find-file "~/.emacs.d/agenda.org"))
  ("q" nil :color blue))


(defhydra hydra-macro (:hint nil :color pink :pre
                             (when defining-kbd-macro
                               (kmacro-end-macro 1)))
  "
  ^^Create-Cycle^^   ^Basic^            ^   ^       ^Insert^        ^Save^           ^Edit^
╭───────────────────────────────────────────────────────────────────────────────────╯
     ^_c_^           [_a_] defun      [_m_] step    [_i_] insert    [_b_] name       [_'_] previous
     ^^↑^^           [_o_] edit       [_s_] swap    [_s_] set       [_k_] key        [_,_] last
 _h_ ←   → _n_       [_e_] execute    [_v_] view    [_r_] add       [_x_] register   [_._] loosage
     ^^↓^^           [_d_] delete     ^   ^         [_f_] format
     ^_t_^           [_r_] region
    ^^   ^^
"
  ("h" kmacro-start-macro :color blue)
  ("n" kmacro-end-or-call-macro-repeat)
  ("N" kmacro-end-or-call-macro-repeat :color blue)
  ("c" kmacro-cycle-ring-previous)
  ("t" kmacro-cycle-ring-next)
  ("a" insert-kbd-macro)
  ("r" apply-macro-to-region-lines)
  ("d" kmacro-delete-ring-head)
  ("e" helm-execute-kmacro)
  ("o" kmacro-edit-macro-repeat)
  ("m" kmacro-step-edit-macro)
  ("s" kmacro-swap-ring)
  ("i" kmacro-insert-counter)
  ("l" kmacro-set-counter)
  ("r" kmacro-add-counter)
  ("f" kmacro-set-format)
  ("b" kmacro-name-last-macro)
  ("k" kmacro-bind-to-key)
  ("x" kmacro-to-register)
  ("'" kmacro-edit-macro)
  ("," edit-kbd-macro)
  ("." kmacro-edit-lossage)
  ("u" universal-argument)
  ("z" undo-tree-undo)
  ("y" undo-tree-redo)
  ("v" kmacro-view-macro)
  ("V" kmacro-view-ring-2nd-repeat)
  ("q" nil :color blue))



(defhydra hydra-ggtags (:color teal :hint nil)
  "
 ^Find^                           ^Other^         ^Options^
╭─────────────────────────────────────────────────────────╯
  [_d_] definition  [_e_] dwin    [_-_] repl      v search
  [_f_] file        [_o_] reg     [_z_] def       l navigation
  [_s_] symbol      [_i_] query   [_/_] update    m option
  [_r_] reference   [_'_] prev
  [_c_] continue[   [_,_] next
"
  ("d" ggtags-find-definition)
  ("f" ggtags-find-file)
  ("s" ggtags-find-other-symbol)
  ("r" ggtags-find-reference)
  ("c" ggtags-find-tag-continue)
  ("e" ggtags-find-tag-dwim)
  ("o" ggtags-find-tag-regexp)
  ("g" ggtags-grep)
  ("i" ggtags-idutils-query)
  ("," ggtags-next-mark)
  ("'" ggtags-prev-mark)
  ("-" ggtags-query-replace)
  ("z" ggtags-show-definition)
  ("/" ggtags-update-tags)
  ("vv" ggtags-view-search-history)
  ("va" ggtags-view-search-history-action)
  ("vk" ggtags-view-search-history-kill)
  ("vl" ggtags-view-search-history-mode)
  ("vn" ggtags-view-search-history-next)
  ("vh" ggtags-view-search-history-prev)
  ("vu" ggtags-view-search-history-update)
  ("vh" ggtags-view-tag-history)
  ("v." ggtags-view-tag-history-mode)
  ("ln" ggtags-navigation-isearch-forward)
  ("ll" ggtags-navigation-last-error)
  ("l." ggtags-navigation-mode)
  ("lt" ggtags-navigation-next-file)
  ("lc" ggtags-navigation-previous-file)
  ("ls" ggtags-navigation-start-file)
  ("lv" ggtags-navigation-visible-mode)
  ("mb" ggtags-browse-file-as-hypertext)
  ("mc" ggtags-create-tags)
  ("md" ggtags-delete-tags)
  ("me" ggtags-explain-tags)
  ("mk" ggtags-kill-file-buffers)
  ("mw" ggtags-kill-window)
  ("mr" ggtags-reload)
  ("ms" ggtags-save-project-settings)
  ("me" ggtags-save-to-register)
  ("ml" ggtags-toggle-project-read-only)
  ("q" nil :color blue))


(defhydra hydra-major (:color teal :hint nil)
  "
    [_t_] text  [_d_] diff    [_l_] prog     [_o_] org
    [_h_] html  [_c_] css     [_s_] scss     [_j_] jinja
    [_J_] js    [_p_] python  [_C_] clojure  [_r_] ruby  [_e_] elisp
    [_n_] json  [_m_] md      [_x_] jsx
"
  ("t" text-mode)
  ("d" diff-mode)
  ("l" prog-mode)
  ("o" org-mode)
  ("h" html-mode)
  ("c" css-mode)
  ("s" scss-mode)
  ("j" jinja2-mode)
  ("J" js2-mode)
  ("p" python-mode)
  ("C" clojure-mode)
  ("r" ruby-mode)
  ("e" emacs-lisp-mode)
  ("n" json-mode)
  ("m" markdown-mode)
  ("x" js2-jsx-mode)
  ("q" nil :color blue)
  ("g" keyboard-quit))


(defhydra hydra-flycheck
  (:pre (progn (setq hydra-lv t) (flycheck-list-errors))
   :post (progn (setq hydra-lv nil) (quit-windows-on "*Flycheck errors*"))
   :hint nil)
  "Errors"
  ("f"  flycheck-error-list-set-filter                            "Filter")
  ("n"  flycheck-next-error                                       "Next")
  ("p"  flycheck-previous-error                                   "Previous")
  ("h"  flycheck-previous-error                                   "Previous")
  ("H" flycheck-first-error                                      "First")
  ("N"  (progn (goto-char (point-max)) (flycheck-previous-error)) "Last")
  ("q"  nil))



(defhydra hydra-minor (:color amaranth :hint nil)
  "
    [_a_] abbrev    [_d_] debu   [_l_] line     [_n_] nyan     [_wb_] sub
    [_r_] truncate  [_s_] save   [_t_] typo     [_v_] visual   [_ws_] sup
    [_e_] desktop                [_f_] flyspell [_c_] flycheck  [_C-t_] case
     ^ ^             ^ ^         [_p_] fly-prog
"
  ("a" abbrev-mode)
  ("d" toggle-debug-on-error)
  ("f" auto-fill-mode)
  ("l" linum-mode)
  ("n" nyan-mode)
  ("r" toggle-truncate-lines)
  ("s" auto-save-buffers-enhanced-toggle-activity)
  ("t" typo-mode)
  ("v" visual-line-mode)
  ("e" desktop-save-mode)
  ("f" flyspell-mode)
  ("p" flyspell-prog-mode)
  ("c" flycheck-mode)
  ("wb" subword-mode)
  ("ws" superword-mode)
  ("C-t" my/toggle-case)
  ("q" nil :color blue)
  ("g" nil))



(defhydra hydra-apropos (:color teal)
  ("a" helm-apropos "apropos")
  ("w" helm-man-woman "man")
  ("c" apropos-command "cmd")
  ("d" apropos-documentation "doc")
  ("e" apropos-value "val")
  ("l" apropos-library "lib")
  ("o" apropos-user-option "option")
  ("v" apropos-variable "var")
  ("i" info-apropos "info")
  ("t" tags-apropos "tags")
  ("z" hydra-customize-apropos/body "customize")
  ("q" nil :color blue)
  ("g" keyboard-quit))


(defhydra hydra-goto-line (goto-map ""
                           :pre (linum-mode 1)
                           :post (linum-mode -1))
  "goto-line"
  ("g" goto-line "go")
  ("m" set-mark-command "mark" :bind nil)
  ("q" nil "quit"))


(defhydra hydra-helm (:color teal :hint nil)
  "
[_x_]  M-x    [_y_] ring      [_b_] mini     [_f_] find     [_s_] grep
[_i_] imenu   [_hm_] find     [_h/_] locate  [_l_] occur    [_a_] apropos
[_hhg_] gnus  [_hhi_] info    [_hhr_] emacs  [_cr_] resume  [_m_] mark
[_r_] regex   [_p_] register  [_t_] top      [_cs_] surf    [_g_] google
[_cc_] color  [_:_] eldoc     [_,_] calcul   [_ci_] input   [_cm_] hist
"
  ("x" helm-M-x)
  ("y" helm-show-kill-ring)
  ("b" helm-mini)
  ("f" helm-find-files)
  ("s" helm-ff-run-grep)
  ("i" helm-semantic-or-imenu)
  ("hm" helm-find)
  ("h/" helm-locate)
  ("l" helm-occur)
  ("a" helm-apropos)
  ("hhg" helm-info-gnus)
  ("hhi" helm-info-at-point)
  ("hhr" helm-info-emacs)
  ("cr" helm-resume)
  ("m" helm-all-mark-rings)
  ("r" helm-regexp)
  ("p" helm-register)
  ("t" helm-top)
  ("cs" helm-surfraw)
  ("g" helm-google-suggest)
  ("cc" helm-colors)
  (":" helm-eval-expression-with-eldoc)
  ("," helm-calcul-expression)
  ("ci" helm-comint-input-ring)
  ("cm" helm-minibuffer-history)
  ("q" nil :color blue))


(defhydra hydra-outline (:color pink :hint nil)
  "
    ^Hide^             ^Show^           ^Move^
  ╭─────────────────────────────────────────────────────────────────────────────────╯
    [_q_] sublevels     [_a_] all         [_u_] up
    [_b_] body          [_e_] entry       [_c_] previous visible
    [_o_] other         [_i_] children    [_t_] next visible
    [_r_] entry         [_k_] branches    [_n_] forward same level
    [_l_] leaves        [_s_] subtree     [_h_] backward same level
    [_d_] subtree
"
  ("q" hide-sublevels)
  ("b" hide-body)
  ("o" hide-other)
  ("r" hide-entry)
  ("l" hide-leaves)
  ("d" hide-subtree)
  ("a" show-all)
  ("e" show-entry)
  ("i" show-children)
  ("k" show-branches)
  ("s" show-subtree)
  ("u" outline-up-heading)
  ("c" outline-previous-visible-heading)
  ("t" outline-next-visible-heading)
  ("n" outline-forward-same-level)
  ("h" outline-backward-same-level)
  ("z" undo-tree-undo)
  ("y" undo-tree-redo)
  ("g" keyboard-quit)
  ("q" nil :color blue))


(defhydra hydra-org-agenda (:pre (setq which-key-inhibit t)
                                 :post (setq which-key-inhibit nil)
                                 :hint none)
  "
Org agenda (_q_uit)

^Clock^      ^Visit entry^              ^Date^             ^Other^
^-----^----  ^-----------^------------  ^----^-----------  ^-----^---------
_ci_ in      _SPC_ in other window      _ds_ schedule      _gr_ reload
_co_ out     _TAB_ & go to location     _dd_ set deadline  _._  go to today
_cq_ cancel  _RET_ & del other windows  _dt_ timestamp     _gd_ go to date
_cj_ jump    _o_   link                 _+_  do later      ^^
^^           ^^                         _-_  do earlier    ^^
^^           ^^                         ^^                 ^^
^View^          ^Filter^                 ^Headline^         ^Toggle mode^
^----^--------  ^------^---------------  ^--------^-------  ^-----------^----
_vd_ day        _ft_ by tag              _ht_ set status    _tf_ follow
_vw_ week       _fr_ refine by tag       _hk_ kill          _tl_ log
_vt_ fortnight  _fc_ by category         _hr_ refile        _ta_ archive trees
_vm_ month      _fh_ by top headline     _hA_ archive       _tA_ archive files
_vy_ year       _fx_ by regexp           _h:_ set tags      _tr_ clock report
_vn_ next span  _fd_ delete all filters  _hp_ set priority  _td_ diaries
_vp_ prev span  ^^                       ^^                 ^^
_vr_ reset      ^^                       ^^                 ^^
^^              ^^                       ^^                 ^^
"
  ;; Entry
  ("hA" org-agenda-archive-default)
  ("hk" org-agenda-kill)
  ("hp" org-agenda-priority)
  ("hr" org-agenda-refile)
  ("h:" org-agenda-set-tags)
  ("ht" org-agenda-todo)
  ;; Visit entry
  ("o"   link-hint-open-link :exit t)
  ("<tab>" org-agenda-goto :exit t)
  ("TAB" org-agenda-goto :exit t)
  ("SPC" org-agenda-show-and-scroll-up)
  ("RET" org-agenda-switch-to :exit t)
  ;; Date
  ("dt" org-agenda-date-prompt)
  ("dd" org-agenda-deadline)
  ("+" org-agenda-do-date-later)
  ("-" org-agenda-do-date-earlier)
  ("ds" org-agenda-schedule)
  ;; View
  ("vd" org-agenda-day-view)
  ("vw" org-agenda-week-view)
  ("vt" org-agenda-fortnight-view)
  ("vm" org-agenda-month-view)
  ("vy" org-agenda-year-view)
  ("vn" org-agenda-later)
  ("vp" org-agenda-earlier)
  ("vr" org-agenda-reset-view)
  ;; Toggle mode
  ("ta" org-agenda-archives-mode)
  ("tA" (org-agenda-archives-mode 'files))
  ("tr" org-agenda-clockreport-mode)
  ("tf" org-agenda-follow-mode)
  ("tl" org-agenda-log-mode)
  ("td" org-agenda-toggle-diary)
  ;; Filter
  ("fc" org-agenda-filter-by-category)
  ("fx" org-agenda-filter-by-regexp)
  ("ft" org-agenda-filter-by-tag)
  ("fr" org-agenda-filter-by-tag-refine)
  ("fh" org-agenda-filter-by-top-headline)
  ("fd" org-agenda-filter-remove-all)
  ;; Clock
  ("cq" org-agenda-clock-cancel)
  ("cj" org-agenda-clock-goto :exit t)
  ("ci" org-agenda-clock-in :exit t)
  ("co" org-agenda-clock-out)
  ;; Other
  ("q" nil :exit t)
  ("gd" org-agenda-goto-date)
  ("." org-agenda-goto-today)
  ("gr" org-agenda-redo))


 (defhydra hydra-org-clock (:color blue :hint nil)
   "
^Clock:^ ^In/out^     ^Edit^   ^Summary^    | ^Timers:^ ^Run^           ^Insert
-^-^-----^-^----------^-^------^-^----------|--^-^------^-^-------------^------
(_?_)    _i_n         _e_dit   _g_oto entry | (_z_)     _r_elative      ti_m_e
 ^ ^     _c_ontinue   _q_uit   _d_isplay    |  ^ ^      cou_n_tdown     i_t_em
 ^ ^     _o_ut        ^ ^      _r_eport     |  ^ ^      _p_ause toggle
 ^ ^     ^ ^          ^ ^      ^ ^          |  ^ ^      _s_top
"
   ("i" org-clock-in)
   ("c" org-clock-in-last)
   ("o" org-clock-out)

   ("e" org-clock-modify-effort-estimate)
   ("q" org-clock-cancel)

   ("g" org-clock-goto)
   ("d" org-clock-display)
   ("r" org-clock-report)
   ("?" (org-info "Clocking commands"))

  ("r" org-timer-start)
  ("n" org-timer-set-timer)
  ("p" org-timer-pause-or-continue)
  ("s" org-timer-stop)

  ("m" org-timer)
  ("t" org-timer-item)
  ("z" (org-info "Timers")))



(defhydra hydra-org-template (:color blue :hint nil)
    "
 _c_enter  _q_uote     _e_macs-lisp    _L_aTeX:
 _l_atex   _E_xample   _p_erl          _i_ndex:
 _a_scii   _v_erse     _P_erl tangled  _I_NCLUDE:
 _s_rc     _n_ote      plant_u_ml      _H_TML:
 _h_tml    ^ ^         ^ ^             _A_SCII:
"
    ("s" (hot-expand "<s"))
    ("E" (hot-expand "<e"))
    ("q" (hot-expand "<q"))
    ("v" (hot-expand "<v"))
    ("n" (hot-expand "<not"))
    ("c" (hot-expand "<c"))
    ("l" (hot-expand "<l"))
    ("h" (hot-expand "<h"))
    ("a" (hot-expand "<a"))
    ("L" (hot-expand "<L"))
    ("i" (hot-expand "<i"))
    ("e" (hot-expand "<s" "emacs-lisp"))
    ("p" (hot-expand "<s" "perl"))
    ("u" (hot-expand "<s" "plantuml :file CHANGE.png"))
    ("P" (hot-expand "<s" "perl" ":results output :exports both :shebang \"#!/usr/bin/env perl\"\n"))
    ("I" (hot-expand "<I"))
    ("H" (hot-expand "<H"))
    ("A" (hot-expand "<A"))
    ("<" self-insert-command "ins")
    ("o" nil "quit"))




;;MARKDOWN
(defhydra hydra-markdown (:color pink :hint nil)
  "
Formatting        C-c C-s    _s_: bold          _e_: italic     _b_: blockquote   _p_: pre-formatted    _u_: code
Headings          C-c C-t    _h_: automatic     _1_: h1         _2_: h2           _3_: h3               _4_: h4
Lists             C-c C-x    _m_: insert item
Demote/Promote    C-c C-x    _l_: promote       _r_: demote     _c_: move up      _t_: move down
Links, footnotes  C-c C-a    _L_: link          _U_: uri        _F_: footnote     _W_: wiki-link      _R_: reference
"
  ("s" markdown-insert-bold)
  ("e" markdown-insert-italic)
  ("b" markdown-insert-blockquote :color blue)
  ("p" markdown-insert-pre :color blue)
  ("u" markdown-insert-code)
  ("h" markdown-insert-header-dwim)
  ("1" markdown-insert-header-atx-1)
  ("2" markdown-insert-header-atx-2)
  ("3" markdown-insert-header-atx-3)
  ("4" markdown-insert-header-atx-4)
  ("5" markdown-insert-header-atx-5)
  ("6" markdown-insert-header-atx-6)
  ("m" markdown-insert-list-item)
  ("l" markdown-promote)
  ("r" markdown-demote)
  ("c" markdown-move-down)
  ("t" markdown-move-up)
  ("L" markdown-insert-link :color blue)
  ("U" markdown-insert-uri :color blue)
  ("F" markdown-insert-footnote :color blue)
  ("W" markdown-insert-wiki-link :color blue)
  ("R" markdown-insert-reference-link-dwim :color blue)
  ("z" undo-tree-undo)
  ("y" undo-tree-redo)
  ("g" keyboard-quit)
  ("q" nil :color blue))



(defhydra hydra-bongo (:color blue :hint nil)
  "
       ^_c_^             ^_,_^         _p_: pause/resume   _i_: insert
       ^^↑^^             ^^↑^^         _s_ :start/stop     _k_: kill
   _h_ ←   → _n_     _a_ ←   → _e_     _l_: library        _u_: youtube
       ^^↓^^             ^^↓^^         _r_: random
       ^_t_^             ^_o_^
"
  ("." bongo-playlist :color red)
  ("h" bongo-play-previous :color pink)
  ("c" my/bongo-play-first  :color pink)
  ("n" bongo-play-next :color pink)
  ("t" my/bongo-play-last :color pink)
  ("," bongo-seek-backward-60 :color pink)
  ("a" bongo-seek-backward-10 :color pink)
  ("e" bongo-seek-forward-60 :color pink)
  ("o" bongo-seek-forward-10 :color pink)
  ("p" bongo-pause/resume :color red)
  ("s" bongo-start/stop :color pink)
  ("l" bongo :color red)
  ("r" bongo-play-random :color red)
  ("i" bongo-insert-file :color red)
  ("k" my/bongo-kill-current :color pink)
  ("u" my/youtube-dl)
  ("g" my/kill-buffer :color red)
  ("q" nil :color blue))



(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))

(defhydra hydra-adjust (:color blue :hint nil)
  "
      ^Zoom^              ^Transparency^
  ╭────────────────────────────────────────────╯
      [_s_] increase
      [_n_] decrease
      [_l_] reset          [_r_] 100 [_c_] 30
"
  ("s" text-scale-increase)
  ("n" text-scale-decrease)
  ("l" text-scale-adjust)
  ("r" (transparency 100 ))
  ("c" (transparency 30 ))
  ("1" (transparency 10 ))
  ("2" (transparency 20 ))
  ("3" (transparency 30 ))
  ("4" (transparency 40 ))
  ("5" (transparency 50 ))
  ("6" (transparency 60 ))
  ("7" (transparency 70 ))
  ("8" (transparency 80 ))
  ("9" (transparency 90 ))
  ("q" nil :color blue))


(defhydra hydra-ediff (:color blue :hint nil)
  "
^Buffers           Files           VC                     Ediff regions
----------------------------------------------------------------------
_e_uffers           _o_iles (_=_)       _r_evisions              _l_inewise
_E_uffers (3-way)   _O_iles (3-way)                          _w_ordwise
                    _c_urrent file
"
  ("e" ediff-buffers)
  ("E" ediff-buffers3)
  ("=" ediff-files)
  ("o" ediff-files)
  ("O" ediff-files3)
  ("c" ediff-current-file)
  ("r" magit-ediff)
  ("l" ediff-regions-linewise)
  ("w" ediff-regions-wordwise))


(defhydra hydra-hs (:color pink :hint nil)
   "
Hide^^            ^Show^            ^Toggle^    ^Navigation^
----------------------------------------------------------------
_h_ hide all      _s_ show all      _t_oggle    _n_ext line
_d_ hide block    _a_ show block              _p_revious line
_l_ hide level

"
   ("s" hs-show-all)
   ("h" hs-hide-all)
   ("a" hs-show-block)
   ("d" hs-hide-block)
   ("t" hs-toggle-hiding)
   ("l" hs-hide-level)
   ("n" forward-line)
   ("p" (forward-line -1))
   ("q" nil)
)


(bind-key "C-x o" 'hydra-window/body)
(bind-key "C-x e" 'hydra-elscreen/body)
(bind-key "C-t" 'hydra-multiple-cursors/body)
(bind-key "C-n" 'hydra-navigate/body)
(bind-key* "C-." 'hydra-execute/body)
(bind-key "C-x ." 'hydra-ggtags/body)
(bind-key "C-x -" 'hydra-yasnippet/body)
(bind-key "C-x p" 'hydra-project/body)
(bind-key "C-x =" 'hydra-adjust/body)
(bind-key "C-x t" 'hydra-transpose/body)
(bind-key* "C-x r" 'hydra-rectangle/body)
(bind-key "C-x d" 'hydra-bookmark/body)
(bind-key "C-x k" 'hydra-macro/body)
(bind-key "C-x K" 'kmacro-end-macro)
(bind-key "C-x a" 'hydra-apropos/body)
(bind-key "C-x M" 'hydra-major/body)
(bind-key "C-x m" 'hydra-minor/body)
(bind-key "C-x h" 'hydra-helm/body)
(bind-key "C-x l" 'hydra-goto-line/body)
(bind-key "C-x n" 'hydra-persp/body)


(add-hook 'outline-mode-hook (lambda() (bind-key "C--" #'hydra-outline/body outline-mode-map)))
(add-hook 'markdown-mode-hook (lambda() (bind-key "C--" #'hydra-markdown/body markdown-mode-map)))
(add-hook 'pdf-view-mode-hook  (lambda() (bind-key "C--" #'hydra-pdftools/body pdf-view-mode-map)))

;; mac related
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)

(defadvice yes-or-no-p (around prevent-dialog activate)
  "Prevent yes-or-no-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))

(defadvice y-or-n-p (around prevent-dialog-yorn activate)
  "Prevent y-or-n-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))
