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
	company
        company-jedi
        company-php
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
	highlight-indentation
        counsel
        prescient
        ivy-prescient
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
        htmlize
        org-preview-html
        php-mode
        web-mode
        json-mode
        yaml-mode
        lsp-mode
        lsp-ui
        lsp-ivy
        projectile
        which-key
        smart-mode-line
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
(require 'flycheck)
(require 'lsp-mode)

(load-library	"server")
(load-library	"savehist")
(load-library	"iso-transl")

(fset 'yes-or-no-p 'y-or-n-p)
(put 'dired-find-alternate-file 'disabled nil)

(elpy-enable) ;http://elpy.readthedocs.org/en/latest/introduction.html
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

(ffap-bindings)
(recentf-mode		1)
(delete-selection-mode	1)
;(tool-bar-mode		0)
(menu-bar-mode		0)
(savehist-mode		1)
(global-auto-revert-mode t)
;; (desktop-save-mode      1)
(ivy-mode               1)
(ivy-prescient-mode     t)
(projectile-mode       +1)

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

;; comment/uncomment current line
(global-set-key (kbd "C-x :") 'comment-line)

(add-hook 'term-mode-hook
              '(lambda ()
                 (term-set-escape-char ?\C-x)))

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

;; Ivy-based interface to standard commands
(global-set-key (kbd "C-s") 'swiper-isearch)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "<f2> j") 'counsel-set-variable)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c V") 'ivy-pop-view)

;; Projectile keymap prefixes
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Moe-theme color schems
(require 'moe-theme)
(setq moe-theme-mode-line-color 'nil)
(moe-dark)

;; set transparency background for emacsclient
(defun on-frame-open (frame)
  (if (not (display-graphic-p frame))
      (set-face-background 'default "unspecified-bg" frame)))
(on-frame-open (selected-frame))
(add-hook 'after-make-frame-functions 'on-frame-open)
;; set transparency background for emacs
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))
(add-hook 'window-setup-hook 'on-after-init)

;; highlight current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#3e4446")

(setq auto-mode-alist (append '(("\\.scss$" . sass-mode))
			            auto-mode-alist))
;; * disable tabs for indentations
(setq-default indent-tabs-mode nil)

;; use company-mode in all buffers
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'js2-mode-hook (lambda ()
                           (company-mode)))

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
;; web-mode
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;; use web-mode for .jsx files
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
;; enable lsp for all programming lang
(add-hook 'prog-mode-hook #'lsp)
;; allows to see matching pairs of parentheses
(show-paren-mode 1)
(setq show-paren-style 'expression)
;; insert matching delimiters for programming lang
(add-hook 'prog-mode-hook 'electric-pair-mode)
;; insert newlines for programming lang
(add-hook 'prog-mode-hook 'electric-layout-mode)
;; ivy mode customization
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")
;; enable which key
(which-key-mode)
;; lsp-mode integration
(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))
;; activate smart-mode-line
(setq sml/theme 'dark)
(sml/setup)
