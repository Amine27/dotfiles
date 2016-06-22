(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ido-enable-flex-matching t)
 '(ido-show-dot-for-dired t)
 '(org-return-follows-link t)
 '(w3m-key-binding (quote info))
 '(wdired-allow-to-change-permissions t)
 '(recentf-auto-cleanup (quote never))
 '(w3m-key-binding (quote info)))
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
					;------------;
		;;; Cursor ;;;
					;------------;

					; highlight the current line
		(require 'highlight-current-line)
		(global-hl-line-mode t)
		(setq highlight-current-line-globally t)
		(setq highlight-current-line-high-faces nil)
		(setq highlight-current-line-whole-line nil)
		(setq hl-line-face (quote highlight))

					; don't blink the cursor
		(blink-cursor-mode nil)

					; make sure transient mark mode is enabled (it should be by default,
					; but just in case)
		(transient-mark-mode t)

					; turn on mouse wheel support for scrolling
		(require 'mwheel)
		(mouse-wheel-mode t)

					;-------------------------;
		;;; Syntax Highlighting ;;;
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
		;;; Color Theme ;;;
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
