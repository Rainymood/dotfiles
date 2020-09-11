;; -*- mode: elisp -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MELPA 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)

;; Add melpa package source when using package list
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

;; Load emacs packages and activate them
;; This must come before configurations of installed packages
;; Don't delete this line
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Disable files ending in ~ 
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;; Change default tab with to 4 spaces 
(setq default-tab-width 4)

;; Disable the scroll bar 
(scroll-bar-mode -1)

;; Disables tool bar 
(tool-bar-mode -1)

;; Disable the splash screen (to enable, replace the t with 0)
(setq inhibit-splash-screen t)

;; Enable transient mark mode (should be enabled by default)
(transient-mark-mode 1)

;; Bind =C-x v= to open ~/.emacs
(global-set-key (kbd "\C-xv") (lambda () (interactive)
  (find-file "~/.emacs")
  (message "Opened:  %s" (buffer-name))))

;; Enables this: 
;; * Top level headline             |    * Top level headline
;; ** Second level                  |      * Second level
;; *** 3rd level                    |        * 3rd level
(add-hook 'org-mode-hook 'org-indent-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org mode 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Enable org-mode
(require 'org)

;; Log tasks that are done with a timestamp 
(setq org-log-done t)

;; The following lines are always needed.  Choose your own keys.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-switchb)
(global-set-key "\C-cc" 'org-capture)

;; Legend:
;; - %U :: Inactive timestamp
;; - %? :: Cursor ends up here 
(setq org-capture-templates '(("j" "Journal (personal) entry" entry
                               (file+olp+datetree "~/Dropbox/org/notes2.org" "Journal")
                               "* Journal entry on %U\n%?"
			       )
			      ("i" "Inbox entry" entry
                               (file+olp+datetree "~/Dropbox/org/notes2.org" "Inbox")
                               "**** %?"
			       )
			      ("w" "Work entry" entry
			       (file+datetree "~/Dropbox/org/notes2.org" "Work")
			       "* %?"
			       )
			      ("s" "Someday" entry
			       (file+datetree "~/Dropbox/org/someday.org")
			       "**** %U\n%?")
			      ("n" "Network" entry
			       (file+olp+datetree "~/Dropbox/org/notes2.org" "Network")
			       "**** %U\n%?"
			       )
			      ("1" "Project 1: Aha" entry
			       (file+datetree "~/Dropbox/org/project_1_aha.org")
			       "**** %U\n%?")
			      ("r" "Reference" entry
			       (file+olp+datetree "~/Dropbox/org/notes2.org" "Reference")
			       "**** %?"
			       )
			      ("b" "Brag" entry
			       (file+olp+datetree "~/Dropbox/org/notes2.org" "Brag")
			       "**** %?"
			       )
			      ))

			   ;;   ("1" "[1] Project: Aha!" entry
			   ;;    (file+datetree "~/Dropbox/org/PROJ_001_Aha.org")

;; Begin in insert mode after org-capture 
(add-hook 'org-capture-mode-hook 'evil-insert-state)

;; Set TODO keywords to TODO WAITING DONE CANCELLED (works for me) 
(setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

;; Call with C-c $ shortcut 
(setq org-archive-location (concat "~/Documents/Reference/org/archive/" (format-time-string "%Y-%m") ".org::"))

;; Save all buffers after archiving location 
(advice-add 'org-archive-location :after #'org-save-all-org-buffers)
(advice-add 'save-buffer :after #'org-save-all-org-buffers)

;; Allow multiline emphasis/bold
(setcar (nthcdr 2 org-emphasis-regexp-components) " \t\r\n,\"")

;; Set note after clocking out 
(setq org-log-note-clock-out t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEPRECATED org-mode settings 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(setq org-archive-location (concat "archive/archive-"
;;                                   (format-time-string "%Y%m" (current-time))
;;                                   ".org_archive::"))

;; https://emacs.cafe/emacs/orgmode/gtd/2017/06/30/orgmode-gtd.html

;;(setq org-archive-location (concat "~/gtd/archive/" (format-time-string "%Y-%m") ".org::"))
;;(setq org-agenda-files '("~/gtd/inbox.org"
;;                         "~/gtd/gtd.org"
;;                         "~/gtd/tickler.org"))

;; I press C-c c t to add an entry to my inbox,
;; and C-c c T to add an entry to the tickler (more on that later).
;;(setq org-capture-templates '(("t" "Todo [inbox]" entry
;;                               (file+headline "~/gtd/inbox.org" "Tasks")
;;                               "* TODO %i%?")
;;                              ("T" "Tickler" entry
;;                               (file+headline "~/gtd/tickler.org" "Tickler")
;;                               "* %i%? \n %U")))
;;
;;(setq org-refile-targets '(("~/gtd/gtd.org" :maxlevel . 3)
;;                           ("~/gtd/someday.org" :level . 1)
;;                           ("~/gtd/tickler.org" :maxlevel . 2)
;;			   ("~/gtd/notes.org" :maxlevel . 2)))


