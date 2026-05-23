;;; init.el --- Minimal bootstrap: load config.org via org-babel

(require 'package)
(setq package-archives
      '(("melpa"  . "https://melpa.org/packages/")
        ("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(setq package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Nix manages packages — never auto-install via use-package
(setq use-package-always-ensure nil)

(org-babel-load-file
 "~/.config/nix/modules/shared/config/emacs/config.org")
