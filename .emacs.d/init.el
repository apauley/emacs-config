;; NO FRILLS
(dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
  (when (fboundp mode) (funcall mode -1)))
(setq inhibit-startup-screen t)
;; NO JUNK
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
      backup-directory-alist `((".*" . ,temporary-file-directory)))
;; EL-GET
(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
(defun el-get-sync-recipes (overlay)
  (let* ((recipe-glob (locate-user-emacs-file (concat overlay "/recipes/*.rcp")))
         (recipe-files (file-expand-wildcards recipe-glob))
         (recipes (mapcar 'el-get-read-recipe-file recipe-files)))
    (mapcar (lambda (r) (add-to-list 'el-get-sources r)) recipes)
    (el-get 'sync (mapcar 'el-get-source-name recipes))))
(setq el-get-user-package-directory user-emacs-directory)
;; EL-GET SYNC OVERLAYS
(el-get-sync-recipes "el-get-haskell")
(el-get-sync-recipes "el-get-user")

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

(defvar base-packages
      '(auto-complete cl-lib el-get fuzzy popup)
      "Basic emacs packages")

(defvar common-packages '(package)
  "A list of common packages to ensure are installed at launch.")

(defvar ui-packages '(color-theme color-theme-solarized)
  "A list of UI packages to ensure are installed at launch.")

(defvar git-packages '(git-modes magit)
  "Packages related to git.")

(defvar haskell-packages '(haskell-mode structured-haskell-mode)
  "Packages related to haskell.")

(defvar my-packages (append base-packages common-packages ui-packages git-packages haskell-packages)
  "Combined list of packes to be installed")

(setq my-packages (append base-packages common-packages ui-packages git-packages haskell-packages))

(el-get 'sync my-packages)

(package-initialize)
(defvar pkg-packages '(better-defaults)
  "A list of packages that are installed outside of el-get with package.")

(dolist (p pkg-packages)
  (when (not (package-installed-p p))
    (message "package not installed: %s" p)
    (package-install p)))

;; CUSTOM FILE
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror)
