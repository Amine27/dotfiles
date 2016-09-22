;; * ENCODING
(prefer-coding-system		'utf-8)
(set-default-coding-systems	'utf-8)
(set-terminal-coding-system	'utf-8)
(set-keyboard-coding-system	'utf-8)
;; * Emacs Packages repositories
(setq package-archives
      (quote
       (("gnu" . "http://elpa.gnu.org/packages/")
	;;("marmalade" . "http://marmalade-repo.org/packages/")
	("melpa" . "http://melpa.milkbox.net/packages/"))))

(setq package-list
      '(
	async
	auto-complete
	color-theme
	company
	concurrent
	ctable
	dash
	deferred
	docker
	docker-api
	dockerfile-mode
	docker-tramp
	elpy
	epc
	find-file-in-project
	git-commit
	highlight-current-line
	highlight-indentation
	ivy
	jedi
	jedi-core
	magit
	magit-popup
	popup
	python-environment
	python-mode
	pyvenv
	w3m
	with-editor
	yaml-mode
	yasnippet
	))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; (let ((refreshed nil))
;;   (when (not package-archive-contents)
;;     (package-refresh-contents)
;;     (setq refreshed t))
;;   (dolist (pkg req-packages)
;;     (when (and (not (package-installed-p pkg))
;; 	       (assoc pkg package-archive-contents))
;;       (unless refreshed
;; 	(package-refresh-contents)
;; 	(setq refreshed t))
;;       (package-install pkg))))


;; * P@THS & REQUIRES
(require 'ffap)
(require 'cl)
(require 'calc)
(require 'saveplace)

(load-library	"server")
(load-library	"savehist")
(load-library	"iso-transl")

(fset 'yes-or-no-p 'y-or-n-p)
(put 'dired-find-alternate-file 'disabled nil)

;; ajoute la numérotation de lignes par défaut
;; dans tous les buffers visités
;(global-linum-mode t)
(elpy-enable) ;http://elpy.readthedocs.org/en/latest/introduction.html
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
;; (global-highlight-changes-mode t) ;; http://www.emacswiki.org/emacs/tmux_for_collaborative_editing
(ffap-bindings)
(recentf-mode		1)
(delete-selection-mode	1)
;(tool-bar-mode		0)
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
      savedir		      "~/.saves"
      backup-directory-alist  '(("." . ,savedir))
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
(defun yank-to-x-clipboard ()
  (interactive)
  (if (region-active-p)
        (progn
	  (shell-command-on-region (region-beginning) (region-end) "xsel -i -b")
	  (clipboard-kill-ring-save (region-beginning) (region-end))
	  (message "Yanked region to clipboard!")
	  (deactivate-mark))
    (message "No region active; can't yank to clipboard!")))
(global-set-key "\M-w" 'yank-to-x-clipboard)
;; * fonts
;; (set-fontset-font
;;    "fontset-default"
;;    (cons (decode-char 'ucs #x0600) (decode-char 'ucs #x06ff)) ; arabic
;;    "DejaVu Sans Mono")
;; * Git
;; (add-to-list 'load-path "/usr/share/git-core/emacs/")
;; (require 'git)
;; * Odoo integration

;; (setq comint-output-filter-functions '(ansi-color-process-output
;; 					 comint-postoutput-scroll-to-bottom
;; 					 comint-truncate-buffer)
;; 	comint-buffer-maximum-size 500)

;; (defun odoo_start()
;;   (interactive)
;;   (let (
;; 	(odoo-outb "*Sortie Odoo*")
;; 	(odoo-errb "*Error Odoo*")
;; 	(odoo-comm "python ~/odoo-dev/odoo8/odoo.py")
;; 	(async-shell-command-buffer 'confirm-kill-process)
;; 	)
;;     (async-shell-command odoo-comm odoo-outb odoo-errb)))

;; (defun odoo_update()
;;   (interactive)
;;   (let (
;; 	(odoo-outb "*Sortie Odoo*")
;; 	(odoo-errb "*Error Odoo*")
;; 	(odoo-comm "python ~/odoo-dev/odoo8/odoo.py --addons-path='~/odoo-dev/odoo8/addons,~/odoo-dev/custumdir' -d test")
;; 	(async-shell-command-buffer 'confirm-kill-process)
;; 	)
;;     (async-shell-command odoo-comm odoo-outb odoo-errb)))

;; (defun odoo_stop()
;;   (interactive)
;;   (interrupt-process "*Sortie Odoo*")
;;   )

;; (global-set-key			[f5]			'odoo_start)
;; (global-set-key			[f6]			'odoo_update)
;; (global-set-key			[f7]			'odoo_stop)
(put 'downcase-region 'disabled nil)
;; * org-capture
(require 'org-protocol)
(setq org-capture-templates
      '(
	("w" "" entry ;; 'w' for 'org-protocol'
	 (file+headline "www.org" "Notes")
	 "* %:description\nSource: %u, %c\n%i"
	 :immediate-finish t)
	("x" "" entry ;; 'w' for 'org-protocol'
	 (file+headline "clisp.org" "Notes")
	 "* %^{Title}\nSource: %u, %l\n%i"
	 )
	;;       "* %c%?\nSource: %u, %l\n%i")
	;; other templates
	        ))
;; * sid-theme
(defun sid-theme()
  (interactive)
					;------------;
					;   Cursor   ;
					;------------;
					; highlight the current line
(require 'highlight-current-line)
(global-hl-line-mode			t)
(setq highlight-current-line-globally	t
      highlight-current-line-high-faces nil
      highlight-current-line-whole-line nil
      hl-line-face			(quote highlight))

					; don't blink the cursor
(blink-cursor-mode			nil)
					; make sure transient mark mode is enabled (it should be by default,
					; but just in case)
(transient-mark-mode			t)
					; turn on mouse wheel support for scrolling
(require 'mwheel)
(mouse-wheel-mode			t)
					;-------------------------;
					;   Syntax Highlighting   ;
					;-------------------------;
					; text decoration
(require 'font-lock)
(setq font-lock-maximum-decoration t)
(global-font-lock-mode t)
(global-hi-lock-mode nil)
(setq jit-lock-contextually t)
(setq jit-lock-stealth-verbose t)

					; if there is size information associated with text, change the text
					; size to reflect it
(size-indication-mode t)

					; highlight parentheses when the cursor is next to them
(require 'paren)
(show-paren-mode t)

					;-----------------;
					;   Color Theme   ;
					;-----------------;

					; use the "Subtle Hacker" color theme as a base for the custom scheme
(require 'color-theme)
(color-theme-initialize)
(setq color-theme-is-global t)
(color-theme-subtle-hacker)
					; make sure the frames have the dark background mode by default
(setq default-frame-alist (quote (
				  (frame-background-mode . dark)
				  )))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:overline nil :inherit nil :stipple nil :background "gray2" :foreground "#FFF991" :inverse-video nil :box nil :strike-through nil :underline nil :slant normal :weight normal :height 83 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(border ((t nil)))
 '(cursor ((t (:background "firebrick1" :foreground "black"))))
 '(flymake-errline ((t (:inherit error :foreground "brightred"))))
 '(font-lock-comment-delimiter-face ((default (:inherit font-lock-comment-face :weight ultra-bold)) (((class color) (min-colors 16)) nil)))
 '(font-lock-comment-face ((t (:foreground "lime green"))))
 '(font-lock-doc-face ((t (:foreground "tomato" :slant italic))))
 '(font-lock-function-name-face ((t (:foreground "deep sky blue" :underline t :weight bold))))
 '(font-lock-keyword-face ((t (:foreground "gold" :weight bold))))
 '(font-lock-string-face ((t (:foreground "tomato" :slant italic))))
 '(fringe ((nil (:background "black"))))
 '(highlight ((t (:background "khaki1" :foreground "black" :box (:line-width -1 :color "firebrick1")))))
 '(highlight-current-line-face ((t (:inherit highlight))))
 '(lazy-highlight ((t (:background "paleturquoise" :foreground "black"))))
 '(link ((t (:foreground "DodgerBlue3" :underline t))))
 '(menu ((t (:background "gray2" :foreground "#FFF991"))))
 '(minibuffer-prompt ((t (:foreground "royal blue"))))
 '(mode-line ((t (:background "dark olive green" :foreground "dark blue" :box (:line-width -1 :color "gray75") :weight bold))))
 '(mode-line-buffer-id ((t (:background "dark olive green" :foreground "beige"))))
 '(mode-line-highlight ((((class color) (min-colors 88)) nil)))
 '(mode-line-inactive ((t (:background "dark olive green" :foreground "dark khaki" :weight light))))
 '(mouse ((t (:background "Grey" :foreground "black"))))
 '(trailing-whitespace ((((class color) (background dark)) (:background "firebrick1")))))
)
