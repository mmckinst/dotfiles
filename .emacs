;; generic section works on emacs >= 21.3 since I still have to touch CentOS 4
;; servers which have 21.3.
;;
;; CentOS 4: 21.3
;; CentOS 5: 21.4
;; CentOS 6: 23.1
;; CentOS 7: 24.3
;;
;; Debian 6 (squeeze): 23.2
;; Debian 7 (wheezy): 23.4
;; Debian 8 (jessie): 24.4
;;
;; Ubuntu 12.04 LTS (precise): 23.3
;; Ubuntu 14.04 LTS (trusty): 24.3



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
(setq initial-scratch-message "")

;; always end a file with a new line
(setq require-final-newline t)

;; stop adding newlines at the end of a file if one is already there
(setq next-line-add-newlines nil)

;; stop making tilde backup files
(setq make-backup-files nil)

;; fill at 80 columns
(setq fill-column 80)

;; show trailing whitespace
(setq show-trailing-whitespace t)

;; mostly for rpm-spec mode
(setq user-mail-address "mmckinst@example.com")
(setq user-full-name "Mark McKinstry")

;; y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;; keybindings
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-x g") 'magit-status)

;; markdown-mode usually comes from emacs-goodies package
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; rebind C-x C-b to use ibuffer
;; ibuffer added in 22.1
(when (>= emacs-major-version 22)
  (defalias 'list-buffers 'ibuffer-other-window))


;; spell checking for comments in programming modes
;; prog-mode added in 24.1
;;
;; http://emacsredux.com/blog/2013/04/05/prog-mode-the-parent-of-all-programming-modes/
;; https://stackoverflow.com/questions/15891808/emacs-how-to-enable-automatic-spell-check-by-default
(when (>= emacs-major-version 24)
  (add-hook 'prog-mode-hook 'flyspell-prog-mode))
(add-hook 'text-mode-hook 'flyspell-mode)
;; (add-hook 'text-mode-hook 'turn-on-auto-fill)

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

;; ido mode added in 22.1
;;
;; makes opening files (C-x f) and switching buffers (C-x b) easier
;;
;; C-s and C-r to cycle through possible options
;; C-j to create a new file or buffer. if using return ido will prompt you
(if (>= emacs-major-version 22)
    (progn
      (ido-mode t)
      (setq ido-enable-flex-matching t)
      (add-to-list 'ido-ignore-buffers "*Messages*")
      (add-to-list 'ido-ignore-buffers "*Buffer*")
      (add-to-list 'ido-ignore-buffers "*Help*")
      (add-to-list 'ido-ignore-buffers "*Completions*"))
  (progn
    (iswitchb-mode 1)
    (add-to-list 'iswitchb-buffer-ignore "*Messages*")
    (add-to-list 'iswitchb-buffer-ignore "*Buffer*")
    (add-to-list 'iswitchb-buffer-ignore "*Help*")
    (add-to-list 'iswitchb-buffer-ignore "*Completions")))

;; line numbers in the left margin
;; added in 23.1
;; (when (>= emacs-major-version 23)
;;   (global-linum-mode 1)
;;   (setq linum-format "%4d \u2502 "))

;; make inserting an iso-8601 timestamp easier
;; 'd' stands for date
;; 't' stands for timestamp
(global-set-key (kbd "C-c d") 'insert-timestamp-iso-8601)
(global-set-key (kbd "C-c t") 'insert-timestamp-iso-8601)
(defun insert-timestamp-iso-8601()
  "Insert timestamp in the ISO 8601 format"
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))


;; package.el added in emacs 24
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")))



;;  ---------------------------------------------------------------------------
;; | CUSTOM STUFF                                                              |
;;  ---------------------------------------------------------------------------

;; org mode department
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; org mode log timestamp when an item is marked as done
(setq org-log-done 'time)
;; org mode log the time too, not just the date
(setq org-log-done-with-time t)

;; don't show items stuck in waiting
(setq org-agenda-skip-function-global
      '(org-agenda-skip-entry-if 'todo '("WAITING")))

;; log state changes in drawer
(setq org-log-into-drawer t)
