;; NO FRILLS
(dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
  (when (fboundp mode) (funcall mode -1)))
(setq inhibit-startup-screen t)
;; NO JUNK
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
      backup-directory-alist `((".*" . ,temporary-file-directory)))

;; EL-GET
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-haskell/recipes")
(el-get 'sync)

;; Other
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar common-packages '(better-defaults)
  "A list of common packages to ensure are installed at launch.")

(defvar ui-packages '(color-theme color-theme-solarized color-theme-monokai color-theme-molokai)
  "A list of UI packages to ensure are installed at launch.")

(defvar packages (append common-packages ui-packages)
  "Combined list of packes to be installed")

;; (dolist (p packages)
;;   (when (not (package-installed-p p))
;;     (message "package not installed: %s" p)
;;     (package-install p)))
