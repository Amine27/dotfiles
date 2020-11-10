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
	("melpa" . "https://melpa.org/packages/"))))

(setq package-list
      '(
	async
	;;auto-complete
	;;color-theme
	company
        company-tern
        company-jedi
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
	;;highlight-current-line
	highlight-indentation
	ivy
	;;jedi
	;;jedi-core
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
	neotree
	moe-theme
	django-mode
	sass-mode
        pug-mode
        flycheck
        js2-mode
        doom-modeline
        htmlize
        org-preview-html
	))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

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

(elpy-enable) ;http://elpy.readthedocs.org/en/latest/introduction.html
;;(add-hook 'python-mode-hook 'jedi:setup)
;;(setq jedi:complete-on-dot t)
(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))
(add-hook 'python-mode-hook 'my/python-mode-hook)
;; add mypy to flycheck, at the same time as pylint
(flycheck-define-checker
    python-mypy ""
    :command ("mypy"
              "--ignore-missing-imports"
              "--python-version" "3.6"
              "--cache-dir" "/tmp/.mypy_cache"
              source-original)
    :error-patterns
    ((error line-start (file-name) ":" line ": error:" (message) line-end))
    :modes python-mode)

(add-to-list 'flycheck-checkers 'python-mypy t)
(flycheck-add-next-checker 'python-pylint 'python-mypy t)

;; (global-highlight-changes-mode t) ;; http://www.emacswiki.org/emacs/tmux_for_collaborative_editing
(ffap-bindings)
(recentf-mode		1)
(delete-selection-mode	1)
;(tool-bar-mode		0)
(menu-bar-mode		0)
(savehist-mode		1)
(ido-mode		t)
(global-auto-revert-mode t)
;; (desktop-save-mode      1)
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
;; (global-set-key			(kbd "C-c <up>")	'maximize-window)
;; (global-set-key			(kbd "C-c <down>")	'minimize-window)
;; (global-set-key			(kbd "C-c <right>")	'balance-windows)
;; (global-set-key			(kbd "C-x C-b")		'ibuffer)
;; (global-set-key			(kbd "C-x C-f")		'find-file)
;;(global-set-key			(kbd "C-x f")		'find-file-as-root)
;;(global-set-key			(kbd "C-x C-f")		'set-fill-column)
;;(global-set-key			(kbd "C-x t")		'multi-term)
;;(global-set-key			(kbd "C-x l")		'copy-location-to-clip)
;; (global-set-key			(kbd "M-a")		'dabbrev-expand)
;; (global-set-key			(kbd "C-x r M-%")	'my-replace-string-rectangle)
;; (global-set-key			(kbd "C-x r C-M-%")	'my-replace-regexp-rectangle)

;; (global-set-key			[f7]			'recentf-open-files)
;; (global-set-key			"\M-[1;5C"		'forward-word)   ;  Ctrl+right->forward word
;; (global-set-key			"\M-[1;5D"		'backward-word)  ;  Ctrl+left-> backward word
;; (global-set-key			"\C-cu"			'browse-url)
;; (global-set-key			"\C-cg"			'browse-url-at-point)
;; (global-set-key			"\C-cl"			'goto-line)
;; (global-set-key			"\C-xœ"			'delete-window)
;; (global-set-key			"\C-x&"			'delete-other-windows)
;; (global-set-key			"\C-xé"			'split-window-below)
;; (global-set-key			"\C-x\""		'split-window-right)

;; (define-key global-map		"\C-z"			'undo)
;; (define-key global-map		"\C-v"			'scroll-other-window)
;; (define-key global-map		"\C-o"			'other-window)
;; (define-key global-map		"\C-cx"			'xsteve-flip-windows)
;; (define-key global-map		"\C-cw"			'google-search)
;; (define-key global-map		"\C-cs"			'synonymes-search)
;; (define-key global-map		"\C-cb"			'display-buffer)
;; (define-key global-map		"\C-cn"			'find-file-other-window)

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

;; when invoked do not ask confirmation from user
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
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

;; * Load a user file if any
;, Will search for a file in home called $USER.el and loads it
(let (
      (custom-user-file (concat "~/." (user-login-name) ".el"))
      )
  (if (file-exists-p custom-user-file)
      (load custom-user-file)))


;; * disable electric-indent in rst-mode
;; http://emacs.stackexchange.com/a/14053/13367
(defun my-rst-mode-hook ()
  (electric-indent-local-mode -1))
(add-hook 'rst-mode-hook #'my-rst-mode-hook)

;; Moe-theme color schems
(require 'moe-theme)
(moe-dark)

;; set transparency background
(defun on-frame-open (frame)
  (if (not (display-graphic-p frame))
      (set-face-background 'default "unspecified-bg" frame)))
(on-frame-open (selected-frame))
(add-hook 'after-make-frame-functions 'on-frame-open)

;; highlight current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#3e4446")

(setq auto-mode-alist (append '(("\\.scss$" . sass-mode))
			            auto-mode-alist))
;; * disable tabs for indentations
(setq-default indent-tabs-mode nil)

;; use company-mode in all buffers
(add-hook 'after-init-hook 'global-company-mode)
(add-to-list 'company-backends 'company-tern)
(add-hook 'js2-mode-hook (lambda ()
                           (tern-mode)
                           (company-mode)))
;; the server won’t write a .tern-port file
;(setq tern-command (append tern-command '("--no-port-file")))

(setq company-idle-delay 0)
(setq company-minimum-prefix-length 2)

;; prevent company from downcase completion
(setq company-dabbrev-downcase nil)

;; chnage pug's indentation to 2 spaces
(setq pug-tab-width 2)

(global-set-key [remap newline] #'newline-and-indent)

;; associate files with js2 mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; better imenu
(add-hook 'js2-mode-hook #'js2-imenu-extras-mode)

;; identation with 2 spaces
(setq js-indent-level 2)
(setq-default js2-basic-offset 2)

;; Turn off js2 mode errors & warnings (we lean on eslint/standard)
(setq js2-mode-show-parse-errors nil)
(setq js2-mode-show-strict-warnings nil)

(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/.bin/eslint"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
;; use web-mode for .jsx files
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
;;(require 'flycheck)
;; enable flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers '(javascript-jshint))
;; use eslint with web-mode for jsx files
;;(flycheck-add-mode 'javascript-eslint 'web-mode)
;; customize flycheck temp file prefix
;;(setq-default flycheck-temp-prefix ".flycheck")
;; Use local eslint
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)
;; CamelCase aware editing
(add-hook 'prog-mode-hook 'subword-mode)
;; doom-modeline
(require 'doom-modeline)
(doom-modeline-mode 1)
