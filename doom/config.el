;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Amine Roukh"
      user-mail-address "amineroukh@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
;;(setq doom-theme 'doom-vibrant)
(setq doom-theme 'doom-gruvbox)
;;(setq doom-theme 'doom-zenburn)
;;(setq doom-theme 'doom-spacegrey)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'nil)

;; highlight current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#3e4446")

;; comment/uncomment current line
(global-set-key (kbd "C-x :") 'comment-line)

;; when invoked do not ask confirmation from user
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; auto eliminate all trailing whitespace when saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; indent the current line when pressing TAB key
(setq tab-always-indent t)

;; Ivy-based interface to standard commands
(global-set-key (kbd "C-s") 'swiper-isearch)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "C-x b") 'counsel-switch-buffer)

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

;; use terminal background
(custom-set-faces!
  '(default :background nil))

;; chnage pug's indentation to 2 spaces
(setq pug-tab-width 2)

;; camelCase aware editing
(add-hook 'prog-mode-hook 'subword-mode)

;; enable word-wrap (almost) everywhere
(global-visual-line-mode t)

;; set `C-c d` to `M-x kill-whole-line`
(global-set-key (kbd "C-c d") 'kill-whole-line)

;; chnage json's indentation to 2 spaces
(setq json-reformat:indent-width 2)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
