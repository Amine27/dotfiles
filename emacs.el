;; * ENCODING
(prefer-coding-system		'utf-8)
(set-default-coding-systems	'utf-8)
(set-terminal-coding-system	'utf-8)
(set-keyboard-coding-system	'utf-8)
;; * Emacs Packages repositories
(setq package-archives
      (quote
       (("gnu" . "http://elpa.gnu.org/packages/")
	("marmalade" . "http://marmalade-repo.org/packages/")
	("melpa" . "http://melpa.milkbox.net/packages/"))))
;; * P@THS & REQUIRES
(require 'ffap)
(require 'cl)
(require 'calc)
(require 'saveplace)
(package-initialize)
(load-library	"server")
(load-library	"savehist")
(load-library	"iso-transl")

(fset 'yes-or-no-p 'y-or-n-p)
(put 'dired-find-alternate-file 'disabled nil)

;; ajoute la numérotation de lignes par défaut
;; dans tous les buffers visités
(global-linum-mode t)
(elpy-enable) ;http://elpy.readthedocs.org/en/latest/introduction.html

;; (global-highlight-changes-mode t) ;; http://www.emacswiki.org/emacs/tmux_for_collaborative_editing
(ffap-bindings)
(recentf-mode		1)
(delete-selection-mode	1)
(tool-bar-mode		0)
(menu-bar-mode		1)
(savehist-mode		1)
(ido-mode		t)
(global-auto-revert-mode t)
;;(desktop-save-mode      1)
(if (not (server-running-p))  (server-start))
;; * VARIABLES
(setq
 auto-revert-verbose			nil
 blink-cursor-mode			t
 calendar-date-display-form		'(dayname " " day " " monthname " " year)
 column-number-mode			t
 completion-auto-help			'lazy
 default-buffer-file-coding-system	'utf-8
 default-file-name-coding-system	'utf-8
 dired-dwim-target			t
 dired-recursive-copies			'always
 dired-recursive-deletes		'always
 display-time-format			"%a %d %b %H:%M"
 enable-recursive-minibuffers		t
 ffap-url-fetcher			'w3m-browse-url
 gc-cons-threshold			3500000
 global-auto-revert-non-file-buffers	t
 package-enable-at-startup		t
 password-cache-expiry			nil
 read-file-name-completion-ignore-case	t
 size-indication-mode			t
 time-stamp-active			t
 tramp-default-method			"ssh"
 view-read-only				t
 visible-bell				t
 custom-file				"~/.emacs-custom.el"
 )

(setq
 w3m-default-save-directory		"~/.w3m"
 w3m-session-file			"~/.emacs.d/w3m-session"
 w3m-session-save-always		t
 w3m-session-load-always		nil
 w3m-session-show-titles		t
 w3m-session-duplicate-tabs		'never
 )

(setq-default
	dired-omit-mode			t
	dired-omit-files		"^\\.?#\\|^\\.$\\|^\\.\\.$\\|^\\."
	frame-title-format		'(buffer-file-name "%b (%f)" "%b")
	indicate-empty-lines		t
	save-place			t
	)

(load custom-file)
(setq backup-by-copying       t
      backup-directory-alist  '(("." . "~/.saves"))
      delete-old-versions     t
      kept-new-versions       6
      kept-old-versions       2
      version-control         t)

(setq view-diary-entries-initially	t
      mark-diary-entries-in-calendar	t
      number-of-diary-entries		7
      )
;; * HOOKS
(add-hook 'before-save-hook			'delete-trailing-whitespace)
;; * FONCTIONS
;; ** dos2unix
;; C-x C-m f
(defun dos2unix ()
  "Not exactly but it's easier to remember"
  (interactive)
  (set-buffer-file-coding-system 'unix 't) )

;; ** find-file-as-root
(defun find-file-as-root ()
  "Open the current open file via tramp and the /su:: or /sudo:: protocol"
  (interactive)
  (let ((running-ubuntu
	 (and (executable-find "lsb_release")
	      (string= (car (split-string (shell-command-to-string "lsb_release -ds"))) "Ubuntu"))))
    (find-file (concat (if running-ubuntu "/sudo::" "/su::") (buffer-file-name)))))

;; ** w3m-open-this-buffer
(defun w3m-open-this-buffer ()
  "Show this buffer in w3m"
  (interactive)
  (w3m-find-file (buffer-file-name)))

;; ** google-search
(defun google-search ()
  "Do a Google search of the symbol at the point"
  (interactive)
  (with-current-buffer (buffer-name)
    (switch-to-buffer-other-window
     (w3m-browse-url (concat "http://www.google.fr/search?q="
			     (if (region-active-p)
	    (buffer-substring-no-properties (region-beginning) (region-end))
	  (word-at-point)
	  )
;; (thing-at-point 'symbol)
)))
    (xsteve-flip-windows)
    (deactivate-mark)))

;; ** synonymes-search
(defun synonymes-search ()
  "Do a synonymes search of the symbol at the point"
  (interactive)
  (with-current-buffer (buffer-name)
    (switch-to-buffer-other-window
     (w3m-browse-url (concat "http://www.linternaute.com/dictionnaire/fr/definition/"
			     (thing-at-point 'symbol) "/")))
    (xsteve-flip-windows)))

;; ** xsteve-flip-windows
(defun xsteve-flip-windows ()
  (interactive)
  (let ((cur-buffer (current-buffer))
	(top-buffer)
	(bottom-buffer))
    (pop-to-buffer (window-buffer (frame-first-window)))
    (setq top-buffer (current-buffer))
    (other-window 1)
    (setq bottom-buffer (current-buffer))
    (switch-to-buffer top-buffer)
    (other-window -1)
    (switch-to-buffer bottom-buffer)
    (pop-to-buffer cur-buffer)))

;; * KEYS
(global-set-key			(kbd "C-c <up>")	'maximize-window)
(global-set-key			(kbd "C-c <down>")	'minimize-window)
(global-set-key			(kbd "C-c <right>")	'balance-windows)
(global-set-key			(kbd "C-x C-b")		'ibuffer)
(global-set-key			(kbd "C-x C-f")		'find-file)
;;(global-set-key			(kbd "C-x f")		'find-file-as-root)
;;(global-set-key			(kbd "C-x C-f")		'set-fill-column)
;;(global-set-key			(kbd "C-x t")		'multi-term)
(global-set-key			(kbd "C-x l")		'copy-location-to-clip)
(global-set-key			(kbd "M-a")		'dabbrev-expand)
(global-set-key			(kbd "C-x r M-%")	'my-replace-string-rectangle)
(global-set-key			(kbd "C-x r C-M-%")	'my-replace-regexp-rectangle)

(global-set-key			[f7]			'recentf-open-files)
(global-set-key			"\M-[1;5C"		'forward-word)   ;  Ctrl+right->forward word
(global-set-key			"\M-[1;5D"		'backward-word)  ;  Ctrl+left-> backward word
(global-set-key			"\C-cu"			'browse-url)
(global-set-key			"\C-cg"			'browse-url-at-point)
(global-set-key			"\C-cl"			'goto-line)
(global-set-key			"\C-xœ"			'delete-window)
(global-set-key			"\C-x&"			'delete-other-windows)
(global-set-key			"\C-xé"			'split-window-below)
(global-set-key			"\C-x\""		'split-window-right)

(define-key global-map		"\C-z"			'undo)
(define-key global-map		"\C-v"			'scroll-other-window)
(define-key global-map		"\C-o"			'other-window)
(define-key global-map		"\C-cx"			'xsteve-flip-windows)
(define-key global-map		"\C-cw"			'google-search)
(define-key global-map		"\C-cs"			'synonymes-search)
(define-key global-map		"\C-cb"			'display-buffer)
(define-key global-map		"\C-cn"			'find-file-other-window)

;; (define-key dired-mode-map	(kbd "C-p")		'dired-omit-mode)
;; (define-key dired-mode-map	(kbd "C-o")		'other-window)
;; (define-key dired-mode-map	(kbd "<return>")	'dired-find-alternate-file) ; was dired-advertised-find-file
;; (define-key dired-mode-map	(kbd "^")		(lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory


;; (define-key help-mode-map	"j"		'next-line)
;; (define-key help-mode-map	"k"		'previous-line)
;; (define-key help-mode-map	"l"		'right-char)
;; (define-key help-mode-map	"h"		'left-char)

;; (define-key w3m-mode-map	"\C-dt"		'google-translate-at-point)
;; (define-key w3m-mode-map	"\C-ddt"	'google-translate-at-point-reverse)
;; (define-key w3m-mode-map	"\M-p"		'w3m-previous-buffer)
;; (define-key w3m-mode-map	"\M-n"		'w3m-next-buffer)
;; (define-key w3m-mode-map	"k"		'previous-line)
;; (define-key w3m-mode-map	"j"		'next-line)

(add-hook 'term-mode-hook
              '(lambda ()
                 (term-set-escape-char ?\C-x)))

;; * dired jump
(defun dired-jump-and-kill()
  (interactive)
  (setq tokill (current-buffer))
  (dired-jump)
  (kill-buffer tokill))
(global-set-key			(kbd "C-x C-j")	'dired-jump-and-kill)
;; * yank-to-x-clipboard
;; (defun yank-to-x-clipboard ()
;;   (interactive)
;;   (if (region-active-p)
;;         (progn
;; 	  (shell-command-on-region (region-beginning) (region-end) "xsel -i -b")
;; 	  (clipboard-kill-ring-save (region-beginning) (region-end))
;; 	  (message "Yanked region to clipboard!")
;; 	  (deactivate-mark))
;;     (message "No region active; can't yank to clipboard!")))

;(global-set-key "\M-w" 'yank-to-x-clipboard)


;; * fonts
(set-fontset-font
   "fontset-default"
   (cons (decode-char 'ucs #x0600) (decode-char 'ucs #x06ff)) ; arabic
   "DejaVu Sans Mono")
;; * Git
;; (add-to-list 'load-path "/usr/share/git-core/emacs/")
;; (require 'git)
;; * Odoo integration
;; (defun odoo()
;;   (interactive)
;;   (async-shell-command "python /home/ig-pro/odoo-dev/odoo8/odoo.py" "*Sortie Odoo*" "*Error Odoo*"))

;; (defun sheb()
;;   (interactive)
;;   (async-shell-command "bash" "*Sortie Odoo*" "*Error Odoo*"))

;; (defun odoo()
;;   (interactive)
;;   (start-process "Odoo"  "*Odoo Ouput*" "python" "/home/ig-pro/odoo-dev/odoo8/odoo.py"))

;; (defun codoo()
;;   (interactive)
;;   (async-shell-command "python /home/ig-pro/odoo-dev/odoo8/odoo.py --addons-path" "*Sortie Odoo*" "*Error Odoo*"))
;;  (shell-command "python /home/ig-pro/odoo-dev/odoo8/odoo.py" "*Sortie Odoo*" "*Error Odoo*"))
