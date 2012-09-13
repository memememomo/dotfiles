(require 'package)


;;;----------------------------------------------------------------------------------------------------
;;; Auto Complete
;; 自動補完
(package-install 'github "m2ym/auto-complete" 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
             (format "%s/auto-complete/dict" package-base-dir))
(ac-config-default)
(add-hook 'auto-complete-mode-hook
          (lambda ()
            (define-key ac-completing-map (kbd "C-n") 'ac-next)
            (define-key ac-completing-map (kbd "C-p") 'ac-previous)))

;;;----------------------------------------------------------------------------------------------------
;;; Anything
;; iswitchbの代わり
(let ((original-browse-url-browser-function browse-url-browser-function))
  (setq anything-command-map-prefix-key "C-c C-<SPC>")
  (package-install 'repo.or.cz '((files . ("anything-config"))
                                 (additional-paths . ("extensions")))
                   'anything-startup)
  (define-key global-map (kbd "C-x b") 'anything-for-files)
  (define-key anything-map (kbd "C-z") nil)
  (define-key anything-map (kbd "C-l") 'anything-execute-persistent-action)
  (define-key anything-map (kbd "C-o") nil)
  (define-key anything-map (kbd "C-M-n") 'anything-next-source)
  (define-key anything-map (kbd "C-M-p") 'anything-previous-source)
  (setq browse-url-browser-function original-browse-url-browser-function))


;;;----------------------------------------------------------------------------------------------------
;; perl-completion

(package-install 'emacswiki "perl-completion.el" 'perl-completion)
(when (require 'perl-completion nil t)
  (global-set-key (kbd "C-M-d") 'plcmp-cmd-show-doc)
  (global-set-key (kbd "C-M-p") 'plcmp-cmd-show-doc-at-point))

;;;----------------------------------------------------------------------------------------------------
;; php-completion

(package-install 'emacswiki "php-completion.el" 'php-completion)
(add-hook 'php-mode-hook
         (lambda ()
             (require 'php-completion)
             (php-completion-mode t)
             (define-key php-mode-map (kbd "C-o") 'phpcmp-complete)
             (when (require 'auto-complete nil t)
             (make-variable-buffer-local 'ac-sources)
             (add-to-list 'ac-sources 'ac-source-php-completion)
             (auto-complete-mode t))))



;;;----------------------------------------------------------------------------------------------------
;;; perl-mode

;; 参考 http://tech.lampetty.net/tech/index.php/archives/384

(defalias 'perl-mode 'cperl-mode)
(setq cperl-indent-level 4)
(setq cperl-continued-statement-offset 4)
(setq cperl-close-paren-offset -4)
(setq cperl-label-offset -4)
(setq cperl-comment-column 40)
(setq cperl-highlight-variables-indiscriminately t)
(setq cperl-indent-parens-as-block t)
(setq cperl-tab-always-indent nil)
;(setq cperl-electric-parens t) ; 対応する括弧自動挿入 うざい
;(setq cperl-invalid-face nil)

(setq cperl-indent-level 4
      cperl-continued-statement-offset 4
      cperl-close-paren-offset -4
      cperl-label-offset -4
      cperl-comment-column 40
      cperl-highlight-variables-indiscriminately t
      cperl-indent-parens-as-block t
      cperl-tab-always-indent nil
      cperl-font-lock t)

; steal from perlhacks
(global-set-key "\M-p" 'cperl-perldoc)

(add-hook 'cperl-mode-hook '(lambda ()
                              (setq indent-tabs-mode nil)
                              ; BestPractices からぱくったがなんかうごいてない
                              (setq fill-column 78)
                              (setq auto-fill-mode t)
                              ; face設定。これはどっかちがうとこにうつす
                              (set-face-background 'cperl-hash-face (face-background 'default))
                              (setq cperl-hash-face 'cperl-hash-face)
                              ;(make-face 'cperl-array-face)
                              ;(set-face-foreground 'cperl-array-face "color-69")
                              (set-face-background 'cperl-array-face (face-background 'default))
                              (setq cperl-array-face 'cperl-array-face)
                              ))

(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))
(global-set-key "%" 'match-paren)


(add-hook  'cperl-mode-hook (lambda ()
                              (require 'auto-complete)
                              (require 'perl-completion)
                              (add-to-list 'ac-sources 'ac-source-perl-completion)
                              (perl-completion-mode t)))

(add-to-list 'auto-mode-alist '("\\.t$" . perl-mode))


;;;----------------------------------------------------------------------------------------------------
;;; CSS Mode

(autoload 'css-mode "css-mode")
(setq auto-mode-alist
      (cons '("\\.css\\'" . css-mode) auto-mode-alist))
(setq cssm-indent-function #'cssm-c-style-indenter)



;;;----------------------------------------------------------------------------------------------------
;;; javascript Mode

(add-to-list 'auto-mode-alist (cons "\\.js\\'" 'javascript-mode))
(autoload 'javascript-mode "javascript" nil t)
(setq js-indent-level 4)


;;;----------------------------------------------------------------------------------------------------
;;; coffeescript Mode

(add-to-list 'load-path "~/.emacs.d/packages/coffee-mode")
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
(setq whitespace-action '(auto-cleanup)) ;; automatically clean up bad whitespace
(setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab)) ;; only show bad whitespace


;;;----------------------------------------------------------------------------------------------------
;;; ruby

(package-install 'github "nonsequitur/inf-ruby" 'inf-ruby)


;;;----------------------------------------------------------------------------------------------------
;;; rails

(package-install 'github "eschulte/rinari" 'ido)
(ido-mode t)
(require 'rinari)


;;;----------------------------------------------------------------------------------------------------
;;; rhtml-mode

(package-install 'github "eschulte/rhtml" 'rhtml-mode)
(add-hook 'rhtml-mode-hook
   (lambda () (rinari-launch)))


;;;----------------------------------------------------------------------------------------------------
;;; haskell-mode

(add-to-list 'load-path "~/.emacs.d/packages/haskell-mode")
(require 'haskell-mode)
(require 'haskell-cabal)
(setq auto-mode-alist (cons '("\\.hs$" . haskell-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.lhs$" . haskell-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cabal$" . haskell-mode) auto-mode-alist))



;;;----------------------------------------------------------------------------------------------------
;;; php-mode

(autoload 'php-mode "php-mode")
(setq auto-mode-alist
      (cons '("\\.php\\'" . php-mode) auto-mode-alist))
(setq php-mode-force-pear t)
(add-hook 'php-mode-user-hook
  '(lambda ()
     (setq indent-tabs-mode nil)
	 (setq tab-width 4
		   c-basic-offset 4
		   c-hanging-comment-ender-p nil)
	 (setq php-mode-force-pear t)
     (setq php-manual-path "/home/admin2/doc/php")
     (setq php-manual-url "http://www.phppro.jp/phpmanual/")))


(require 'sr-speedbar)
(setq sr-speedbar-right-side nil)


;;----------------------------------------------------------------------------------------------------
;; perldoc -m を開く

;; モジュールソースバッファの場合はその場で、
;; その他のバッファの場合は別ウィンドウに開く。
(put 'perl-module-thing 'end-op
     (lambda ()
       (re-search-forward "\\=[a-zA-Z][a-zA-Z0-9_:]*" nil t)))
(put 'perl-module-thing 'beginning-op
     (lambda ()
       (if (re-search-backward "[^a-zA-Z0-9_:]" nil t)
           (forward-char)
         (goto-char (point-min)))))

(defun perldoc-m ()
  (interactive)
  (let ((module (thing-at-point 'perl-module-thing))
        (pop-up-windows t)
        (cperl-mode-hook nil))
    (when (string= module "")
      (setq module (read-string "Module Name: ")))
    (let ((result (substring (shell-command-to-string (concat "perldoc -m " module)) 0 -1))
          (buffer (get-buffer-create (concat "*Perl " module "*")))
          (pop-or-set-flag (string-match "*Perl " (buffer-name))))
      (if (string-match "No module found for" result)
          (message "%s" result)
        (progn
          (with-current-buffer buffer
            (toggle-read-only -1)
            (erase-buffer)
            (insert result)
            (goto-char (point-min))
            (cperl-mode)
            (toggle-read-only 1)
            )
          (if pop-or-set-flag
              (switch-to-buffer buffer)
            (display-buffer buffer)))))))

(global-set-key (kbd "C-M-m") 'perldoc-m)


;;----------------------------------------------------------------------------------------------------
;; zencoding-mode

(require 'zencoding-mode)
(add-hook 'html-mode-hook 'zencoding-mode) ;; html-modeとかで自動出来にzencodingできるようにする
(define-key zencoding-mode-keymap (kbd "C-c C-m") 'zencoding-expand-line)
(define-key zencoding-preview-keymap (kbd "C-c C-m") 'zencoding-preview-accept)


;;----------------------------------------------------------------------------------------------------
;; yasnippet

(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/Dropbox/emacs/yasnipet/snippets")


;;----------------------------------------------------------------------------------------------------
;; howm

(setq load-path (append
		 '("~/.emacs.d/packages/howm")
		 load-path))
(setq howm-directory "~/Dropbox/emacs/howm")
(setq howm-menu-lang 'ja)
(setq howm-file-name-format "%Y/%m/%Y-%m-%d.howm")
(when (require 'howm-mode nil t)
  (define-key global-map (kbd "C-c ,,") 'howm-menu))

(defun howm-save-buffer-and-kill ()
  "howmメモを保存と同時に閉じます。"
  (interactive)
  (when (and (buffer-file-name)
	     (string-match "\\.howm" (buffer-file-name)))
    (save-buffer)
    (kill-buffer nil)))
(define-key howm-mode-map (kbd "C-c C-c") 'howm-save-buffer-and-kill)


;;----------------------------------------------------------------------------------------------------
;; open-junk-file

(package-install 'emacswiki "open-junk-file.el" 'open-junk-file)
(global-set-key (kbd "C-c C-j") 'open-junk-file)


;;----------------------------------------------------------------------------------------------------
;; lispxmp

(package-install 'emacswiki "lispxmp.el" 'lispxmp)
(define-key emacs-lisp-mode-map (kbd "C-c C-d") 'lispxmp)


;;----------------------------------------------------------------------------------------------------
;; paredit

(require 'paredit)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)



;;----------------------------------------------------------------------------------------------------
;; iiimage

(auto-image-file-mode t)
(require 'iimage)


;;----------------------------------------------------------------------------------------------------
;; quickrun

(require 'quickrun)

