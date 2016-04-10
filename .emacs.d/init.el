;; M-x eval-buffer または load-fileで更新


;;; 文字コードmoji code
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
;(setq default-buffer-file-coding-system 'utf-8) ;; 23.2 で廃止されたらしい
(setq buffer-file-coding-system 'utf-8) ;; 上の代わりにこっち


;;Ctrl+h で backspace
(global-set-key "\C-h" 'delete-backward-char)

;; 全角スペースを半角にする
(global-set-key "　" (lambda () (interactive) (insert " ")))

;;;スタート画面を消す
(setq inhibit-startup-screen t)


;;;メニュー、ツール,スクロールバーを消す
(menu-bar-mode 0)
;(tool-bar-mode 0)
;(scroll-bar-mode 0)

;;; (yes/no) を (y/n)に
(fset 'yes-or-no-p 'y-or-n-p)

;;; 対応する括弧を強調する
(show-paren-mode 1)

;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)

;;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

;;; 行番号の表示
(global-linum-mode t)

;; jaunte.el , Hit a Hint
(add-to-list 'load-path "~/.emacs.d/jaunte")
(require 'jaunte)
(global-set-key (kbd "C-c C-j") 'jaunte)



;; auto-install
(add-to-list 'load-path "~/.emacs.d/auto-install")
(require 'auto-install)



;; gnuplot-mode
(add-to-list 'load-path "~/.emacs.d/gnuplot-mode")
(require 'gnuplot-mode)
(setq gnuplot-program "/usr/bin/gnuplot")
(setq auto-mode-alist
      (append '(("\\.\\(plt\\|gpl\\)$" . gnuplot-mode)) auto-mode-alist))


;; haskell-mode
(add-to-list 'load-path "~/.emacs.d/haskell-mode-2.8.0")
(require 'haskell-mode)
(autoload 'haskell-mode  "haskell-mode"  nil t)
(autoload 'haskell-cabal "haskell-cabal" nil t)
(add-to-list 'auto-mode-alist '("\\.hs$"    . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$"   . literate-haskell-mode))
(add-to-list 'auto-mode-alist '("\\.cabal$" . haskell-cabal-mode))
(add-to-list 'auto-mode-alist '("runghc"     . haskell-mode))
(add-to-list 'auto-mode-alist '("runhaskell" . haskell-mode))
(require 'haskell-ghci)
(require 'inf-haskell)
(setq haskell-program-name
      "/cygdrive/c/Program Files/Haskell Platform/7.10.2-a/bin/ghci")
(add-hook 'haskell-mode-hook 'inf-haskell-mode) ;; enable
(defadvice inferior-haskell-load-file (after change-focus-after-load)
  "Change focus to GHCi window after C-c C-l command"
  (other-window 1))
(ad-activate 'inferior-haskell-load-file)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; relative-number ;top
;; http://stackoverflow.com/questions/6874516/relative-line-numbers-in-emacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar my-linum-format-string "%3d")
(add-hook 'linum-before-numbering-hook 'my-linum-get-format-string)
(defun my-linum-get-format-string ()
  (let* ((width (1+ (length (number-to-string
                             (count-lines (point-min) (point-max))))))
         (format (concat "%" (number-to-string width) "d")))
    (setq my-linum-format-string format)))
(defvar my-linum-current-line-number 0)
(setq linum-format 'my-linum-relative-line-numbers)
(defun my-linum-relative-line-numbers (line-number)
  (let ((offset (- line-number my-linum-current-line-number)))
    (propertize (format my-linum-format-string offset) 'face 'linum)))
(defadvice linum-update (around my-linum-update)
  (let ((my-linum-current-line-number (line-number-at-pos)))
    ad-do-it))
(ad-activate 'linum-update)


;; Show tab, zenkaku-space, white spaces at end of line
;; http://www.bookshelf.jp/soft/meadow_26.html#SEC317
(defface my-face-tab         '((t (:underline t))) nil :group 'my-faces)
(defface my-face-zenkaku-spc '((t (:background "Yellow":underline t))) nil :group 'my-faces)
(defface my-face-spc-at-eol  '((t (:background "Red" :underline t))) nil :group 'my-faces)
(defvar my-face-tab         'my-face-tab)
(defvar my-face-zenkaku-spc 'my-face-zenkaku-spc)
(defvar my-face-spc-at-eol  'my-face-spc-at-eol)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("\t" 0 my-face-tab append)
     ("　" 0 my-face-zenkaku-spc append)
     ("[ \t]+$" 0 my-face-spc-at-eol append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
;; settings for text file
(add-hook 'text-mode-hook
	  '(lambda ()
	     (progn
	       (font-lock-mode t)
	       (font-lock-fontify-buffer)))
)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;         以下  古の記憶 いつか消す
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (add-to-list 'load-path "~/.emacs.d/elisp")
;; (add-to-list 'load-path "~/.emacs.d/elpa/")
;; (add-to-list 'load-path "~/.emacs.d/elpa/cl-lib-0.3")
;; (require 'cl-lib)




;; ;; make sure file is visible to emacs (if needed)
;; (add-to-list 'load-path "~/.emacs.d/gnuplot-mode-master")

;; ;; load the file
;; (require 'gnuplot-mode)

;; ;; specify the gnuplot executable (if other than /usr/bin/gnuplot)
;; (setq gnuplot-program "/usr/bin/gnuplot")

;; ;; automatically open files ending with .gp or .gnuplot in gnuplot mode
;; (setq auto-mode-alist
;;       (append '(("\\.\\(gp\\|gnuplot\\|plt\\)$" . gnuplot-mode)) auto-mode-alist))







;; ;; (global-hl-line-mode)

;; ;;;時刻の表示
;; (display-time)


;; ;;行、列号表示
;; (line-number-mode t)
;; (column-number-mode t)

;; ;; 背景を半透明にする ;;Ubuntu12.04では半透明にならない
;; (set-frame-parameter nil 'alpha 95)



;; ;;ジェネリックモード
;; (require 'generic-x)

;; (if (eq system-type 'cygwin) (load "~/.emacs.d/system-type/cygwin.el"))




;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; カラーテーマ ;top
;; (add-to-list 'load-path "~/.emacs.d/colortheme")
;; ;(load-theme 'manoj-dark t)
;; (require 'arjen-theme)
;; ;(require 'lawrence-theme)
;; ;(require 'lethe-theme)
;; ;; カラーテーマ ;bot
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; auto-complete;top
;; (require 'auto-complete-config)
;; (global-auto-complete-mode 1)
;; ;; auto-complete ;bot
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;; ;; ファイルに直接書き込まずにメモをする
;; (require 'ipa)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; google translate
;; (add-to-list 'load-path "~/.emacs.d/elpa/google-translate")
;; (require 'google-translate)
;; (global-set-key "\C-ct" 'google-translate-at-point)
;; (global-set-key "\C-cT" 'google-translate-query-translate)
;; ;; set default language
;; (custom-set-variables
;;    '(google-translate-default-source-language "en")
;;    '(google-translate-default-target-language "ja"))
;; ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;; org mode
;; (require 'org)
;; (setq org-use-fast-todo-selection t)
;; (setq org-todo-keywords
;;       '((sequence "TODO(t)" "STARTED(s)" "WAITNG(w)" "|" "DONE(x)" "CANCEL(c)")
;; 	(sequence "APPT(a)" "|" "DONE(x)" "CANCEL(c)")))



;; ;; Markdown mode
;; (require 'markdown-mode)
;; (autoload 'markdown-mode "markdown-mode"
;;   "Major mode for editing Markdown files" t)
;; (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


;; (require 'haskell-mode)
;; (autoload 'haskell-mode "haskell-mode" nil t)
;; (autoload 'haskell-cabal "haskell-cabal" nil t)

;; (add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
;; (add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
;; (add-to-list 'auto-mode-alist '("\\.cabal\\'" . haskell-cabal-mode))
;; ;; indent の有効.
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; (add-hook 'haskell-mode-hook 'font-lock-mode)
;; (add-hook 'haskell-mode-hook 'imenu-add-menubar-index)
