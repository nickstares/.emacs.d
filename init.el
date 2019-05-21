(require 'package)

(add-to-list 'package-archives
       '("melpa" . "https://melpa.org/packages/") t)
(package-initialize) ;; You might already have this line
;; (defvar mswindows-p (string-match "windows" (symbol-name system-type)))

(load-theme 'solarized-light t)
;; (load-theme 'doom-solarized-light t)

;; (require 'doom-modeline)
;; (doom-modeline-mode 1)
;; ;; (require 'keychain-environment)
;; (keychain-refresh-environment)

;; (require 'exec-path-from-shell)
;; (exec-path-from-shell-copy-env "SSH_AGENT_PID")
;; (exec-path-from-shell-copy-env "SSH_AUTH_SOCK")

;; (require 'keychain-environment)
;; (keychain-refresh-environment)

;; (require 'exec-path-from-shell)
;; (exec-path-from-shell-copy-env "SSH_AGENT_PID")
;; (exec-path-from-shell-copy-env "SSH_AUTH_SOCK")

(setq load-prefer-newer t)


(defun edit-init ()
  "Open init.el"
  (interactive)
  (find-file "~/.emacs.d/init.el"))


;; (if window-system
;;     (load-theme 'solarized-light)
;;   (disable-theme 'solarized-light))
;; ; don't use solarized theme if inside term which may already have a theme
;; (if (display-graphic-p)
;; (load-theme 'solarized-light t)
;; (toggle-frame-maximized)
;; (add-hook 'window-setup-hook 'toggle-frame-maximized t)

(exec-path-from-shell-initialize)
(set-scroll-bar-mode 1)
(set-scroll-bar-mode nil)
(tool-bar-mode -1)
(setq visual-line-mode 1)
;; (setq-default show-trailing-whitespace nil) ;
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(setq ring-bell-function 'ignore)
(setq inhibit-startup-message t)
(setq blink-cursor-mode 0)
;; (setq default-cursor-type 'bar)

;; ORG
;; (org-indent-mode)
;; (set-face-attribute 'org-done nil :strike-through t)
;; (set-face-attribute 'org-headline-done nil :strike-through t)

;; (setq org-fontify-done-headline t)
;; (custom-set-faces
;;  '(org-done ((t (:foreground "Red"   
;;                  :weight normal
;;                  :strike-through t))))
;;  '(org-headline-done 
;;             ((((class color) (min-colors 16) (background dark)) 
;;                (:foreground "LightSalmon" :strike-through t)))))

(set-face-attribute 'default nil :font "Menlo-16")
;; (set-face-attribute 'default nil :font "ETBembo-15")


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
  "d"   'ido-dired
  "s"   'save-buffer
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

(require 'magit)
(unbind-key "ESC" magit-status-mode-map)

(use-package evil-magit
  :ensure t)


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
  (setq evil-escape-mode 1)
  (evil-define-key* evil-magit-state magit-mode-map [escape] nil)
  (setq evil-escape-excluded-major-modes
	(list 'magit-status-mode 'magit-refs-mode 'magit-log-mode 'magit-diff-mode)))

(require 'evil)
(defun bobby ()
  (interactive)
  (evil-mode 0)
  (evil-escape-mode 0))

(defun nick ()
  (interactive)
  (evil-mode 1)
  (evil-escape-mode 1))

;; from https://github.com/nlopes/dotfiles/blob/master/.emacs.d/rust.el
;; (use-package rust-mode
;;   :ensure t
;;   :defer t
;;   :init
;;   (require 'rust-mode)
;;   (global-company-mode)
;;   (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;;   :config
;;   (use-package company-racer)
;;   (use-package flycheck-rust)
;;   (use-package racer
;;     :ensure t
;;     :defer t
;;     :init (setq racer-rust-src-path
;;               (concat (string-trim
;;                        (shell-command-to-string "rustc --print sysroot"))
;;                       "/lib/rustlib/src/rust/src")) 
;;     :config
;;     (define-key rust-mode-map (kbd "M-\"") #'racer-find-definition)
;;     (add-hook 'racer-mode-hook #'eldoc-mode)
;;     (add-hook 'racer-mode-hook #'company-mode)
;;     (local-set-key (kbd "TAB") #'company-indent-or-complete-common)
;;     (setq company-tooltip-align-annotations t)
;;     )
;;   (defun my-rust-mode-hook()
;;     (setq compile-command "cargo run")
;;     (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
;;     (flycheck-mode)
;;     ;;(set (make-local-variable 'company-backends) '(company-racer))
;;     ;;(local-set-key (kbd "TAB") #'racer-complete-or-indent)
;;     )
;;   (add-hook 'rust-mode-hook 'my-rust-mode-hook)
;;   (add-hook 'rust-mode-hook #'racer-mode))

;; (with-eval-after-load 'flycheck
;;   (remove-hook 'flycheck-mode-hook #'flycheck-inline-mode))
;; (use-package rust-mode)

(use-package racer
  :requires rust-mode

  :init (setq racer-rust-src-path
              (concat (string-trim
                       (shell-command-to-string "rustc --print sysroot"))
                      "/lib/rustlib/src/rust/src"))

  :config
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode))

(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(setq flycheck-inline-display-function
      (lambda (msg pos)
        (let* ((ov (quick-peek-overlay-ensure-at pos))
               (contents (quick-peek-overlay-contents ov)))
          (setf (quick-peek-overlay-contents ov)
                (concat contents (when contents "\n") msg))
          (quick-peek-update ov)))
      flycheck-inline-clear-function #'quick-peek-hide)


(define-key evil-normal-state-map (kbd "") 'end-of-line)
(define-key evil-normal-state-map (kbd "9") 'lispyville-previous-opening)
(define-key evil-normal-state-map (kbd "0") 'lispyville-next-closing)

;; H	lispyville-backward-sexp
;; L	lispyville-forward-sexp
;; M-h	lispyville-beginning-of-defun
;; M-l	lispyville-end-of-defun
;; [	lispyville-previous-opening
;; ]	lispyville-next-closing
;; {	lispyville-next-opening
;; }	lispyville-previous-closing
;; (	lispyville-backward-up-list
;; )	lispyville-up-list


;; in normal mode may want to turn the above
;; 9 into lispyville-previous-opening
;; ( into lispyville-next-opening
;; 0 into lispyville-next-closing
;; ) into lispyville-previous-closing


;; EMACS LIKE COMMANDS
(define-key evil-normal-state-map (kbd "C-a") 'back-to-indentation)
(define-key evil-normal-state-map (kbd "C-e") 'end-of-visual-line)
(define-key evil-normal-state-map (kbd "C-f") 'forward-char)
(define-key evil-normal-state-map (kbd "C-b") 'backward-char)
(define-key evil-insert-state-map (kbd "C-a") 'back-to-indentation)
(define-key evil-insert-state-map (kbd "C-e") 'end-of-line)
(define-key evil-insert-state-map (kbd "C-k") 'kill-visual-line)
(define-key evil-insert-state-map (kbd "C-f") 'forward-char)
(define-key evil-insert-state-map (kbd "C-b") 'backward-char)
(define-key evil-insert-state-map (kbd "C-p") 'evil-previous-visual-line)
(define-key evil-insert-state-map (kbd "C-n") 'evil-next-visual-line)


(use-package treemacs
  :ensure t
  :defer t)

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

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


(add-hook 'emacs-lisp-mode-hook 'evil-cleverparens-mode)

(evil-collection-define-key 'normal 'emacs-lisp-mode-map (kbd "RET") 'eval-last-sexp)

;; DIRED
(require 'dired)
(define-key dired-mode-map (kbd "DEL") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory
(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory
(evil-collection-define-key 'normal 'dired-mode-map
  (kbd "DEL") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory
(evil-collection-define-key 'normal 'dired-mode-map
  (kbd "<return>") 'dired-find-alternate-file)  ; was dired-up-directory


(global-unset-key (kbd "C-x o"))
(global-set-key (kbd "C-x o") 'ace-window)
(global-set-key (kbd "C-x C-o") 'ace-window)


(global-set-key (kbd "C-w") 'kill-region)


(global-set-key "\C-x2" (lambda () (interactive)(split-window-vertically) (other-window 1)))
(global-set-key "\C-x3" (lambda () (interactive)(split-window-horizontally) (other-window 1)))


(use-package company
  :config
  (global-company-mode))

(general-create-definer cargo-leader-def
  ;; :prefix my-local-leader
  :prefix "SPC e")

(cargo-leader-def
  :states 'normal
  :keymaps 'cargo-minor-mode-map
  "b" 'cargo-process-run)

;; CLOJURE
(general-create-definer cider-leader-def
  :prefix "SPC c")

(cider-leader-def
 :states 'normal
 :keymaps 'cider-mode-map
 "j" 'cider-jack-in
 "c" 'cider-eval-defun-at-point
 "i" 'incanter-eval-and-display-chart
 "e b" 'cider-eval-buffer) 

(use-package cider
  :bind (:map cider-mode-map
	      ("C-c M-." . cider-find-var))
  :config
  (setq cider-repl-pop-to-buffer-on-connect nil))


(defun my-clojure-reset ()
  "Run a (reset)" 
  (when
    (cider-insert-in-repl "(do (ns user) (reset))" 't)))

(remove-hook 'cider-mode-hook
          (lambda ()
            (add-hook 'after-save-hook 'my-clojure-reset nil 'make-it-local)))

;; (use-package company
;;   :config
;;   (global-company-mode))

(defadvice cider-inspect (around evil activate)
    "In normal-state or motion-state, last sexp ends at point."
    (if (or (evil-normal-state-p) (evil-motion-state-p))
        (save-excursion
          (unless (or (eobp) (eolp)) (forward-char))
          ad-do-it)
      ad-do-it))

(add-hook 'clojure-mode-hook 'parinfer-mode)
(add-hook 'clojure-mode-hook 'evil-cleverparens-mode)
(add-hook 'clojure-mode-hook 'flycheck-mode)
(add-hook 'clojure-mode-hook 'company-mode)
(add-hook 'clojure-mode-hook 'cider-mode)
(evil-collection-define-key 'normal 'evil-cleverparens-mode-map (kbd "[") 'evil-cp-previous-closing)
(evil-collection-define-key 'normal 'evil-cleverparens-mode-map (kbd ";") 'evil-cp-previous-closing)
(evil-collection-define-key 'normal 'evil-cleverparens-mode-map (kbd "]") 'evil-cp-next-closing)
(evil-collection-define-key 'normal 'cider-mode-map (kbd "RET") 'cider-eval-last-sexp)

;; END CLOJURE

(evil-set-initial-state 'cider-repl-mode 'insert)
(evil-set-initial-state 'cider-inspector-mode 'normal)
(evil-set-initial-state 'shell-mode 'insert)
(evil-set-initial-state 'eshell-mode 'insert)

 (define-key evil-motion-state-map "j" 'evil-next-visual-line)
 (define-key evil-motion-state-map "k" 'evil-previous-visual-line)

  ;; Also in visual mode
 (define-key evil-visual-state-map "j" 'evil-next-visual-line)
 (define-key evil-visual-state-map "k" 'evil-previous-visual-line)

(setq cljr-warn-on-eval nil)
(require 'flycheck-joker)

;; (hs-minor-mode 1)
(global-flycheck-mode 1)

(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
        (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
      )


(require 'cider)
(setq incanter-temp-chart-file "/tmp/chart.png")
(setq incanter-wait-time 500)


(defun incanter-display-image-inline (buffer-name file-name)
  "Use `BUFFER-NAME' to display the image in `FILE-NAME'.
  Checks whether `BUFFER-NAME' already exists, and if not create
  as needed."
  (switch-to-buffer-other-window buffer-name)
  (iimage-mode t)
  (read-only-mode -1)
  (kill-region (point-min) (point-max))
  ;; unless we clear the cache, the same cached image will
  ;; always get re-displayed.
  (clear-image-cache nil)
  (insert-image (create-image file-name))
  (read-only-mode t))

(defun incanter-eval-and-display-chart ()
  "Evaluate the expression preceding point
   and display the chart into a popup buffer"
  (interactive)
  (let ((old-buf (current-buffer)))
    (condition-case nil
                    (delete-file incanter-temp-chart-file)
                    (error nil))
    (cider-eval-last-sexp)
    (sleep-for 0 incanter-wait-time)
    (incanter-display-image-inline "*incanter-chart*" incanter-temp-chart-file)
    (switch-to-buffer-other-window old-buf)))

(define-key cider-mode-map
    (kbd "C-c i") #'incanter-eval-and-display-chart)

(add-hook 'rust-mode-hook
          (lambda ()
	    ;; (local-set-key (kbd ", c r") #'cargo-process-run)
            (local-set-key (kbd "M-q") #'rust-format-buffer)))
(add-hook 'rust-mode-hook 'cargo-minor-mode)

;; useful for colorizing cargo process
(require 'ansi-color)
(defun my/ansi-colorize-buffer ()
  (let ((buffer-read-only nil))
    (ansi-color-apply-on-region (point-min) (point-max))))
(add-hook 'compilation-filter-hook 'my/ansi-colorize-buffer)

(setq racer-cmd "~/.cargo/bin/racer") ;; Rustup binaries PATH
(setq racer-rust-src-path "/Users/nick/source/rust/src") ;; Rust source code PATH

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

(add-hook 'markdown-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-<return>") #'markdown-insert-list-item)))

(add-hook 'olivetti-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-e") #'end-of-visual-line)))

;; this lets evil-forward-sentence begin find a the next sentence using a . instead of double space
(setq sentence-end-double-space nil)



;; see https://github.com/politza/pdf-tools/issues/480
(setenv "PKG_CONFIG_PATH" "/usr/local/lib/pkgconfig:/usr/local/Cellar/libffi/3.2.1/lib/pkgconfig")

(defun my/modify-org-done-face ()
  (setq org-fontify-done-headline t)
  (set-face-attribute 'org-done nil :strike-through t)
  (set-face-attribute 'org-headline-done nil
		      :foreground "light grey"
                      :strike-through t))

(add-hook 'org-mode-hook 'my/modify-org-done-face)
(setq org-fontify-done-headline t)
(set-face-attribute 'org-done nil :strike-through t)
(set-face-attribute 'org-headline-done nil :strike-through t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#c0c0c0" "#336c6c" "#806080" "#0f2050" "#732f2c" "#23733c" "#6c1f1c" "#232333"])
 '(blink-cursor-mode nil)
 '(byte-compile-delete-errors nil)
 '(cider-auto-jump-to-error nil)
 '(cider-auto-select-error-buffer t)
 '(cider-cljs-lein-repl
   "(do (require 'figwheel-sidecar.repl-api) (figwheel-sidecar.repl-api/start-figwheel!) (figwheel-sidecar.repl-api/cljs-repl))")
 '(cider-debug-use-overlays t)
 '(cider-default-cljs-repl (quote figwheel))
 '(cider-mode-line nil)
 '(cider-mode-line-show-connection nil)
 '(cider-repl-pop-to-buffer-on-connect (quote display-only))
 '(cider-show-error-buffer (quote except-in-repl))
 '(cider-stacktrace-default-filters (quote (tooling dup clojure java REPL)))
 '(cider-use-overlays t)
 '(company-auto-complete t)
 '(company-auto-complete-chars nil)
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
    ("10461a3c8ca61c52dfbbdedd974319b7f7fd720b091996481c8fb1dded6c6116" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "bfdcbf0d33f3376a956707e746d10f3ef2d8d9caa1c214361c9c08f00a1c8409" "bea5fd3610ed135e6ecc35bf8a9c27277d50336455dbdd2969809f7d7c1f7d79" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "9a155066ec746201156bb39f7518c1828a73d67742e11271e4f24b7b178c4710" "43c1a8090ed19ab3c0b1490ce412f78f157d69a29828aa977dae941b994b4147" "53f97243218e8be82ba035ae34c024fd2d2e4de29dc6923e026d5580c77ff702" default)))
 '(dired-recursive-copies (quote always))
 '(electric-indent-mode t)
 '(evil-cleverparens-complete-parens-in-yanked-region nil)
 '(evil-cleverparens-use-additional-bindings t)
 '(evil-cleverparens-use-additional-movement-keys nil)
 '(evil-cleverparens-use-regular-insert t)
 '(evil-escape-delay 0.1)
 '(evil-escape-excluded-major-modes
   (quote
    (quote
     ((quote magit-mode)
      (quote magit-status-mode)
      (quote magit-refs-mode)))))
 '(evil-escape-mode t)
 '(evil-lispy-cursor (quote ("blue" box)))
 '(evil-want-Y-yank-to-eol t)
 '(fci-rule-color "#3C3D37")
 '(flx-ido-mode t)
 '(frame-background-mode (quote light))
 '(global-company-mode nil)
 '(global-evil-visualstar-mode t)
 '(global-linum-mode nil)
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
 '(ido-mode (quote both) nil (ido))
 '(jdee-db-active-breakpoint-face-colors (cons "#FFFBF0" "#268bd2"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#FFFBF0" "#859900"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#FFFBF0" "#E1DBCD"))
 '(lispyville-key-theme
   (quote
    (operators c-w slurp/barf-cp additional-insert additional additional-movement)))
 '(magit-diff-use-overlays nil)
 '(magit-display-buffer-function (quote magit-display-buffer-same-window-except-diff-v1))
 '(magit-save-repository-buffers nil)
 '(muse-project-alist nil)
 '(nrepl-message-colors
   (quote
    ("#336c6c" "#205070" "#0f2050" "#806080" "#401440" "#6c1f1c" "#6b400c" "#23733c")))
 '(org-agenda-files nil)
 '(package-selected-packages
   (quote
    (kotlin-mode simple-httpd pandoc-mode impatient-mode flymd doom-themes doom-modeline esup pdf-tools flycheck-rust racer cargo flycheck company-racer flycheck-inline rust-mode evil-vimish-fold yafolding flycheck-joker clojure-snippets ein writeroom-mode gnuplot company-terraform keychain-environment evil-terminal-cursor-changer dired-sidebar terraform-mode org-bullets olivetti muse simpleclip flycheck-pos-tip flycheck-clojure ejc-sql solarized-theme spaceline powerline-evil airline-themes hl-todo benchmark-init fill-column-indicator company-tern xref-js2 js2-refactor js2-mode evil-visualstar general evil-leader json-mode better-shell dired-quick-sort dired-hide-dotfiles treemacs-evil treemacs use-package nyan-mode vimish-fold lsp-mode yaml-mode adjust-parens highlight-parentheses aggressive-indent evil-smartparens evil-cleverparens smartparens evil-surround color-theme-sanityinc-solarized color-theme-solarized highlight2clipboard evil-lispy lispyville diminish evil-magit neotree org align-cljlet clj-refactor el-get runner flx-ido which-key with-editor counsel evil-escape helm-clojuredocs clojure-cheatsheet clojure-mode cider parinfer ace-window key-chord avy helm-ag-r ag projectile magit company helm-ag helm)))
 '(pdf-view-midnight-colors (quote ("#232333" . "#c7c7c7")))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(powerline-default-separator (quote wave))
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" ".svn" "build" "target" "node_modules")))
 '(projectile-globally-ignored-files (quote ("TAGS" "*.log" "*.tmp")))
 '(rich-minority-mode nil)
 '(rm-blacklist (quote ("\"vc-mode\"")))
 '(safe-local-variable-values
   (quote
    ((cider-ns-refresh-after-fn . "integrant.repl/resume")
     (cider-ns-refresh-before-fn . "integrant.repl/suspend")
     (cider-refresh-after-fn . "integrant.repl/resume")
     (cider-refresh-before-fn . "integrant.repl/suspend")
     (cider-clojure-cli-global-options . "-A:dev:build:dev/build:dev/cljs"))))
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

(put 'dired-find-alternate-file 'disabled nil)

(eval-after-load "markdown-mode"
  '(defun markdown-display-inline-images ()
  "Add inline image overlays to image links in the buffer.
This can be toggled with `markdown-toggle-inline-images'
or \\[markdown-toggle-inline-images]."
  (interactive)
  (unless (display-images-p)
    (error "Cannot show images"))
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (while (re-search-forward markdown-regex-link-inline nil t)
        (let ((start (match-beginning 0))
              (end (match-end 0))
              (file (match-string-no-properties 6)))
          (when (file-exists-p file)
            (let* ((abspath (if (file-name-absolute-p file)
                                file
                              (concat default-directory file)))
                   (image
                    (if (and markdown-max-image-size
                             (image-type-available-p 'imagemagick))
                        (create-image
                         abspath 'imagemagick nil
                         :max-width (car markdown-max-image-size)
                         :max-height (cdr markdown-max-image-size))
                      (create-image abspath))))
              (when image
                (setq newStart (+ end ))
                (setq newEnd (+ end 1))
                (let ((ov (make-overlay newStart newEnd)))
                  (message "%s" newEnd)
                  (overlay-put ov 'display image)
                  (overlay-put ov 'face 'default)
                  (overlay-put ov 'before-string "\n\n")
                  (push ov markdown-inline-image-overlays))))))))))
)
(put 'upcase-region 'disabled nil)
