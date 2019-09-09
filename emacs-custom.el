(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(dired-auto-revert-buffer (quote dired-directory-changed-p))
 '(dired-listing-switches "-alh --group-directories-first ")
 '(global-company-mode t)
 '(highlight-nonselected-windows t)
 '(ido-auto-merge-work-directories-length -1)
 '(ido-enable-flex-matching t)
 '(ido-show-dot-for-dired t)
 '(neo-smart-open t)
 '(org-babel-load-languages
   (quote
    ((emacs-lisp . t)
     (shell . t)
     (awk . t)
     (python . t)
     (ditaa . t)
     (dot . t)
     (plantuml . t)
     (awk . t))))
 '(org-link-file-path-type (quote relative))
 '(org-link-frame-setup
   (quote
    ((vm . vm-visit-folder-other-frame)
     (vm-imap . vm-visit-imap-folder-other-frame)
     (gnus . org-gnus-no-new-news)
     (file . find-file-other-frame)
     (wl . wl-other-frame))))
 '(org-return-follows-link t)
 '(org-src-fontify-natively nil)
 '(org-src-window-setup (quote current-window))
 '(package-selected-packages
   (quote
    (company-tern company-ansible company-web pug-mode sass-mode django-mode moe-theme neotree yaml-mode w3m python-mode magit jedi git-commit epc elpy dockerfile-mode docker-api docker dash ctable concurrent company color-theme auto-complete async)))
 '(read-mail-command (quote gnus))
 '(recentf-auto-cleanup (quote never))
 '(safe-local-variable-values (quote ((org-export-babel-evaluate . t))))
 '(sentence-end-double-space nil)
 '(server-kill-new-buffers nil)
 '(server-temp-file-regexp "^/tmp/Re\\|COMMIT_EDITMSG\\|/draft$")
 '(vc-follow-symlinks t)
 '(w3m-key-binding (quote info))
 '(wdired-allow-to-change-permissions t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "brightyellow"))))
 '(org-block ((t (:inherit shadow))))
 '(org-block-background ((t (:background "color-255"))))
 '(org-block-begin-line ((t (:inherit org-meta-line))))
 '(org-block-end-line ((t (:inherit org-meta-line)))))
