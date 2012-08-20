;;; ロードパス
;; ロードパスの追加
(setq load-path (append
                 '("~/.emacs.d"
                   "~/.emacs.d/packages")
                 load-path))

;;; 日本語環境
;; Localeに合わせた環境の設定
(set-locale-environment nil)

;;日本語環境:UTF-8
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)


;;; キーバインド
;; 基本
(define-key global-map (kbd "C-h") 'delete-backward-char) ; 削除
(define-key global-map (kbd "M-?") 'help-for-help)        ; ヘルプ
(define-key global-map (kbd "C-z") 'undo)                 ; undo
(define-key global-map (kbd "C-c i") 'indent-region)      ; インデント
(define-key global-map (kbd "C-c C-i") 'hippie-expand)    ; 補完
(define-key global-map (kbd "C-c ;") 'comment-dwim)       ; コメントアウト
(define-key global-map (kbd "M-C-g") 'grep)               ; grep
(define-key global-map (kbd "C-[ M-C-g") 'goto-line)      ; 指定行へ移動
(define-key global-map (kbd "M-I") 'indent-region)

;; ウィンドウ移動
;; 2011-02-17
(define-key global-map (kbd "C-M-n") 'next-multiframe-window)
(define-key global-map (kbd "C-M-p") 'previous-multiframe-window)

;;; grep
;; 再帰的にgrep
;; 2011-02-18
(require 'grep)
(setq grep-command-before-query "grep -nH -r -e ")
(defun grep-default-command ()
  (if current-prefix-arg
      (let ((grep-command-before-target
             (concat grep-command-before-query
                     (shell-quote-argument (grep-tag-default)))))
        (cons (if buffer-file-name
                  (concat grep-command-before-target
                          " *."
                          (file-name-extension buffer-file-name))
                (concat grep-command-before-target " ."))
              (+ (length grep-command-before-target) 1)))
    (car grep-command)))
(setq grep-command (cons (concat grep-command-before-query " .")

;;; バー
;; メニューバーを消す
(menu-bar-mode -1)
;; ツールバーを消す
(tool-bar-mode -1)


;;; カーソル
;; カーソルの点滅を止める
(blink-cursor-mode 0)


;;; 括弧
;; 対応する括弧を光らせる。
(show-paren-mode 1)
;; ウィンドウ内に収まらないときだけ括弧内も光らせる。
(setq show-paren-style 'mixed)


;; 行末の空白を表示
(setq-default show-trailing-whitespace t)



;; 現在行を目立たせる(文字が崩れるのでオフにしてる)
;(global-hl-line-mode)

;; カーソルの位置が何文字目かを表示する
(column-number-mode t)

;; カーソルの位置が何行目かを表示する
(line-number-mode t)

;; カーソルの場所を保存する
(require 'saveplace)
(setq-default save-place t)


;;; 行
;; 行の先頭でC-kを一回押すだけで行全体を消去する
(setq kill-whole-line t)
;; 最終行に必ず一行挿入する
(setq require-final-newline t)
;; バッファの最後でnewlineで新規行を追加するのを禁止する
(setq next-line-add-newlines nil)


;;; バックアップ
;; バックアップファイルを作らない

;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)


;;; 補完
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
;; 部分一致の補完機能を使う
;; p-bでprint-bufferとか
(partial-completion-mode t)
;; 補完可能なものを随時表示
;; 少しうるさい
(icomplete-mode 1)


;;; 履歴
;; 履歴数を大きくする
(setq history-length 10000)
;; ミニバッファの履歴を保存する
(savehist-mode 1)
;; 最近開いたファイルを保存する数を増やす
(setq recentf-max-saved-items 10000)

;; ediffを1ウィンドウで実行
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;; diffのオプション
(setq diff-switches '("-u" "-p" "-N"))

;; diredを便利にする
(require 'dired-x)
;; diredから"r"でファイル名をインライン編集する
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;;; バッファ名
;; ファイル名が重複していたらディレクトリ名を追加する。
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;;; リージョンの大文字小文字変換を有効にする。
;; C-x C-u -> upcase
;; C-x C-l -> downcase
;; 2011-03-09
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; デフォルトのタブ
(setq default-tab-width 4)


;;; 追加の設定
(load "config/builtins")
;; 非標準Elispの設定
(load "config/packages")

(put 'set-goal-column 'disabled nil)

