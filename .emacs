;; generic section works on emacs >= 23.1 because RHEL and CentOS 6 are still around
;;
;; RHEL or CentOS 6: 23.1
;; RHEL or CentOS 7: 24.3
;;
;; Debian 6 (squeeze): 23.2
;; Debian 7 (wheezy):  23.4
;; Debian 8 (jessie):  24.4
;; Debian 9 (stretch): 25.1
;;
;; Ubuntu 12.04 LTS (precise): 23.3
;; Ubuntu 14.04 LTS (trusty):  24.3
;; Ubuntu 16.04 LTS (xenial):  24.5
;; Ubuntu 18.04 LTS (bionic):  25.2


;; generic section is for any random computer I happen to need to edit stuff,
;; can copy paste in to .emacs as needed
;;
;; custom section is for daily use laptop or any computer I spend a lot of time
;; editing stuff on





;;  ---------------------------------------------------------------------------
;; | GENERIC STUFF                                                             |
;;  ---------------------------------------------------------------------------

;; show line number and column number in the mode line
(line-number-mode t)
(column-number-mode t)

;; font-lock for all buffers
(global-font-lock-mode 1)

;; highlight regions (when yanking)
(transient-mark-mode 1)

;; give me a preview in the mini buffer
(icomplete-mode 1)

;; select a region and just start typing to delete it
(delete-selection-mode 1)

;; highlight matching parentheses
(show-paren-mode t)
(setq show-paren-delay 0)

;; disable menu bar, AKA "drop down menu" AKA "File->Open menu like stuff" which
;; is useless if its not running in a GUI
(unless (display-graphic-p)
  (menu-bar-mode -1))

;; toolbar is useless 100% of the time including in a GUI but the symbol is only
;; defined when using a graphical display
;;
;; https://serverfault.com/questions/132055/how-to-check-if-emacs-is-in-gui-mode-and-execute-tool-bar-mode-only-then
;; https://superuser.com/questions/313398/how-to-prevent-the-symbols-function-definition-is-void-error-when-running-em
(if (display-graphic-p)
    (tool-bar-mode -1))

;; don't start in the "help" screen when you start emacs with no file. start in
;; *scratch* instead
(setq inhibit-startup-message t)

;; don't display anything in scratch buffer
(setq initial-scratch-message nil)

;; always end a file with a new line
(setq require-final-newline t)

;; stop adding newlines at the end of a file if one is already there
(setq next-line-add-newlines nil)

;; stop making tilde backup files
(setq make-backup-files nil)

;; fill at 80 columns
(setq-default fill-column 80)

;; mostly for rpm-spec mode
(setq user-mail-address "mmckinst@example.com")
(setq user-full-name "Mark McKinstry")

;; if whitespace mode is enabled highlight lines over the fill-column (80) characters
(setq whitespace-style '(face lines-tail trailing))

;; if whitespace mode is enabled highlight trailing whitespace
(setq show-trailing-whitespace t)

;; y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;; keybindings
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "M-z") 'zap-up-to-char)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-c d") 'mmckinst-insert-iso-8601-date)
(global-set-key (kbd "C-x 4 t") 'transpose-windows)

;; markdown-mode usually comes from emacs-goodies package
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mkd\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; bash automated testing system
(add-to-list 'auto-mode-alist '("\\.bats\\'" . sh-mode))

;; allow stuff like """-*- encoding: utf-8 -*-""" to work without prompting me
;; if its a safe variable
(add-to-list 'safe-local-variable-values '(encoding . utf-8))

;; rebind C-x C-b to use ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; two spaces for tabs
(setq indent-tabs-mode nil)
(setq tab-width 2)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)
(defvaralias 'js-indent-level 'tab-width)

;; spell checking for comments in programming modes
;; prog-mode added in 24.1
;;
;; http://emacsredux.com/blog/2013/04/05/prog-mode-the-parent-of-all-programming-modes/
;; https://stackoverflow.com/questions/15891808/emacs-how-to-enable-automatic-spell-check-by-default
(when (>= emacs-major-version 24)
  (add-hook 'prog-mode-hook 'flyspell-prog-mode))
(add-hook 'text-mode-hook 'flyspell-mode)
;; (add-hook 'text-mode-hook 'turn-on-auto-fill)

;; eletric-indent-mode added and enabled by default in 24.4
(when (>= (string-to-number (substring emacs-version 0 -2)) 24.4)
  (electric-indent-mode -1))

;; give duplicate buffers better names instead of somefile<1> and somefile<2>
;; they get somefile<foo> and somefile<bar> when they are in the 'foo' and 'bar'
;; dirs
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-after-kill-buffer-p t)

