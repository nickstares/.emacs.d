
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
;;  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
   (add-to-list 'package-archives 
                     '("melpa" . "http://melpa.milkbox.net/packages/")
                     'APPEND)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)


(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;(package-initialize)

 ;; (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
 ;;                     (not (gnutls-available-p))))
 ;;  (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
 ;;  (add-to-list 'package-archives (cons "melpa" url) t)
;;(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
;;  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line
;; (defvar mswindows-p (string-match "windows" (symbol-name system-type)))

;; (require 'omnisharp)
;; (add-hook 'csharp-mode-hook 'omnisharp-mode)
;; ;(setq omnisharp-server-executable-path  "/Users/nstares/omnisharp-server/OmniSharp/bin/Debug/OmniSharp.exe")
;; (require 'helm-config)
;; (require 'company)
;; (eval-after-load
;;  'company
;;  '(add-to-list 'company-backends 'company-omnisharp))
(require 'parinfer)
;; (define-key paredit-mode-map (kbd "M-)") 'paredit-forward-slurp-sexp)
(define-key parinfer-mode-map (kbd "C-a") 'back-to-indentation)
(define-key parinfer-mode-map (kbd "M-m") 'move-beginning-of-line)
;; (define-key paredit-mode-map (kbd "C-k") 'kill-line)
;; (define-key parinfer-mod-map (kbd "C-'") 'align-cljlet)

;; (setq parinfer extensions '(defaults paredit smart-yank smart-tab))


;; (require 'paredit)
;; (let ((paredit-modes '(clojure
;;                        javascript
;;                        emacs-lisp
;;                        lisp
;;                        lisp-interaction
;;                        scheme)))
;;   (dolist (mode paredit-modes)
;;     (add-hook (intern (concat (symbol-name mode) "-mode-hook"))
;;         (lambda () (paredit-mode +1)))))


;; SHOW TIME AT BOTTOM RIGHT
;; (display-time)
;; (setq global-mode-string (remove 'display-time-string)
;;       global-mode-string)
;; (setq mode-line-end-spaces (list (propertize " "))
;;       'display '(space :align-to (- right 17))
;;       'display-time-string)



(global-set-key (kbd "C-x C-.") 'parinfer-toggle-mode)


(projectile-mode)




;; (require 'flx-ido)
(ido-mode 1)
;; (ido-everywhere 0)
; (flx-ido-mode 1)
(show-paren-mode 1)
(projectile-global-mode)

(set-scroll-bar-mode nil)
(tool-bar-mode -1)
(define-key global-map [menu-bar words] t)
(setq ring-bell-function 'ignore)
(exec-path-from-shell-initialize)
(setq inhibit-startup-message t)

;; (require 'magit-gh-pulls)
;; (add-hook 'magit-mode-hook 'turn-on-magit-gh-pulls)






(global-set-key (kbd "C-x C-f") 'ido-find-file)

(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x b") 'ido-switch-buffer)
(global-set-key (kbd "C-x C-m") 'smex)
;g(global-unset-key (kbd "C-x m"))
(global-set-key (kbd "C-x m") 'smex)
(global-set-key (kbd "M-x") 'smex)

(setq parinfer-extensions '(defaults pretty-parens))



;; (global-unset-key (kbd "C-x C-r"))
;; (global-set-key (kbd "C-x C-r") 'helm-recentf)
;; (global-set-key (kbd "M-x") 'helm-M-x)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)


;; (global-set-key (kbd "C-x C-b") 'helm-buffers-list)

;; (global-set-key (kbd "C-x b") 'helm-buffers-list)
;; (global-set-key (kbd "C-x b") 'helm-buffers-list)


;; (global-set-key (kbd "C-x C-m") 'helm-M-x)

;; (global-unset-key (kbd "C-x C-r"))
;; (global-unset-key (kbd "C-x C-r") )
;; (global-unset-key (kbd "M-x") )
;; (global-unset-key (kbd "C-x C-f") )
;; (global-unset-key (kbd "C-x C-b") )
;; (global-unset-key (kbd "C-x b") )
;; (global-unset-key (kbd "C-x C-m") )
;; (global-unset-key (kbd "C-x m") )




(global-set-key (kbd "C-c c") 'org-capture)

;; (setq org-capture-templates '(("t" "Todo [inbox]" entry))
;;              (file+headline "~/gtd/inbox.org" "Tasks")
;;              "* TODO %i%?"
;;             ("T" "Tickler" entry
;;              (file+headline "~/gtd/tickler.org" "Tickler")
;;              "* %i%? \n %U"))

;; (setq org-refile-targets '(("~/gtd/gtd.org" :maxlevel . 3))
;;          ("~/gtd/someday.org" :level . 1)
;;          ("~/gtd/tickler.org" :maxlevel . 2))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(setq org-agenda-files
      (list "~/org/school.org" 
            "~/org/home.org"))
      
(setq visual-line-mode 1)
(setq org-log-done t)

;;(setq cider-cljs-lein-repl nil)
;; "(do (require 'figwheel-sidecar.repl-api)
;;      (figwheel-sidecar.repl-api/start-figwheel!)
;;      (figwheel-sidecar.repl-api/cljs-repl))")
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
          ;(add-hook 'clojure-mode-hook 'parinfer-mode)


(require 'dired)

(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file) ; was dired-advertised-find-file

(define-key dired-mode-map (kbd "DEL") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory
(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory
(defun xah-dired-mode-setup ()
  "to be run as hook for `dired-mode'."
  (dired-hide-details-mode 1))


(add-hook 'dired-mode-hook 'xah-dired-mode-setup)
;; (defun cider-figwheel-repl ()
;;   (interactive)
;;   (save-some-buffers)
;;   (with-current-buffer (cider-current-repl-buffer)
;;     (goto-char (point-max))
;;     (insert "(require 'figwheel-sidecar.repl-api)
;;              (figwheel-sidecar.repl-api/start-figwheel!) ; idempotent
;;              (figwheel-sidecar.repl-api/cljs-repl)")
;;     (cider-repl-return)))

;; (global-set-key (kbd "C-c C-f") #'cider-figwheel-repl)



;; (defun load-directory (directory)
;;   "Load recursively all `.el' files in DIRECTORY."
;;   (dolist (element (directory-files-and-attributes directory nil nil nil))
;;     (let* ((path (car element))
;;            (fullpath (concat directory "/" path))
;;            (isdir (car (cdr element)))
;;            (ignore-dir (or (string= path ".") (string= path ".."))))
;;       (cond
;;        ((and (eq isdir t) (not ignore-dir))
;;         (load-directory fullpath))
;;        ((and (eq isdir nil) (string= (substring path -3) ".el"))
;;         (load (file-name-sans-extension fullpath)))))))
;; (load-directory "~/.emacs.d/config")




(load-theme 'leuven t)
;; (when mswindows-p
;;   (set-face-attribute 'default nil
;; 		      :family "Consolas" :height 100))

;; (set-scroll-bar-mode nil)
;; (tool-bar-mode -1)

(global-set-key (kbd "C-k") 'kill-line)
(global-set-key (kbd "C-r") 'isearch-backward)
(global-set-key (kbd "C--") 'undo)


;; AVY

(global-set-key (kbd "M-g e") 'avy-goto-word-0)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)
(global-set-key (kbd "M-g f") 'avy-goto-line)


;; Easy magit status
;(define-prefix-command 'magit-map)
;(global-set-key (kbd "C-x m ") 'magit-map)
;(global-set-key (kbd "C-x m s") 'magit-status)

(defun magit-publish ()
  (interactive)
  (when (yes-or-no-p "Publish this branch? ")
    (eshell-command
     (format "git push -u origin %s" (magit-get-current-branch)))))


(setq helm-split-window-inside-p t)

(setq ag-executable "C:/Users/nstares/Downloads/ag/ag.exe")

(global-set-key (kbd "C-c j") 'avy-goto-word-1)

(global-unset-key (kbd "C-x o"))
(global-set-key (kbd "C-x o") 'ace-window)
(global-set-key (kbd "C-x C-o") 'ace-window)

(avy-setup-default)

;; TIM LICATA's C-w
;; C-w.
;; Chromebook has no delete key so I can't M-DEL to kill the previous
;; word. Bash uses C-w to cut up to the last space, so why not do
;; that. Only problem: C-w kills the active region by default, so
;; keep that functionality.
;; (defun unix-werase-or-kill (arg)
;;   (interactive "*p")
;;   (if (use-region-p)
;;       (kill-region (region-beginning) (region-end))
;;     (if (eq (key-binding (kbd "M-DEL")) 'paredit-backward-kill-word)))
;;   (paredit-backward-kill-word
;;       (backward-kill-word arg)))
;; (global-set-key (kbd "C-w") 'unix-werase-or-kill)
;; ;; Use C-w in ido minibuffers too.
;; (add-hook 'ido-setup-hook
;;     (lambda ()
;;       (define-key ido-file-completion-map "\C-w" 'ido-delete-backward-word-updir)))

(global-set-key (kbd "C-w") 'kill-region)

(setq evil-escape-mode 1)

(defun evil-keyboard-quit ()
  "Keyboard quit and force normal state."
  (interactive)
  (and evil-mode (evil-force-normal-state))
  (keyboard-quit))
(setq evil-want-C-u-scroll t)
(global-set-key (kbd "C-e") 'end-of-visual-line)
;; (define-key evil-normal-state-map   (kbd "C-g") #'evil-keyboard-quit) 
; ;uevil-window-map         (kbd "C-g") #'evil-keyboard-quit) 
;; (define-key evil-operator-state-map (kbd "C-g") #'evil-keyboard-quit) 
;; (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(setq evil-escape-key-sequence "kj")
(global-unset-key (kbd "C-z"))
;; (define-key evil-normal-state-map (kbd "0") 'back-to-indentation)
(setq default-cursor-type 'bar)

(global-set-key "\C-x2" (lambda () (interactive)(split-window-vertically) (other-window 1)))
(global-set-key "\C-x3" (lambda () (interactive)(split-window-horizontally) (other-window 1)))
;; (add-hook 'emacs-lisp-mode-hook #'evil-lispy-mode)
;; (add-hook 'clojure-mode-hook #'evil-lispy-mode)
;; (dolist (mode '(cider-repl-mode))
;;  (add-to-list 'evil-emacs-state-modes mode))

(defvar my-leader-map (make-sparse-keymap))

;; (define-key evil-normal-state-map (kbd "SPC SPC") 'smex)   
;; (define-key evil-normal-state-map (kbd "SPC e") 'cider-eval-last-sexp)   

(global-set-key (kbd "M-[") 'backward-paragraph)
(global-set-key (kbd "M-]") 'forward-paragraph)
(global-set-key (kbd "<f2>") 'cider-eval-last-sexp)
(global-set-key (kbd "<f3>") 'cider-eval-defun-at-point)



(set-face-attribute 'default nil :font "Menlo-15")
;;(set-frame-font "Menlo-14.5" nil t)


(setq evil-move-cursor-back t)


(defadvice cider-last-sexp (around evil activate)
    "In normal-state or motion-state, last sexp ends at point."
    (if (or (evil-normal-state-p) (evil-motion-state-p))
        (save-excursion
          (unless (or (eobp) (eolp)) (forward-char))
          ad-do-it)
      ad-do-it))


;; (ivy-mode 1)
;; (setq ivy-use-virtual-buffers t)
;; (setq ivy-count-format "(%d/%d) ")


(global-set-key (kbd "C-s") 'swiper)
;; (global-set-key (kbd "M-x") 'counsel-M-x)
;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
;; (global-set-key (kbd "<f1> f") 'counsel-describe-function)
;; (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;; (global-set-key (kbd "<f1> l") 'counsel-find-library)
;; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)










(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(byte-compile-delete-errors t)
 '(cider-auto-select-error-buffer nil)
 '(cider-debug-use-overlays t)
 '(cider-use-overlays t)
 '(compilation-message-face (quote default))
 '(fci-rule-color "#3C3D37")
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
 '(magit-diff-use-overlays nil)
 '(org-agenda-files (quote ("~/org/school.org" "~/org/home.org")))
 '(package-selected-packages
   (quote
    (align-cljlet clj-refactor el-get ranger runner 4clojure flx-ido which-key with-editor counsel evil-escape helm-clojuredocs clojure-cheatsheet synosaurus sx org-pomodoro evil-lispy clojure-mode cider lispy parinfer ace-window key-chord magit-gh-pulls achievements avy helm-ag-r ag org org-jira helm-projectile projectile magit company helm-ag omnisharp helm monokai-theme)))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
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
 '(avy-lead-face-0 ((t (:background "#4f57f9" :foreground "white" :height 1.3)))))
(put 'dired-find-alternate-file 'disabled nil)
