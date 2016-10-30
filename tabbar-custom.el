(tabbar-mode)
(require 'tabbar-ruler)
(set-face-attribute  'tabbar-default nil
		     :background "#202020"
		     :box '(:color "black"))
(set-face-attribute  'tabbar-unselected nil
		     :background "gray30"
		     :foreground "white"
		     :box '(:color "gray30"))
(set-face-attribute  'tabbar-selected nil
		     :background "gray75"
		     :foreground "black"
		     :box '(:color "gray75"))
(set-face-attribute  'tabbar-highlight nil
		     :background "white"
		     :foreground "black"
		     :underline nil
		     :box '(:color "white"))
(set-face-attribute  'tabbar-separator nil
		     :height 1.0)


(global-set-key (kbd "C-c <left>")      'tabbar-backward)
(global-set-key (kbd "C-c <right>")     'tabbar-forward)
(global-set-key "\M-n"                  'tabbar-forward)
(global-set-key "\M-p"                  'tabbar-backward)

(defun mygroups()
  (list (cond ((eq major-mode 'dired-mode) "Dirs")
	      (t "All"))))

(setq	tabbar-buffer-groups-function		'mygroups
	tabbar-buffer-list-function		(lambda ()
						  (remove-if
						   (lambda(buffer)
						     (find (aref (buffer-name buffer) 0) " *"))
						   (buffer-list))
						  )
	)
