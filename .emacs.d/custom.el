(column-number-mode 1)
(global-linum-mode 1)

;; Recent Files
(setq recentf-auto-cleanup 'never) ;; disable before we start recentf!
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ f" 'recentf-open-files)

(global-set-key "\C-x\ g" 'magit-status)

(global-set-key (kbd "C-<right>") 'windmove-right)
(global-set-key (kbd "C-<left>") 'windmove-left)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq whitespace-style
      '(trailing lines space-before-tab indentation space-after-tab)
      whitespace-line-column 200)
(global-whitespace-mode)
