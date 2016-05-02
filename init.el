(require 'package)

;; (require 'origami)

;; yasnippet
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

(when (require 'yasnippet nil 'noerror)
  (progn
    (yas/load-directory "~/.emacs.d/snippets")))


;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (require 'package)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.org/packages/"))
  (package-refresh-contents)
  (package-initialize)
  (package-install 'el-get)
  (require 'el-get))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

;; multiple cursors
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)

;; delete whitespace until next word (b/c M-SPC is taken by OSX)
(global-set-key (kbd "S-SPC") 'just-one-space)

;; (menu-bar-mode -1) - removes emacs osx menu
(menu-bar-mode 1) ; normal emacs osx menu

;; -------Neotree----------
(add-to-list 'package-archives
  '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))

(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/"))

(add-to-list 'package-archives
  '("marmalade" . "http://marmalade-repo.org/packages/"))

;; Initialize all the ELPA packages (what is installed using the packages commands)
(package-initialize)

;; save backup files in .saves directory
;; http://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
(setq backup-directory-alist `(("." . "~/.saves")))

(setq backup-by-copying t) ;slow but best they say

;;; Get emacs to recognize installed themes
(require 'dash)
(require 's)

(-each
   (-map
      (lambda (item)
      (format "~/.emacs.d/elpa/%s" item))
   (-filter
      (lambda (item) (s-contains? "theme" item))
      (directory-files "~/.emacs.d/elpa/")))
   (lambda (item)
      (add-to-list 'custom-theme-load-path item)))

;; BASIC APPEARANCE, FUNDAMENTALS

;;; Remapping keys
;; ;;; I prefer cmd key for meta
;; (setq mac-option-key-is-meta nil
;;       mac-command-key-is-meta t
;;       mac-command-modifier 'meta
;;       mac-option-modifier 'none)


;; transpose frame
;;; COMMANDS:
;; ‘transpose-frame’ … Swap x-direction and y-direction
;; ‘flip-frame’ … Flip vertically
;; ‘flop-frame’ … Flop horizontally
;; ‘rotate-frame’ … Rotate 180 degrees
;; ‘rotate-frame-clockwise’ … Rotate 90 degrees clockwise
;; ‘rotate-frame-anti-clockwise’ … Rotate 90 degrees anti-clockwise


(require 'transpose-frame)


;; hide toolbar (except in Terminal)
;; hide toolbar in app (but not in terminal)
(if window-system
    (tool-bar-mode -1))

;; HIDESHOW mode CODE FOLDING ------------------------------
;; hs-minor-mode
;; (add-hook 'prog-mode-hook #'hs-minor-mode)

(global-set-key (kbd "<C-tab>") 'hs-toggle-hiding)
(global-set-key (kbd "<C-M-tab>") 'hs-show-all)
(global-set-key (kbd "<C-S-tab>") 'hs-hide-all)


;; PDF TOOLS' -----------------------------------------------
;;(pdf-tools-install)


;;````````````````````````````````````````````````````````````
;;             LINUM
;;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
;; linum mode line number column width
(setq linum-format 'dynamic)
;;(setq linum-format "%4d ")
;; lock linum mode font size
(eval-after-load "linum"
  '(set-face-attribute 'linum nil :height 80))
;; linum mode to it faster
(unless window-system
  (add-hook 'linum-before-numbering-hook
	    (lambda ()
	      (setq-local linum-format-fmt
			  (let ((w (length (number-to-string
					    (count-lines (point-min) (point-max))))))
			    (concat "%" (number-to-string w) "d"))))))

(defun linum-format-func (line)
  (concat
   (propertize (format linum-format-fmt line) 'face 'linum)
   (propertize " " 'face 'mode-line)))

(unless window-system
  (setq linum-format 'linum-format-func))
;;;;;;;;;;;;;;;
;; end linum !
;;;;;;;;;;;;;;;


;; NEOTREE ----------------------------------------------
(setq neo-theme 'ascii)
;; toggle tree
(global-set-key (kbd "M-n") 'neotree-toggle)
;; set the root directory 
(global-set-key (kbd "C-x n <return>") 'neotree-click-changes-root-toggle)
;; end neotree..............



;; pretty visual bell
(defun my-terminal-visible-bell ()
   "A friendlier visual bell effect."
   (invert-face 'mode-line)
   (run-with-timer 0.1 nil 'invert-face 'mode-line))
 
 (setq visible-bell nil
       ring-bell-function 'my-terminal-visible-bell)


;; Word wrap visual line mode by default
;;(setq line-mode-visual 1)
(setq-default word-wrap t)

;; adaptive-prefix-mode -- indents wrapped text
(when (fboundp 'adaptive-wrap-prefix-mode)
  (defun my-activate-adaptive-wrap-prefix-mode ()
    "Toggle `visual-line-mode' and `adaptive-wrap-prefix-mode' simultaneously."
    (adaptive-wrap-prefix-mode (if visual-line-mode 1 -1)))
  (add-hook 'visual-line-mode-hook 'my-activate-adaptive-wrap-prefix-mode))


;; Set fonts
(set-default-font "Monaco-11")
(setq visible-bell 1)

;; Column number mode
(column-number-mode 1)

;; Ace-Jump-Mode
(add-to-list 'load-path "/Users/mallorym/.emacs.d/elpa/")
(require 'ace-jump-mode) 
(define-key global-map (kbd "M-p") 'ace-jump-mode)

 
(require 'move-text)
(move-text-default-bindings)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


;; wind move  switch windows with shift-arrow
;; (windmove-default-keybindings)
(windmove-default-keybindings 's)
(global-set-key (kbd "s-<left>")  'windmove-left)
(global-set-key (kbd "s-<right>") 'windmove-right)
(global-set-key (kbd "s-<up>")    'windmove-up)
(global-set-key (kbd "s-<down>")  'windmove-down)

;; so emacs doesn't jumpt to centered line -> only helps C-n / C-p
;; (require 'smooth-scrolling)

;; require Common Lispinessess
(require 'cl)

;; Framemove package tie-in to windmove
(require 'framemove)
    (windmove-default-keybindings)
    (setq framemove-hook-into-windmove t)

;; Delay linum updates to give Emacs a chance for other changes
(setq linum-delay t)
(setq linum-format "%d ")
 
;; ;; Smart line mode
;; (sml/setup)


;; Tame the scrolling
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)

;; IDO mode true
(ido-mode t)

;; OSX Dictionary Mode
(global-set-key (kbd "C-c d") 'osx-dictionary-search-pointer)
(global-set-key (kbd "C-c i") 'osx-dictionary-search-input)



;; Show parenthesis mode
(show-paren-mode 1)
(require 'paren)
    (set-face-background 'show-paren-match (face-background 'default))
    (set-face-foreground 'show-paren-match "#def")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

;; ``````````````````````````````````````````````````
;; JAVASCRIPT
;; ..................................................
;; JS2 Mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; web-mode --  web-mode.org
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
    (setq web-mode-markup-indent-offset 4)
    (setq web-mode-css-indent-offset 4)
    (setq web-mode-code-indent-offset 4)
    (setq web-mode-indent-style 4))

(add-hook 'web-mode-hook  'my-web-mode-hook)

(setq web-mode-enable-current-element-highlight t)
(setq web-mode-enable-current-column-highlight t)

;; Tern
(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))



;; ````````````````````````````````````````````````````````````
;;             ORG-MODE & ORG-MODE w/ CLOJURE
;; ............................................................

(add-to-list 'load-path "/full-path-to/org-mode/lisp")

(require 'org)
(require 'ob-clojure)

(setq org-babel-clojure-backend 'cider)
(require 'cider)

;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)


;; ````````````````````````````````````````````````````````
;;            CLOJURE and CIDER
;; ........................................................

;; clj-refactor mode
;; (require 'clj-refactor)

;; (defun my-clojure-mode-hook ()
;;     (clj-refactor-mode 1)
;;     (yas-minor-mode 1) ; for adding require/use/import statements
;;     ;; This choice of keybinding leaves cider-macroexpand-1 unbound
;;     (cljr-add-keybindings-with-prefix "C-c C-m"))

;; (add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

;; figwheel
(defun figwheel-repl ()
  (interactive)
  (run-clojure "lein figwheel"))

(add-hook 'clojure-mode-hook #'inf-clojure-minor-mode)

;; increase indent
(require 'clojure-mode)

(define-clojure-indent
  (defroutes 'defun)
  (GET 2)
  (POST 2)
  (PUT 2)
  (DELETE 2)
  (HEAD 2)
  (ANY 2)
  (context 2))
;; .........................

(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
(setq nrepl-popup-stacktraces nil)
(add-to-list 'same-window-buffer-names "<em>nrepl</em>")

;;(add-to-list 'exec-path "/usr/local/bin")
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

;; Par Edit
(add-hook 'clojure-mode-hook 'paredit-mode)

;; rainbow delimiters
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'el-mode-hook 'rainbow-delimiters-mode)

;; ac-cider
(require 'ac-cider)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

;; clojure-mode-extra-font-locking - highlight core functions
;; WARNING: MAy create false positives
(eval-after-load 'clojure-mode '(require 'clojure-mode-extra-font-locking))


;; trigger auto-complete with TAG
(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))

(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)


;; ````````````````````````````````````````````````````````````
;;                 END CLOJURE
;; ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,


;; ``````````````````````````````````````````````````
;; MARKDOWN MODE
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;;..................................................



;; ..................................................
;; ERC

(setq erc-echo-notices-in-minibuffer-flag t)


;; ;;; "CUSTOM" MADNESS -- Don't add code below here
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(background-color "#202020")
 '(background-mode dark)
 '(cider-completion-use-context t)
 '(column-number-mode t)
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(cursor-color "#cccccc")
 '(custom-enabled-themes (quote (smart-mode-line-dark)))
 '(custom-safe-themes
   (quote
    ("a015aab3f8fc253dea2e5f0656f068074b85f94bb73db76eaf9b5684dd267178" "bb7b527f54908babf0a865a8e6271c5017ad154314f0ed1d038cd606740bea6e" "5e07b1764683926728b6c031d1aee8c4fddaafc640d014e9077f0b67f3343db3" "759c150fcfca7d94e4477baaa0dafa959d8a300ff29ddf87c03e78e5df27e6b8" "737d9d0e0f6c4279e80f7479ec5138af6e4908a2d052126f254e1e6d1a0d0188" "634c0339e2e8f5c0e5bbfb8f379ad9aa1771fd78474b8a192e82f0bf72a9610f" "c406f8acccf461a7b0e32c41b7236b5bda956b318a8b6048b6056f919159738f" "e62ec787ed525fa2d83670a52e3f4713f3ffa47398696a2ecdab8af0bf6edfce" "3a5de228ce038d4c8a661ff031dac25abdf65b895bf4997e00b67bd58ee79459" "7fa791a738d974c065591b84909a4af0bf036ffe961bc559a6be9bfbc41bbf86" "b43ff17f8a415ed35f9af0efc80ac9bd57527a3e9d0efd249a05a9c40fdeeef5" "7fec4bfcca788040f9290bdb967ca26950157ada22cc5b6f302536bac87909e5" "5b8cd4e5e4b8b552150c58ffe6065025afc18415ed1f0e857642c503a4853698" "0d808b320f162b64be3a66ada80bbd77ef075ab4098a391f26285d0b5095b7e5" "b535e188ea14b7f22d78993dbc061a5a78f9bbdb1f57240c6d86b3d119d9958b" "58854572d35d885e53fb9ec00f1b74cc1d69bc405b5c20904eec56181fc52e3e" "f5eb916f6bd4e743206913e6f28051249de8ccfd070eae47b5bde31ee813d55f" "790e74b900c074ac8f64fa0b610ad05bcfece9be44e8f5340d2d94c1e47538de" "d393265729df08ad445118772c927a01eae254d16fe077c59cbbb6c4bb07659c" "f92aae9ba768236b03345523f49d3bd8bd351305c5abd7813076dfb29d75c96e" "c5aa3c804dbeda327e044856433a40625a1e2ad8841b3207fc8deb14769ca61a" "d52384393064747123781bd9e0cb53dfd1cde746ae32465e7cf79849082f92cc" "8ff6929b1c208f377a17c97b5b35205fa1246fd0248533cbf9970a4ba17561d0" "c66794ce7cabbda04733aff7c6c48390139fac4ad3a9d08e67a4889534ec0e69" "3a69621a68c2d3550a4c777ffc000e1ea66f5bc2f61112814c591e1bda3f5704" "55588155c906abd05b71be6e90ea82e82052f91907b65f796e275063a9ccb341" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "c488319ada8ec371677525341dcc9b99d3348d7fee627ebff3f89805407380a9" "825ef7731efa215775c9442f41088587e4f1b10bdeecf262ce14958b632b94bf" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "19352d62ea0395879be564fc36bc0b4780d9768a964d26dfae8aad218062858d" "7b45a56a829638c36c4aca1735929bc929d34760c6b84f7eec37c90291441fb9" "1b4ac0fd06d325801c3b6dcf64f026b566c93a189ad78bac52891d0d21d096fc" "32f2c88b7171263eb06e829c44f42a9c96e25e1c2992a80029eb78e674c92d80" "9044403113ba38f024b9adcc2f35ffa8be7cdc7863a01761369f98607fb8027c" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "ad05836ee41c856b5417f15763f63a837e594389c3cf63e7d792dfab7d5ac441" "54b04dcad91325d3d2db5f5d6d8c47364965a7728228d7298ebb4286c3502e7c" "6f2c81f8e9e30655f66726ccfabdfbd42b440d52e338fb3376d3503802971e30" "a14c53257001a37d7c160ec39e808d51a6edffe01fc81b7ede83ff2086ce3d23" "802f22a09ccef16a70ef3e3df14ce85e36ffe8fbe348807eca7c00ed74b0a05b" "78093fdfef56114450377d73d12c8cfdd4136d4c64531b302eb9fcd9b02e3489" "fb8f6ea589f357ecfcb6021534ade3c67abbad1b0e0618dc2f44bc0a8322e2b8" "d14dc7503816b6ccf9a12f5895dca76cde4b508fa8854885bc20ec1d652e86a1" "f3077f0dd23066dc134e096e0b1900b5091fe3a90ce8b6887fb377e910f53b03" "cfb1991e3b6346a71be956093b3ffe413a962e2e68021e9e35cd8b495225afb1" "129a04bf4028f9950940aedff435ae4b8775133bb2eee94f78357fd51f10cc30" "91b149461e0ca34fbc6ae5879ed477c09d510d5faed8787fb7084c50a041c971" "43d8ab4807232c335f95e97e3436a32fdb53c92896cb15ec6417b9cb4fbc556b" "9d50ff16633539c23cac63d2798b8e3b2a6fadc360403b965bda0d0905e0b8b3" "246a51f19b632c27d7071877ea99805d4f8131b0ff7acb8a607d4fd1c101e163" "54b4cd6af63dca69b32b1995e4e817ee9cb9e0017146173aeb0cdb60fa916bc1" "7e5af5e1a41d552b19dab1fe4fb893180619c16dcb48594b6b6244b7de40f753" "1bf7d5d1b9e63366eab773dcdfaa080d3bf9885de023f75b878425ec30c21fec" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "5e3fc08bcadce4c6785fc49be686a4a82a356db569f55d411258984e952f194a" "83e584d74b0faea99a414a06dae12f11cd3176fdd4eba6674422539951bcfaa8" "cc60d17db31a53adf93ec6fad5a9cfff6e177664994a52346f81f62840fe8e23" "bed4d169698488b8b5b90f7dbdbaca2e7b9c4a18727adbb7b3ddcb4df0577ce0" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "4af6fad34321a1ce23d8ab3486c662de122e8c6c1de97baed3aa4c10fe55e060" "28ec8ccf6190f6a73812df9bc91df54ce1d6132f18b4c8fcc85d45298569eb53" "7db66dafe7a65a8a6a403014edb5e53deca2da82279cb8f3f55e4bc336bf48af" "ea489f6710a3da0738e7dbdfc124df06a4e3ae82f191ce66c2af3e0a15e99b90" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "72a81c54c97b9e5efcc3ea214382615649ebb539cb4f2fe3a46cd12af72c7607" "46fd293ff6e2f6b74a5edf1063c32f2a758ec24a5f63d13b07a20255c074d399" "96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "0820d191ae80dcadc1802b3499f84c07a09803f2cb90b343678bdb03d225b26b" "eafda598b275a9d68cc1fbe1689925f503cab719ee16be23b10a9f2cc5872069" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "7bde52fdac7ac54d00f3d4c559f2f7aa899311655e7eb20ec5491f3b5c533fe8" "0c311fb22e6197daba9123f43da98f273d2bfaeeaeb653007ad1ee77f0003037" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" default)))
 '(custom-theme-load-path
   (quote
    ("/Users/mallorym/" "/Users/mallorym/.emacs.d/elpa/aurora-theme-20150811.1308/" "/Users/mallorym/.emacs.d/elpa/bliss-theme-20141115.2301/" "/Users/mallorym/.emacs.d/elpa/cherry-blossom-theme-20150621.2042/" "/Users/mallorym/.emacs.d/elpa/cyberpunk-theme-20150730.2219/" "/Users/mallorym/.emacs.d/elpa/gandalf-theme-20130809.247/" "/Users/mallorym/.emacs.d/elpa/leuven-theme-20150622.306/" "/Users/mallorym/.emacs.d/elpa/lush-theme-20141107.806/" "/Users/mallorym/.emacs.d/elpa/noctilux-theme-20150723.747/" "/Users/mallorym/.emacs.d/elpa/smart-mode-line-20150803.338/" "/Users/mallorym/.emacs.d/elpa/soft-stone-theme-20140614.135/" "/Users/mallorym/.emacs.d/elpa/solarized-theme-20150831.823/" "/Users/mallorym/.emacs.d/elpa/sublime-themes-20150328.131/" "/Users/mallorym/.emacs.d/elpa/zenburn-theme-20150831.716/" custom-theme-directory t)))
 '(diary-entry-marker (quote font-lock-variable-name-face))
 '(electric-pair-mode t)
 '(emms-mode-line-icon-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *note[] = {
/* width height num_colors chars_per_pixel */
\"    10   11        2            1\",
/* colors */
\". c #358d8d\",
\"# c None s None\",
/* pixels */
\"###...####\",
\"###.#...##\",
\"###.###...\",
\"###.#####.\",
\"###.#####.\",
\"#...#####.\",
\"....#####.\",
\"#..######.\",
\"#######...\",
\"######....\",
\"#######..#\" };")))
 '(foreground-color "#cccccc")
 '(fringe-mode 6 nil (fringe))
 '(global-company-mode t)
 '(global-hl-line-mode t)
 '(global-visual-line-mode t)
 '(gnus-logo-colors (quote ("#259ea2" "#adadad")) t)
 '(gnus-mode-line-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *gnus-pointer[] = {
/* width height num_colors chars_per_pixel */
\"    18    13        2            1\",
/* colors */
\". c #358d8d\",
\"# c None s None\",
/* pixels */
\"##################\",
\"######..##..######\",
\"#####........#####\",
\"#.##.##..##...####\",
\"#...####.###...##.\",
\"#..###.######.....\",
\"#####.########...#\",
\"###########.######\",
\"####.###.#..######\",
\"######..###.######\",
\"###....####.######\",
\"###..######.######\",
\"###########.######\" };")) t)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(linum-eager nil)
 '(linum-format (quote dynamic) t)
 '(magit-diff-use-overlays nil)
 '(main-line-color1 "#191919")
 '(main-line-color2 "#111111")
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(org-support-shift-select t)
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(powerline-color1 "#191919")
 '(powerline-color2 "#111111")
 '(rainbow-delimiters-max-face-count 10)
 '(red "#ffffff")
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(tool-bar-mode nil)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
