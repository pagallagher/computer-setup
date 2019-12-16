;; .emacs.d/init.el
;; sourced from https://realpython.com/emacs-the-best-python-editor/

;; ===================================
;; MELPA Package Support
;; ===================================
;; Enables basic packaging support
(require 'package)

;; Adds the Melpa archive to the list of available repositories
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; Initializes the package infrastructure
(package-initialize)

;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

;; Installs packages
;;
;; myPackages contains a list of package names
(defvar myPackages
  '(better-defaults                 ;; Set up some better Emacs defaults
    noctilux-theme                  ;; Theme
    elpy
    flymake
    py-autopep8
    )
  )

;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)


;; ===================================
;; Basic Customization
;; ===================================

(setq inhibit-startup-message t)    ;; Hide the startup message
(load-theme 'noctilux t)            ;; Load material theme
(global-linum-mode t)               ;; Enable line numbers globally

;; ====================================
;; Development Setup
;; ====================================
;; Enable elpy
(elpy-enable)

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "console -i --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)

;; Enable Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Enable autopep8
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; User-Defined init.el ends here

