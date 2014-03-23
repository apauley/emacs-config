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

(dolist (p packages)
  (when (not (package-installed-p p))
    (message "package not installed: %s" p)
    (package-install p)))
