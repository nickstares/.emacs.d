(require 'package)

(add-to-list 'package-archives
       '("melpa" . "https://melpa.org/packages/") t)
(package-initialize) ;; You might already have this line
;; (defvar mswindows-p (string-match "windows" (symbol-name system-type)))

(defun edit-init ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(load-theme 'solarized-light t)

(exec-path-from-shell-initialize)

(set-scroll-bar-mode nil)
(tool-bar-mode -1)
(setq visual-line-mode 1)
;; (setq-default show-trailing-whitespace nil) ;
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(setq ring-bell-function 'ignore)
(setq inhibit-startup-message t)
(setq default-cursor-type 'bar)

(set-face-attribute 'default nil :font "Menlo-15")


(editorconfig-mode 1)

(setq-default rainbow-delimiters-mode t)

(global-set-key (kbd "C-k") 'kill-line)
(global-set-key (kbd "C--") 'undo)

(use-package ido
  :bind (("C-x b" . 'ido-switch-buffer)
         ("C-x C-b" . 'ido-switch-buffer))
  :ensure t
  :config
  (setq ido-everywhere 1)
  (ido-mode 1))

;; PROJECTILE

(use-package smex
  :bind (("C-x C-m" . smex)
         ("M-x" . smex)
         ("C-x m" . smex)))

(require 'general)

(general-create-definer my-leader-def
  ;; :prefix my-leader
  :prefix "SPC")

(my-leader-def
  :states 'normal
  :keymaps 'override
  ;; bind "SPC a"
  "f" 'ido-find-file
  "SPC" 'smex
  "b"   'ido-switch-buffer)

(require 'projectile)

(general-create-definer projectile-leader-def
  ;; :prefix my-local-leader
  :prefix "SPC p")

(projectile-leader-def
  :states 'normal
  :keymaps 'override
  "f" 'projectile-find-file)

(general-create-definer magit-leader-def
    :prefix "SPC g")

(magit-leader-def
  :states 'normal
  :keymaps 'override
  "s" 'magit-status)

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration nil)
  :config
  (evil-mode 1))

(use-package evil-magit
  :ensure t)

(load-theme 'solarized-light t)

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-escape
  :after evil
  :ensure t
  :config
  (setq evil-escape-key-sequence "kj")
  (setq evil-escape-mode 1))

(define-key evil-normal-state-map (kbd "C-e") 'end-of-line)
(define-key evil-normal-state-map (kbd "C-a") 'back-to-indentation)
(define-key evil-insert-state-map (kbd "C-a") 'back-to-indentation)
(define-key evil-insert-state-map (kbd "C-e") 'end-of-line)

(defun evil-keyboard-quit ()
  "Keyboard quit and force normal state."
  (interactive)
  (and evil-mode (evil-force-normal-state))
  (keyboard-quit))

(setq evil-want-C-u-scroll t)
;;Parinfer
(use-package parinfer
  :bind (:map parinfer-mode-map
              ("C-," . parinfer-toggle-mode)
              ("C-a" . back-to-indentation)
              ("M-m" . move-beginning-of-line)))

(add-hook 'clojure-mode-hook 'parinfer-mode)
(add-hook 'clojure-mode-hook 'evil-cleverparens-mode)

;; DIRED
(require 'dired)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file) ; was dired-advertised-find-file
(define-key dired-mode-map (kbd "DEL") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory
(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory
;; (evil-collection-define-key 'normal 'dired-mode-map
;;   (kbd "DEL") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory


(setq helm-split-window-inside-p t)

(global-unset-key (kbd "C-x o"))
(global-set-key (kbd "C-x o") 'ace-window)
(global-set-key (kbd "C-x C-o") 'ace-window)


(global-set-key (kbd "C-w") 'kill-region)


(global-set-key "\C-x2" (lambda () (interactive)(split-window-vertically) (other-window 1)))
(global-set-key "\C-x3" (lambda () (interactive)(split-window-horizontally) (other-window 1)))

(use-package cider
  :bind (:map cider-mode-map
              ("C-c M-." . cider-find-var))
  :config
  (setq cider-repl-pop-to-buffer-on-connect nil))


;; (defadvice cider-last-sexp (around evil activate)
;;     "In normal-state or motion-state, last sexp ends at point."
;;     (if (or (evil-normal-state-p) (evil-motion-state-p))
;;         (save-excursion
;;           (unless (or (eobp) (eolp)) (forward-char))
;;           ad-do-it)
;;       ad-do-it))
(defadvice cider-inspect (around evil activate)
    "In normal-state or motion-state, last sexp ends at point."
    (if (or (evil-normal-state-p) (evil-motion-state-p))
        (save-excursion
          (unless (or (eobp) (eolp)) (forward-char))
          ad-do-it)
      ad-do-it))


;; (require 'magit)

;; (defun magit-publish ()
;;   (interactive)
;;   (when (yes-or-no-p "Publish this branch? ")
;;     (eshell-command
;;      (format "git push -u origin %s" (magit-get-current-branch)))))
;; ;; (define-key magit-mode-map (kbd "k") #'previous-line)
;; (define-key magit-mode-map (kbd "K") 'magit-discard)
;; (define-key magit-mode-map (kbd "j") #'next-line)


(evil-set-initial-state 'cider-repl-mode 'insert)
(evil-set-initial-state 'cider-inspector-mode 'emacs)
(evil-set-initial-state 'shell-mode 'insert)



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
 '(byte-compile-delete-errors nil)
 '(cider-auto-jump-to-error nil)
 '(cider-auto-select-error-buffer nil)
 '(cider-cljs-lein-repl
   "(do (require 'figwheel-sidecar.repl-api) (figwheel-sidecar.repl-api/start-figwheel!) (figwheel-sidecar.repl-api/cljs-repl))")
 '(cider-debug-use-overlays t)
 '(cider-mode-line nil)
 '(cider-mode-line-show-connection nil)
 '(cider-show-error-buffer nil)
 '(cider-use-overlays t)
 '(company-auto-complete t)
 '(company-idle-delay 0)
 '(company-minimum-prefix-length 2)
 '(company-quickhelp-color-background "#b0b0b0")
 '(company-quickhelp-color-foreground "#232333")
 '(compilation-message-face (quote default))
 '(completion-auto-help nil)
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(cursor-in-non-selected-windows (quote hollow))
 '(cursor-type (quote bar))
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "bfdcbf0d33f3376a956707e746d10f3ef2d8d9caa1c214361c9c08f00a1c8409" "bea5fd3610ed135e6ecc35bf8a9c27277d50336455dbdd2969809f7d7c1f7d79" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "9a155066ec746201156bb39f7518c1828a73d67742e11271e4f24b7b178c4710" "43c1a8090ed19ab3c0b1490ce412f78f157d69a29828aa977dae941b994b4147" "53f97243218e8be82ba035ae34c024fd2d2e4de29dc6923e026d5580c77ff702" default)))
 '(dired-recursive-copies (quote always))
 '(electric-indent-mode t)
 '(evil-cleverparens-complete-parens-in-yanked-region nil)
 '(evil-cleverparens-use-additional-bindings t)
 '(evil-cleverparens-use-additional-movement-keys t)
 '(evil-cleverparens-use-regular-insert t)
 '(evil-escape-delay 0.1)
 '(evil-escape-mode t)
 '(evil-lispy-cursor (quote ("blue" box)))
 '(fci-rule-color "#3C3D37")
 '(frame-background-mode (quote light))
 '(global-company-mode nil)
 '(global-evil-visualstar-mode t)
 '(global-linum-mode t)
 '(global-visual-line-mode t)
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
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
 '(hl-bg-colors
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(hl-paren-colors (quote ("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900")))
 '(hl-sexp-background-color "#efebe9")
 '(ido-completion-buffer "nil")
 '(ido-everywhere t)
 '(lispyville-key-theme
   (quote
    (operators c-w slurp/barf-cp additional-insert additional additional-movement)))
 '(magit-diff-use-overlays nil)
 '(magit-display-buffer-function (quote magit-display-buffer-same-window-except-diff-v1))
 '(magit-save-repository-buffers nil)
 '(nrepl-message-colors
   (quote
    ("#336c6c" "#205070" "#0f2050" "#806080" "#401440" "#6c1f1c" "#6b400c" "#23733c")))
 '(org-agenda-files nil)
 '(package-selected-packages
   (quote
    (simpleclip flycheck-pos-tip flycheck-clojure ejc-sql solarized-theme spacemacs-theme spaceline-all-the-icons spaceline powerline-evil airline-themes hl-todo helm-spotify-plus spotify benchmark-init fill-column-indicator company-tern xref-js2 js2-refactor js2-mode evil-visualstar general evil-leader json-mode better-shell dired-quick-sort pdf-tools dired-hide-dotfiles treemacs-evil treemacs use-package nyan-mode vimish-fold lsp-mode yaml-mode adjust-parens highlight-parentheses aggressive-indent evil-smartparens evil-cleverparens smartparens evil-surround zenburn-theme anti-zenburn-theme color-theme-sanityinc-solarized color-theme-solarized highlight2clipboard evil-lispy lispyville exwm diminish evil-magit neotree org align-cljlet clj-refactor el-get runner 4clojure flx-ido which-key with-editor counsel evil-escape helm-clojuredocs clojure-cheatsheet synosaurus sx org-pomodoro clojure-mode cider parinfer ace-window key-chord magit-gh-pulls achievements avy helm-ag-r ag org-jira projectile magit company helm-ag omnisharp helm monokai-theme)))
 '(pdf-view-midnight-colors (quote ("#232333" . "#c7c7c7")))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(powerline-default-separator (quote wave))
 '(rich-minority-mode nil)
 '(rm-blacklist (quote ("\"vc-mode\"")))
 '(shell-pop-universal-key "C-t")
 '(show-paren-mode t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(sp-navigate-interactive-always-progress-point t)
 '(split-width-threshold 150)
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
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
   (unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0"))
 '(xterm-color-names
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642"])
 '(xterm-color-names-bright
   ["#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(avy-lead-face ((t (:background "#e52b50" :foreground "white" :height 1.3 :width extra-expanded))))
 '(avy-lead-face-0 ((t (:background "#4f57f9" :foreground "white" :height 1.3))))
 '(cursor ((t (:background "navy")))))