;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen
;; (setq org-agenda-files '("~/org/agenda/"))

;; Add these files to the agenda 
;;(setq org-agenda-files '("~/gtd/inbox.org"
;;                         "~/gtd/gtd.org"
;;                         "~/gtd/tickler.org"))

;; I press C-c c t to add an entry to my inbox,
;; and C-c c T to add an entry to the tickler (more on that later).
;;(setq org-capture-templates '(("t" "Todo [inbox]" entry
;;                               (file+headline "~/gtd/inbox.org" "Tasks")
;;                               "* TODO %i%?")
;;                              ("T" "Tickler" entry
;;                               (file+headline "~/gtd/tickler.org" "Tickler")
;;                               "* %i%? \n %U")))

;; %U timestamp
;; %? Cursor ends up here
;;(setq org-capture-templates '(("j" "Journal (personal) entry" entry
;;                               (file+datetree "~/Dropbox/org/journal.org")
;;                               "**** %U\n%?")
;;			      ("l" "Log (work) entry" entry
;;			       (file+datetree "~/Dropbox/org/log.org")
;;			       "**** %U\n%?")
;;			      ("s" "Someday" entry
;;			       (file+datetree "~/Dropbox/org/someday.org")
;;			       "**** %U\n%?")
;;			      ("n" "Network" entry
;;			       (file+datetree "~/Dropbox/org/network.org")
;;			       "**** %U\n%?")
;;			      ("1" "Project 1: Aha" entry
;;			       (file+datetree "~/Dropbox/org/project_1_aha.org")
;;			       "**** %U\n%?")
;;			      ("r" "Reference" entry
;;			       (file+datetree "~/Dropbox/org/reference.org")
;;			       "**** %U\n%?")))

			   ;;   ("1" "[1] Project: Aha!" entry
			   ;;    (file+datetree "~/Dropbox/org/PROJ_001_Aha.org")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Evil mode 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Enable Evil mode 
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

;; Makes C-u scroll up (see: https://stackoverflow.com/questions/14302171/ctrlu-in-emacs-when-using-evil-key-bindings)
(setq evil-want-C-u-scroll t)

;; Enable KeyChords
(add-to-list 'load-path "~/.emacs.d/key-chord")
(require 'key-chord)
(key-chord-mode 1)

;; Binds =S-j S-j= to swap to previous buffer 
(defun switch-to-previous-buffer ()
  "Switch to previously open buffer. Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))
(key-chord-define-global "JJ" 'switch-to-previous-buffer)

;; Binds =kj= to =Esc= using KeyChords 
(key-chord-define evil-insert-state-map "kj" 'evil-normal-state)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(fci-rule-color "#eee8d5")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(hl-bg-colors
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(hl-paren-colors (quote ("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900")))
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(org-agenda-files
   (quote
    ("~/Dropbox/org/notes.org" "~/Dropbox/org/notes2.org")))
 '(package-selected-packages
   (quote
    (ecb treemacs-icons-dired treemacs-magit markdown-mode yasnippet minimap tabbar org-bullets htmlize evil-easymotion projectile auctex-latexmk latex-math-preview spaceline spacemacs-theme auctex solarized-theme)))
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(tabbar-separator (quote (0.5)))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c9485ddd1797")
     (60 . "#bf7e73b30bcb")
     (80 . "#b58900")
     (100 . "#a5a58ee30000")
     (120 . "#9d9d91910000")
     (140 . "#9595943e0000")
     (160 . "#8d8d96eb0000")
     (180 . "#859900")
     (200 . "#67119c4632dd")
     (220 . "#57d79d9d4c4c")
     (240 . "#489d9ef365ba")
     (260 . "#3963a04a7f29")
     (280 . "#2aa198")
     (300 . "#288e98cbafe2")
     (320 . "#27c19460bb87")
     (340 . "#26f38ff5c72c")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496")))
 '(xterm-color-names
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642"])
 '(xterm-color-names-bright
   ["#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:background "#292B2E" :foreground "#2aa1ae" :slant normal)))))

;; Make evil paragraphs behave like vim paragraphs
;; See: https://emacs.stackexchange.com/questions/38596/make-evil-paragraphs-behave-like-vim-paragraphs
(with-eval-after-load 'evil
  (defadvice forward-evil-paragraph (around default-values activate)
    (let ((paragraph-start (default-value 'paragraph-start))
          (paragraph-separate (default-value 'paragraph-separate)))
      ad-do-it)))

;; Evil-easymotion, downloaded and added manually on 31-05-2019 
(add-to-list 'load-path "~/.emacs.d/lisp")
(load "evil-easymotion") ;; best not to include the ending “.el” or “.elc”
(evilem-default-keybindings "SPC")

;; Makes C-u scroll up (see: https://stackoverflow.com/questions/14302171/ctrlu-in-emacs-when-using-evil-key-bindings)
;; Just scroll down with C-b
;; (setq evil-want-C-u-scroll t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Neotree
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Install Neotree
(add-to-list 'load-path "~/.emacs.d/neotree")
(require 'neotree)

;; Bind =M-f8= to toggle neotree
(global-set-key [f8] 'neotree-toggle)

;; changes neotree's theme (i.e. arrows) 
(setq neo-theme 'arrow)

;; Conflicting keybinds Neotree + Evil mode 

;; TAB :: enter
;; q :: hide
;; n :: next line
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
(evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
(evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)

;; Makes neotree resizeable
(setq neo-window-fixed-size nil)

;; Set neotree window width
;;(setq neo-window-width 20)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Theme 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; First install using M-x package-install RET use-package RET 
(require 'use-package)

;; Get that spacemacs powerline feel 
(use-package spaceline
  :demand t
  :init
  (setq powerline-default-separator 'nil)
  :config
  (require 'spaceline-config)
  (spaceline-spacemacs-theme))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Latex 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Adds stuff to my PATH (LaTeX, etc) 
(setq exec-path (append exec-path '("/Library/TeX/texbin")))

(setenv "PATH" "/usr/local/bin:/Library/TeX/texbin/:$PATH" t)
(setenv "PATH" (concat (getenv "PATH") ":/usr/texbin"))

;; Set the default LaTeX exec to pdfTeX
(setq TeX-PDF-mode t)

;; Load AucTeX!! :D <= unnecessary with auxtex
;;(load "auctex.el" nil t t) ;; loads tex-site in such a way so that it can be undone
;;(load "preview-latex.el" nil t t) ;; actual preview-latex

;; Sets the default PDF viewer to, well, the default PDF viewer.
(setq TeX-view-program-list '(("Shell Default" "open %o")))
(setq TeX-view-program-selection '((output-pdf "Shell Default")))

;; fontify code in code blocks
(setq org-src-fontify-natively t)

;; #292B2E
(setq org-latex-create-formula-image-program 'dvipng)

;; preview font scale  => doesnt work => customize face 
;;(set-default 'preview-scale-function 10)
;;https://emacs.stackexchange.com/questions/19880/font-size-control-of-latex-previews-in-org-files
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Projectile
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; projectile bindings 
(require 'projectile)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(projectile-mode +1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Using emacs 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; lesson 4 - buffers
(setq ido-enable-flex-matching t)
(setq ido-everywhere t) 
(ido-mode 1)

(defalias 'list-buffers 'ibuffer)
;; (defalias 'list-buffers 'ibuffer-other-window)

;; enables tabbar 
;; (use-package tabbar
;;   :ensure t
;;   :config
;;   (tabbar-mode 1))

;; Tabbar visual tweaks 
;; See: https://gist.github.com/3demax/1264635/91ccb6c423effd811dbdb1412b70c15e95fa700d

;; Tabbar
(require 'tabbar)
;; Tabbar settings
(set-face-attribute
 'tabbar-default nil
 :background "gray20"
 :foreground "gray20"

 :box '(:line-width 1 :color "gray20" :style nil))
(set-face-attribute
 'tabbar-unselected nil
 :background "gray30"
 :foreground "white"
 :box '(:line-width 5 :color "gray30" :style nil))
(set-face-attribute
 'tabbar-selected nil
 :background "gray75"
 :foreground "black"
 :box '(:line-width 5 :color "gray75" :style nil))
(set-face-attribute
 'tabbar-highlight nil
 :background "white"
 :foreground "black"
 :underline nil
 :box '(:line-width 5 :color "white" :style nil))
(set-face-attribute
 'tabbar-button nil
 :box '(:line-width 1 :color "gray20" :style nil))
(set-face-attribute
 'tabbar-separator nil
 :background "gray20"
 :height 0.6)

;; Change padding of the tabs
;; we also need to set separator to avoid overlapping tabs by highlighted tabs

;; adding spaces
(defun tabbar-buffer-tab-label (tab)
  "Return a label for TAB.
That is, a string used to represent it on the tab bar."
  (let ((label  (if tabbar--buffer-show-groups
                    (format "[%s]  " (tabbar-tab-tabset tab))
                  (format "%s  " (tabbar-tab-value tab)))))
    ;; Unless the tab bar auto scrolls to keep the selected tab
    ;; visible, shorten the tab label to keep as many tabs as possible
    ;; in the visible area of the tab bar.
    (if tabbar-auto-scroll-flag
        label
      (tabbar-shorten
       label (max 1 (/ (window-width)
                       (length (tabbar-view
                                (tabbar-current-tabset)))))))))

(defun my-tabbar-buffer-groups () ;; customize to show all normal files in one group
    "Returns the name of the tab group names the current buffer belongs to.
There are two groups: Emacs buffers (those whose name starts with '*', plus
dired buffers), and the rest.  This works at least with Emacs v24.2 using
tabbar.el v1.7."
    (list (cond ((string-equal "*" (substring (buffer-name) 0 1)) "emacs")
		((eq major-mode 'dired-mode) "emacs")
		(t "user"))))
(setq tabbar-buffer-groups-function 'my-tabbar-buffer-groups)

(tabbar-mode 0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; YASnippet (for code snippets) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
