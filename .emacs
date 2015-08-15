;; don't start in the "help" screen when you start emacs with no file. start in
;; *scratch* instead
(setq inhibit-startup-message t)

;; font-lock for all buffers
(global-font-lock-mode 1)

;; stop at the end of the file, don't just add lines
(setq next-line-add-newlines nil)

;; show column-number in the mode line
(column-number-mode t)

;; highlight regions (when yanking)
(transient-mark-mode 1)

;; show line number in the mode line
(line-number-mode t)

;; y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;; ido mode is much better
;; added in 22.1
;; https://www.gnu.org/software/emacs/news/NEWS.22.1
;;
;; use C-s and C-r to cycle through possible options
(if (>= emacs-major-version 22)
    (progn
      (ido-mode t)
      (setq ido-enable-flex-matching t)
      ;;(add-to-list 'ido-ignore-buffers "^ ")
      (add-to-list 'ido-ignore-buffers "*Messages*")
      (add-to-list 'ido-ignore-buffers "*Buffer*")
      (add-to-list 'ido-ignore-buffers "*Help*")
      (add-to-list 'ido-ignore-buffers "*Completions*"))
  (progn
    (iswitchb-mode 1)
    ;;(add-to-list 'iswitchb-buffer-ignore "^ ")
    (add-to-list 'iswitchb-buffer-ignore "*Messages*")
    (add-to-list 'iswitchb-buffer-ignore "*Buffer*")
    (add-to-list 'iswitchb-buffer-ignore "*Help*")
    (add-to-list 'iswitchb-buffer-ignore "*Completions")))

;; give me a preview in the mini buffer
(icomplete-mode 1)

;; ibuffer added in 22.1
;; https://www.gnu.org/software/emacs/news/NEWS.22.1
;;
;; rebind C-x C-b to use ibuffer
(if (>= emacs-major-version 22)
    (defalias 'list-buffers 'ibuffer-other-window))

;; disable menu bar, AKA "drop down menu" which is useless if its not running
;; in x11
(unless (display-graphic-p)
  (menu-bar-mode -1))

;; don't display anything in scatch buffer
(setq initial-scratch-message "")

;; toolbar is uselss 100% of the time including in a GUI but the symbole is only
;; defined when using a graphical display
;;
;; https://serverfault.com/questions/132055/how-to-check-if-emacs-is-in-gui-mode-and-execute-tool-bar-mode-only-then
;; https://superuser.com/questions/313398/how-to-prevent-the-symbols-function-definition-is-void-error-when-running-em
(if (display-graphic-p)
    (tool-bar-mode -1))

;; stop making tilde backup files
(setq make-backup-files nil)

;; give duplicate buffers better names instead of somefile<1> and somefile<2>
;; they get somefile<foo> and somefile<bar> when they are in the 'foo' and 'bar'
;; dirs
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-after-kill-buffer-p 1)

;; simple highlighting for files where no mode is defined
(require 'generic-x)

;; show time in the mode line
;; (setq display-time-24hr-format t)
;; (display-time-mode 1)

;; fill at 80 columns
(setq-default fill-column 80)

;; M-g is now goto-line
(global-set-key "\M-g" 'goto-line)

;; make inserting an iso-8601 timestamp easier
;; 'd' stands for date
;; 't' stands for timestamp
(global-set-key (kbd "C-c d") 'insert-timestamp-iso-8601)
(global-set-key (kbd "C-c t") 'insert-timestamp-iso-8601)

;; show trailine whitespace
(setq-default show-trailing-whitespace t)

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

;; http://emacsredux.com/blog/2013/04/05/prog-mode-the-parent-of-all-programming-modes/
;; prog-mode added in 24.1
;; https://www.gnu.org/software/emacs/news/NEWS.24.1
(if (>= emacs-major-version 24)
    (add-hook 'prog-mode-hook 'flyspell-prog-mode))

;; line numbers in the left margin
;; added in 23.1
;; https://www.gnu.org/software/emacs/news/NEWS.23.1
;; (if (>= emacs-major-version 23)
;;     (global-linum-mode 1))

;; mostly for rpm-spec mode
(setq user-mail-address "mmckinst@example.com")
(setq user-full-name "Mark McKinstry")

;; always end a file with a new line
(setq-default require-final-newline t)

(defun insert-timestamp-iso-8601()
  "Insert timestamp in the ISO 8601 format"
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))


(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
