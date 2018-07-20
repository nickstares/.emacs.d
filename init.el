(require 'package)

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize) ;; You might already have this line
;; (defvar mswindows-p (string-match "windows" (symbol-name system-type)))


;; GENERAL
(exec-path-from-shell-initialize)

(set-scroll-bar-mode nil)
(tool-bar-mode -1)
(setq visual-line-mode 1)
(setq-default show-trailing-whitespace 't)
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(define-key global-map [menu-bar words] t)
(setq ring-bell-function 'ignore)
(setq inhibit-startup-message t)

(setq default-cursor-type 'bar)

(set-face-attribute 'default nil :font "Menlo-15")

(editorconfig-mode 1)

(setq-default rainbow-delimiters-mode t)

(global-set-key (kbd "C-k") 'kill-line)
(global-set-key (kbd "C--") 'undo)

;; PROJECTILE
(projectile-mode)
(projectile-global-mode)



;; IDO
(ido-mode 1)
(ido-everywhere 0)
(global-set-key (kbd "C-x C-f") 'ido-find-file)
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x b") 'ido-switch-buffer)
(global-set-key (kbd "C-x C-m") 'smex)
(global-set-key (kbd "C-x m") 'smex)
(global-set-key (kbd "M-x") 'smex)


(use-package evil
  :ensure t
  :init
  (setq evil-want-integration nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(setq evil-escape-key-sequence "kj")

(setq evil-escape-mode 1)

(define-key evil-normal-state-map (kbd "C-e") 'end-of-line)
(define-key evil-insert-state-map (kbd "C-a") 'beginning-of-line)

(defun evil-keyboard-quit ()
  "Keyboard quit and force normal state."
  (interactive)
  (and evil-mode (evil-force-normal-state))
  (keyboard-quit))

(setq evil-want-C-u-scroll t)
;;Parinfer
(require 'parinfer)
(global-set-key (kbd "C-x C-.") 'parinfer-toggle-mode)
(global-set-key (kbd "C-,") 'parinfer-toggle-mode)
(setq parinfer-extensions '(defaults pretty-parens smart-yank one evil))
(define-key parinfer-mode-map (kbd "C-a") 'back-to-indentation)
(define-key parinfer-mode-map (kbd "M-m") 'move-beginning-of-line)


(add-hook 'clojure-mode-hook 'parinfer-mode)
(add-hook 'clojure-mode-hook 'evil-cleverparens-mode)

;; PUTATIVE ALTERNATIVE PAREN MANAGEMENT

;; (add-hook 'clojure-mode-hook 'smartparens-mode)
;; (remove-hook 'clojure-mode-hook 'evil-cleverparens-mode)
;; (remove-hook 'clojure-mode-hook 'smartparens-mode)
;; (remove-hook 'clojure-mode-hook 'smartparens-strict-mode)
;;(remove-hook 'clojure-mode-hook 'aggressive-indent-mode)
;; (require 'evil-cleverparens)
;; (define-key evil-cleverparens-mode-map (kbd "}") defaule)
;; (define-key evil-cleverparens-mode-map (kbd "{") )
;; (define-key evil-normal-state-map (kbd "}") 'evil-forward-paragraph)
;; (define-key evil-normal-state-map (kbd "{") 'evil-backward-paragraph)
(setq evil-cp-additional-movement-keys
 '(("L" . evil-cp-forward-sexp)
 ("H" . evil-cp-backward-sexp)
 ("M-l" . evil-cp-end-of-defun)
 ("M-h" . evil-cp-beginning-of-defun)
 ("[" . evil-cp-previous-opening)
 ("]" . evil-cp-next-closing)
 ("{" . evil-backward-paragraph)
 ("}" . evil-forward-paragraph)
 ("(" . evil-cp-backward-up-sexp)
 (")" . evil-cp-up-sexp)))


;; DIRED
(require 'dired)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file) ; was dired-advertised-find-file
(define-key dired-mode-map (kbd "DEL") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory
(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory

;; (defun xah-dired-mode-setup ()
;;   "to be run as hook for `dired-mode'."
;;   (dired-hide-details-mode 1))

;; (add-hook 'dired-mode-hook 'xah-dired-mode-setup)
;;(load "~/.emacs.d/dired+.el")
;; (diredp-toggle-find-file-reuse-dir 1)
  (add-hook 'dired-load-hook
            (function (lambda () (load "dired-x"))))




(setq helm-split-window-inside-p t)

(global-unset-key (kbd "C-x o"))
(global-set-key (kbd "C-x o") 'ace-window)
(global-set-key (kbd "C-x C-o") 'ace-window)


(global-set-key (kbd "C-w") 'kill-region)


(global-set-key "\C-x2" (lambda () (interactive)(split-window-vertically) (other-window 1)))
(global-set-key "\C-x3" (lambda () (interactive)(split-window-horizontally) (other-window 1)))

(require 'cider)

(define-key cider-mode-map (kbd "C-c M-.") 'cider-find-var)

(global-set-key (kbd "M-[") 'backward-paragraph)
(global-set-key (kbd "M-]") 'forward-paragraph)
(global-set-key (kbd "<f2>") 'cider-eval-last-sexp)
(global-set-key (kbd "<f3>") 'cider-eval-defun-at-point)
(setq cider-repl-pop-to-buffer-on-connect nil)

(defadvice cider-last-sexp (around evil activate)
    "In normal-state or motion-state, last sexp ends at point."
    (if (or (evil-normal-state-p) (evil-motion-state-p))
        (save-excursion
          (unless (or (eobp) (eolp)) (forward-char))
          ad-do-it)
      ad-do-it))


(global-set-key (kbd "C-s") 'swiper)


(require 'magit)

(defun magit-publish ()
  (interactive)
  (when (yes-or-no-p "Publish this branch? ")
    (eshell-command
     (format "git push -u origin %s" (magit-get-current-branch)))))
;; (define-key magit-mode-map (kbd "k") #'previous-line)
;; (define-key magit-mode-map (kbd "K") 'magit-discard)
;; (define-key magit-mode-map (kbd "j") #'next-line)



;; (use-package evil-collection
;;   :after evil
;;   :ensure t
;;   :config
;;   (evil-collection-init))

(evil-set-initial-state 'cider-repl-mode 'emacs)
(evil-set-initial-state 'cider-inspector-mode 'emacs)
(evil-set-initial-state 'shell-mode 'emacs)




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#c0c0c0" "#336c6c" "#806080" "#0f2050" "#732f2c" "#23733c" "#6c1f1c" "#232333"])
 '(blink-cursor-mode t)
 '(byte-compile-delete-errors t)
 '(cider-auto-jump-to-error nil)
 '(cider-auto-select-error-buffer nil)
 '(cider-debug-use-overlays t)
 '(cider-mode-line nil)
 '(cider-mode-line-show-connection nil)
 '(cider-show-error-buffer nil)
 '(cider-use-overlays t)
 '(company-quickhelp-color-background "#b0b0b0")
 '(company-quickhelp-color-foreground "#232333")
 '(compilation-message-face (quote default))
 '(cursor-in-non-selected-windows (quote hollow))
 '(cursor-type (quote bar))
 '(custom-enabled-themes (quote (sanityinc-solarized-light)))
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "bfdcbf0d33f3376a956707e746d10f3ef2d8d9caa1c214361c9c08f00a1c8409" "bea5fd3610ed135e6ecc35bf8a9c27277d50336455dbdd2969809f7d7c1f7d79" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "9a155066ec746201156bb39f7518c1828a73d67742e11271e4f24b7b178c4710" "43c1a8090ed19ab3c0b1490ce412f78f157d69a29828aa977dae941b994b4147" "53f97243218e8be82ba035ae34c024fd2d2e4de29dc6923e026d5580c77ff702" default)))
 '(dired-recursive-copies (quote always))
 '(evil-cleverparens-use-additional-movement-keys t)
 '(evil-cleverparens-use-regular-insert t)
 '(evil-escape-mode t)
 '(evil-lispy-cursor (quote ("blue" box)))
 '(fci-rule-color "#3C3D37")
 '(frame-background-mode (quote light))
 '(global-linum-mode t)
 '(global-visual-line-mode t)
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100))))
 '(hl-sexp-background-color "#efebe9")
 '(magit-diff-use-overlays nil)
 '(magit-save-repository-buffers nil)
 '(nrepl-message-colors
   (quote
    ("#336c6c" "#205070" "#0f2050" "#806080" "#401440" "#6c1f1c" "#6b400c" "#23733c")))
 '(org-agenda-files (quote ("~/org/school.org" "~/org/home.org")))
 '(package-selected-packages
   (quote
    (dired-hide-dotfiles treemacs-evil treemacs use-package nyan-mode vimish-fold lsp-mode yaml-mode adjust-parens highlight-parentheses aggressive-indent evil-smartparens evil-cleverparens smartparens evil-surround zenburn-theme anti-zenburn-theme color-theme-sanityinc-solarized color-theme-solarized solarized-theme highlight2clipboard evil-lispy lispyville exwm diminish evil-magit shell-pop neotree org align-cljlet clj-refactor el-get runner 4clojure flx-ido which-key with-editor counsel evil-escape helm-clojuredocs clojure-cheatsheet synosaurus sx org-pomodoro clojure-mode cider parinfer ace-window key-chord magit-gh-pulls achievements avy helm-ag-r ag org-jira helm-projectile projectile magit company helm-ag omnisharp helm monokai-theme)))
 '(pdf-view-midnight-colors (quote ("#232333" . "#c7c7c7")))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(rich-minority-mode nil)
 '(rm-blacklist (quote ("\"vc-mode\"")))
 '(shell-pop-universal-key "C-t")
 '(show-paren-mode t)
 '(sp-navigate-interactive-always-progress-point t)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(avy-lead-face ((t (:background "#e52b50" :foreground "white" :height 1.3 :width extra-expanded))))
 '(avy-lead-face-0 ((t (:background "#4f57f9" :foreground "white" :height 1.3))))
 '(cursor ((t (:background "navy")))))
(put 'dired-find-alternate-file 'disabled nil)