;; (require 'recentf)
;; (recentf-mode t)

;; simple highlighting for files where no mode is defined
(require 'generic-x)

;; makes opening files (C-x f) and switching buffers (C-x b) easier
;;
;; C-s and C-r to cycle through possible options
;; C-SPC or C-@ to restrict the completion list
;; C-j to create a new file or buffer without ido prompting you
(ido-mode t)
(setq ido-enable-flex-matching t)
(add-to-list 'ido-ignore-buffers "*Messages*")
(add-to-list 'ido-ignore-buffers "*Buffer*")
(add-to-list 'ido-ignore-buffers "*Help*")
(add-to-list 'ido-ignore-buffers "*Completions*")

;; line numbers in the left margin
;; added in 23.1
;; (when (>= emacs-major-version 23)
;;   (global-linum-mode 1)
;;   (setq linum-format "%4d \u2502 "))


;; make inserting an ISO 8601 timestamp easier
;; use C-u as the prefix to put my name after the timestamp
(defun mmckinst-insert-iso-8601-date(arg)
  "Insert ISO 8601 YYYY-MM-DD date"
  (interactive "P")
  (insert (format-time-string "%Y-%m-%d"))
  (if (equal arg '(4))
      (insert " mmckinst")))

;; https://stackoverflow.com/questions/1510091/with-emacs-how-do-you-swap-the-position-of-2-windows
(defun transpose-windows ()
  (interactive)
  (let ((this-buffer (window-buffer (selected-window)))
	(other-buffer (prog2
			  (other-window +1)
			  (window-buffer (selected-window))
			(other-window -1))))
    (switch-to-buffer other-buffer)
    (switch-to-buffer-other-window this-buffer)
    (other-window -1)))


;; make M-z do what I want
(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR.")


;;  ---------------------------------------------------------------------------
;; | CUSTOM STUFF                                                              |
;;  ---------------------------------------------------------------------------

;; package.el added in emacs 24
(when (>= emacs-major-version 24)
  (require 'package)
  (setq package-enable-at-startup nil)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
  (package-initialize)
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))

  (require 'use-package)
  (setq use-package-always-ensure t)
  (use-package magit
    :bind ("C-x g" . magit-status))
  (use-package yaml-mode
    :mode "\\.yaml\\'"
    :mode "\\.yml\\'"
    :mode "\\.sls\\'")
  (use-package go-mode
    :mode "\\.go\\'")
  (use-package adoc-mode
    :mode "\\.adoc\\'")
  (use-package php-mode
    :mode "\\.php\\'")
  (use-package rpm-spec-mode
    :mode "\\.spec\\'")
  (use-package jinja2-mode
    :mode "\\.jinja2\\'"
    :mode "\\.j2\\'")
  (use-package dockerfile-mode
    :mode "Dockerfile\\'")
  (use-package markdown-mode
    :mode "\\.md\\'"
    :mode "\\.markdown\\'")
  (use-package multiple-cursors
    :bind(("C->" . mc/mark-next-like-this)
	  ("C-<" . mc/mark-previous-like-this)
	  ("C-c C-<" . mc/mark-all-like-this)))
  (use-package discover-my-major
    :bind ("C-h C-m" . discover-my-major))
  (use-package smex
    :bind (("M-x" . smex)
	   ("M-X" . smex-major-mode-commands)))
  (use-package avy
    :disabled t)
  (use-package ido-ubiquitous
    :config (ido-ubiquitous-mode 1))
  (use-package flx-ido
    :init (setq ido-use-faces nil)
    :config (flx-ido-mode 1))
  (use-package base16-theme
    :init (load-theme 'base16-setiui-dark t))
  (use-package fill-column-indicator
    :init (require 'fill-column-indicator))
  (use-package flycheck
    ;; can use flymake that comes with emacs >= 22.1
    :disabled t)
  (use-package helm
    ;; helm might be interesting some day but is overly complex right now
    :disabled t
    :init (require 'helm-config)
    :bind (("C-h a" . helm-apropos)
	   ("C-x C-b" . helm-buffers-list)
	   ("C-x b" . helm-buffers-list)
	   ("M-y" . helm-show-kill-ring)
	   ("M-x" . helm-M-x))))


;; org mode added in emacs 22
(when (>= emacs-major-version 22)
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c c") 'org-capture)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c b") 'org-iswitchb)

  ;; log when something is marked as done.
  ;;
  ;; default is to log the date as YYYY-MM-DD but put the HH:MM there too
  (setq org-log-done 'time)
  (setq org-log-done-with-time t)
  (setq org-log-into-drawer t)

  ;; orgmode.org/manual/Clean-view.html
  (setq org-startup-indented t)

  ;; protect myself from myself
  (setq org-ctrl-k-protect-subtree t)
  (setq org-catch-invisible-edits 'show))
