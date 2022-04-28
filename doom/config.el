;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ezequiel Ramis"
      user-mail-address "ezequielramis.hello@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "SFMono Nerd Font" :size 18))
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq +doom-quit-messages '(
                            ;; from Doom 1
                            "Please don't leave, there's more demons to toast!"
                            "I wouldn't leave if I were you. DOS is much worse."
                            "Don't leave yet -- There's a demon around that corner!"
                            "Ya know, next time you come in here I'm gonna toast ya."
                            "Go ahead and leave. See if I care."
                            "Are you sure you want to quit this great editor?"
                            ;; from Portal
                            "Thank you for participating in this Aperture Science computer-aided enrichment activity."
                            "You can't fire me, I quit!"
                            "I don't know what you think you are doing, but I don't like it. I want you to stop."
                            "This isn't brave. It's murder. What did I ever do to you?"
                            "I'm the man who's going to burn your house down! With the lemons!"
                            "Okay, look. We've both said a lot of things you're going to regret..."
                            ;; Custom
                            "Emacs will remember that."
                            "Hey! Hey, M-x listen!"
                            "It's not like I'll miss you or anything, b-baka!"
                            "You are *not* prepared!"
                            "Please don't go. The drones need you. They look up to you."
                            ;; Franquito
                            "Chau, te vas, TE VAS... Púmbate *Elefantito de Simón*"
                            "¡No hermano! No me sirve, no me sirve... *PUM PUM PUM*"
                            "Solidaridad, para Andy que se va... Solidaridad para Andy que se va..."
                            "Me chupa un huevo... Me chupa tres huevos, no uno, me chupa tres huevos."
                            "*Seña de rajar* Chau... Abandona la casa, eh? Abandona la casa... Basta papá."
                            "Saludos desde Nueva York, Mica Bezona."
                            "*Toma mate, luego de una pausa* ¿Qué me importa? *Toma mate de vuelta*"
                            "A llorar a la llorería."
                            "*Elefantito de Simón triste*"))        

(add-to-list 'auto-mode-alist '("\\.yuck\\'" . lisp-mode))
(setq doom-themes-treemacs-theme "doom-colors")
