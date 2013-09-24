;;; package --- Summary

;;; Commentary:

; all that ... thanks to http://caisah.info/emacs-for-python/
; http://www.emacswiki.org/emacs/dabbrev-expand-multiple.el
; http://www.emacswiki.org/emacs/PythonProgrammingInEmacs
; http://pedrokroger.net/2010/07/configuring-emacs-as-a-python-ide-2/
; https://github.com/gabrielelanaro/emacs-for-python

; start by calling me with this espeak tool xDDDDDD

; default font is
; https://www.gnu.org/software/emacs/manual/html_node/emacs/Fonts.html
;display: by this font (glyph code)
;xft:-unknown-Ubuntu Mono-normal-normal-normal-*-17-*-*-*-m-0-iso10646-1 (#x50)



;;; Code:
(require 'package)
(package-initialize)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/#packages/")))

(setq url-using-proxy t)
(setq url-proxy-services
      '(("http" . "arieger:winurere79@10.10.10.10:8080")
	("ftp"  . "arieger:winurere79@10.10.10.10:8080")))


(load "/usr/share/emacs/site-lisp/haskell-mode/haskell-site-file")

; pabbrev mode heult rum ... deswegen folgendes
;(setq max-lisp-eval-depth 10000)

(add-hook 'after-init-hook
                    '(lambda () (setq debug-on-error t)))


;(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
;(unless (require 'el-get nil 'noerror)
;  (with-current-buffer
;      (url-retrieve-synchronously
;       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;    (let (el-get-master-branch)
;      (goto-char (point-max))
;      (eval-print-last-sexp))))
;(el-get 'sync)

;(load-theme 'solarized-dark t)
;(require 'ir-black-theme)
;(require 'solarized-theme-dark)
;(require 'solarized-theme-light)
;(provide 'solarized)
(load-theme 'zenburn t)
;(load-theme 'wombat t)
;(load-theme 'ir-black t)
;(load-theme 'monokai t)
;(set-face-attribute 'default nil :font "Andale Mono-10") ; like in terminal vim
;(set-face-attribute 'default nil :font "DejaVu Sans Mono-17")
;(set-face-attribute 'default nil :font "Ubuntu Sans Mono-13") ???

; http://alexott.net/en/writings/emacs-devenv/EmacsErlang.htm

(require 'desktop)
  (desktop-save-mode 1)
  (defun my-desktop-save ()
    (interactive)
    ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
    (if (eq (desktop-owner) (emacs-pid))
        (desktop-save desktop-dirname)))
  (add-hook 'auto-save-hook 'my-desktop-save)

; ======================================================================
(require 'ido)
(ido-mode t)

; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-hook 'python-mode-hook 'auto-complete-mode)
(add-hook 'python-mode-hook 'jedi:ac-setup)

; some problems ... not found blabla
;(require 'autopair)
;(autopair-global-mode) ;; to enable in all buffers

;################################################
; marten
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)

;(add-hook 'after-init-hook #'global-flycheck-mode)

; ======================================================================
(require 'evil)
(evil-mode 1)
; ergoemacs-mode ???

(require 'yasnippet)
;(yas-global-mode 1)
(require 'paredit)
; very nice feature -------------
(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)
; -------------------------------
;(require 'volatile-highlights)
;(volatile-highlights-mode t)
(paredit-mode t)
(setq hl-paren-colors
'("red1" "orange1" "yellow1" "green1" "cyan1"
"slateblue1" "magenta1" "purple"))
;(require 'rainbow-delimiters)
;(global-rainbow-delimiters-mode)

; ======================================================================
; sweeter scrolling without jumps but doesnt work too nice with multi-term-mode
(setq scroll-margin 10)
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)
(add-hook 'term-mode-hook
          (lambda()
            (set (make-local-variable 'scroll-margin) 0)))
;(add-to-list 'term-mode-hook (lambda ()
;  (set (make-local-variable 'scroll-margin) 0)))

(add-to-list 'load-path "/home/marten/.emacs.d/elpa")
(require 'multi-term)

;; (defun tmux-exec-ghci-eval ()
;;   "Execute ghci-eval in tmux pane"
;;   (interactive)
;;   (shell-command "tmux send-keys -t dev:1.0 'elinks http://localhost' Enter"))

(setq tmux-session-name "dev")
(setq tmux-window-name 1)
(setq tmux-pane-number 0)

(defun tmux-exec (command)
  "Execute command in tmux pane"
  (interactive)
  (shell-command
    (format "tmux send-keys -t %s:%s.%s '%s' Enter" tmux-session-name tmux-window-name tmux-pane-number command)))

(defun tmux-exec-elinks ()
  "Execute 'bundle exec cucumber' in tmux pane"
  (interactive)
  (tmux-exec "elinks http://127.0.0.1"))

(defun tmux-setup (x y z)
  "Setup global variables for tmux session, window, and pane"
  (interactive "sEnter tmux session name: \nsEnter tmux window name: \nsEnter tmux pane number: ")
  (setq tmux-session-name x)
  (setq tmux-window-name y)
  (setq tmux-pane-number z)
  (message "Tmux Setup, session name: %s, window name: %s, pane number: %s" tmux-session-name tmux-window-name tmux-pane-number))

(add-to-list 'load-path "~/emacs.d/helm")
(require 'helm-config)
;(helm-mode 1)
(global-set-key (kbd "C-c h") 'helm-mini)

(server-start) ; not needed as i got "emacs --daemon" in xmonad.hs ;)
(global-highlight-changes-mode t)
; (global-set-key (kbd "<f5>") 'highlight-changes-previous-change)
; (global-set-key (kbd "<f6>") 'highlight-changes-next-change)
; (global-set-key (kbd "<f7>") 'highlight-changes-rotate-faces)
; (global-set-key (kbd "<f8>") 'highlight-changes-remove-highlight)


;(require 'buffer-stack)
;(global-set-key [(f10)] 'buffer-stack-up)
;(global-set-key [(f11)] 'buffer-stack-down)

; searching grep find and all that directories subdirectories
; M-x ansi-term (way better terminal shell in emacs)
; M-; comment / uncomment marked region
; M-a last sentence
; M-e next sentence
; C-u C-Spc goto last mark although ace-mode seems to be better ;)
; M-x grep "blub" *
; M-x grep "grep -nH -i -e" "blub" *.clj (case-insensitive)
; M-x grep-find !!!!!!!!!!!!!!! ace xDDDD
; C-x d dired
; ibuffer even better than ido-mode and dired !??
; minibuffer C-s C-r cycle through possibilities
; google: emacs dired open buffer getting back into dired
; in dired mode: v (viewing file) shift-q (quit back into dired mode) e (edit file) q (quit out dired)
; stop dired from opening up several buffers for each and every directory i look in! http://www.emacswiki.org/emacs/DiredReuseDirectoryBuffer
(put 'dired-find-alternate-file 'disabled nil)

; ======================================================================
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)
(define-key global-map (kbd "C-i") 'ace-jump-mode)

;(add-hook 'nrepl-interaction-mode-hook
;  'nrepl-turn-on-eldoc-mode)
;(setq nrepl-hide-special-buffers t)

; ======================================================================
; haskell mode ghc-mod
; http://www.mew.org/~kazu/proj/ghc-mod/en/emacs.html
(add-to-list 'load-path "/usr/bin/ghc-mod")
(add-to-list 'load-path "/home/marten/.emacs.d/elpa/flymake-haskell-multi-master")
(add-to-list 'load-path "/home/marten/.emacs.d/elpa/flymake-easy-master")
(add-to-list 'exec-path "~/.cabal/bin")
(require 'flymake-haskell-multi)
(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
(add-hook 'haskell-mode-hook (lambda () (ghc-init) (flymake-haskell-multi-load)))

; ======================================================================
(global-set-key (kbd "<C-tab>") 'other-window)
(global-set-key (kbd "C-+") 'delete-other-windows)
(global-set-key (kbd "C-#") 'split-window-horizontally)

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

(global-set-key (kbd "C-x a r") 'align-regexp)


; http://www.rockhoppertech.com/blog/learning-clojure-setting-up-the-emacs-on-osx/
; rich hickey also only uses inferior lisp
(setq inferior-lisp-program "lein repl")

; ======================================================================
(require 'key-chord)
(key-chord-mode 1)
; probably should set it to Ctrl-j ???
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
;; (define-key evil-normal-state-map (kbd "o") (lambda ()
;;                                               (interactive)
;;                                               (evil-append-line)
;;                                               (haskell-newline-and-indent)))

;; ; simulate vim's "nnoremap <space> 10jzz"
;; (define-key evil-normal-state-map " " (lambda ()
;;                      (interactive)
;;                      (next-line 10)
;;                      (evil-scroll-line-down 10)
;;                      ))
;; ; simulate vim's "nnoremap <backspace> 10kzz"
;; (define-key evil-normal-state-map [backspace] (lambda ()
;;                      (interactive)
;;                      (previous-line 10)
;;                      (evil-scroll-line-up 10)
;;                      ))

; flymake installieren ???

;(global-set-key [(control j)] 'newline-and-indent)
;(global-set-key (kbd "C-j") 'show-tab)
;(global-set-key [(\r)] 'newline-and-indent)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

; ======================================================================
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
;(setq inhibit-default-init t)
(global-hl-line-mode 1)
(setq make-backup-files t)
(line-number-mode 1)
;(linum-mode 1)
;(setq linum-format "%d ")
(column-number-mode 1)
(show-paren-mode 1)
;(electric-pair-mode 1)

; ======================================================================
(require 'pabbrev "/home/marten/.emacs.d/elpa/pabbrev.el")
;(global-pabbrev-mode)
(setq pabbrev-read-only-error nil)
;(setq pabbrev-minimal-expansion-p t)
(add-hook 'text-mode-hook (lambda () (pabbrev-mode 1)))
(setq x-stretch-cursor t)
(setq-default indent-tabs-mode nil)
;(setq-default show-trailing-whitespace t)
;(global-auto-revert-mode 1)

;(require 'whitespace)
;(setq whitespace-style '(face indentation trailing newline tabs))
;(setq whitespace-line-column nil)
;(set-face-attribute 'whitespace-line nil
;                    :background "purple"
;                    :foreground "white"
;                    :weight 'bold)
;(global-whitespace-mode 1)

;; (defun show-tab ()
;;   "Highlight tab."
;;   (interactive)
;;   (newline-and-indent)
;;   (next-line)
;;   (previous-line))

; ======================================================================
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-j") 'newline-and-indent)
(global-set-key (kbd "C-j") 'haskell-newline-and-indent)
(global-set-key (kbd "M-SPC") 'hippie-expand)
(setq hippie-expand-try-functions-list '(try-expand-dabbrev try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill try-complete-file-name-partially try-complete-file-name try-expand-all-abbrevs try-expand-list try-expand-line try-complete-lisp-symbol-partially try-complete-lisp-symbol))


; ======================================================================
; pabbrev completion menu in ido-mode
; as seen here http://www.emacswiki.org/emacs/PredictiveAbbreviation
(defun pabbrev-suggestions-ido (suggestion-list)
    "Use ido to display menu of all pabbrev suggestions."
      (when suggestion-list
            (pabbrev-suggestions-insert-word pabbrev-expand-previous-word)
                (pabbrev-suggestions-insert-word
                       (ido-completing-read "Completions: " (mapcar 'car suggestion-list)))))

(defun pabbrev-suggestions-insert-word (word)
    "Insert word in place of current suggestion, with no attempt to kill pabbrev-buffer."
      (let ((point))
            (save-excursion
                    (let ((bounds (pabbrev-bounds-of-thing-at-point)))
                        (progn
                              (delete-region (car bounds) (cdr bounds))
                                  (insert word)
                                      (setq point (point)))))
                (if point
                    (goto-char point))))

(fset 'pabbrev-suggestions-goto-buffer 'pabbrev-suggestions-ido)



; ======================================================================
;; (prefer-coding-system 'utf-8)
;; (setq coding-system-for-read 'utf-8)
;; (setq coding-system-for-write 'utf-8)

;################################################
;## KEYBINDINGS #################################
;
; C-x a r (mark region before(!) regex like "->" oder "--" oder ";" to be aligned
; M-S-/ Hippie Expand
; C-M-i GHC-mod expand

;################################################

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(flymake-errline ((((class color)) (:foreground "red" :bold t :underline "gray"))) t)
 '(flymake-warnline ((((class color)) (:foreground "gray" :bold t :underline nil))) t))
 ;'(flymake-warnline ((((class color)) (:foreground "yellow" :bold t :underline nil))) t))
(provide '.emacs)
;;; .emacs ends here
