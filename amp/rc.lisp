;; -*- lisp -*-

(in-package :stumpwm)

;; Function to get the hostname of the system
(defun get-hostname ()
  (let ((hostname (or (getenv "HOSTNAME") (machine-instance))))
    (string-downcase hostname)))  ;; Ensure hostname is in lowercase for comparison

;; Function to get the username of the current user
(defun get-username ()
  (or (getenv "USER") (getenv "LOGNAME")))

;; Get current hostname
(defvar *current-hostname* (get-hostname))

;; Conditional operations based on hostname
(cond
  ((string= *current-hostname* "deskitute")
     (run-shell-command "exec xset s off -dpms"))

  ((string= *current-hostname* "s-caring")
     (run-shell-command "exec xset s off -dpms"))

  ((string= *current-hostname* "laptidate"))

  ;; Default case if none of the hostnames match
  (t))

;; Set the startup message to "welcome username@hostname"
(setf *startup-message* (format nil "welcome ~a@~a" (get-username) (get-hostname)))


;; Default font used
(set-font "-xos4-terminus-medium-r-normal--14-*-*-*-*-*")

(run-shell-command "setxkbmap -option ctrl:nocaps")

(defun print-file (filename)
  (with-open-file (in filename)
    (with-standard-io-syntax
      (format nil "~:(~a~)" (read in)))))

(run-shell-command "exec cd .common/dotfiles/scripts/ && exec ./weather.sh" t)

(run-shell-command "exec /home/jost/.screenlayout/default.sh")

;; -----------------------------------------------------------------------------------------------------
;; -----------------------------------------------------------------------------------------------------
;; APPEARANCE
;; -----------------------------------------------------------------------------------------------------
;; -----------------------------------------------------------------------------------------------------

;; Set wallpaper via feh.
(run-shell-command "feh --bg-scale ~/.wallpaper.jpg")


;; -----------------------------------------------------------------------------------------------------
;; FRAMES & WINDOWS 
;; -----------------------------------------------------------------------------------------------------

;; The width in pixels given to the borders of regular windows.
(setf *normal-border-width* 0)
;; The width in pixels given to the borders of windows with maxsize or ratio hints.
(setf *maxsize-border-width* 0)
;; The width in pixels given to the borders of transient or pop-up windows.
(setf *transient-border-width* 0)

(defparameter FOREGROUND-COLOR "green")
(defparameter BACKGROUND-COLOR "black")
(defparameter BORDER-COLOR "green")

;; Window border colors.
(set-focus-color "dimgray")
(set-unfocus-color "grey10")
(set-win-bg-color "black")             ; set to the color of emacs's background
(set-float-focus-color "black")
(set-float-unfocus-color "grey")

(setf *window-border-style* :thin)      ; :thick :thin :tight :none
(set-normal-gravity :bottom)
(set-maxsize-gravity :center)
(set-transient-gravity :center)

;; Input box colors
(set-bg-color BACKGROUND-COLOR)
(set-fg-color "forestgreen")
(set-border-color "grey16")
(set-msg-border-width 0)
(setf *input-window-gravity* :bottom-right)

; WINDOWS
(setf *maxsize-border-width* 0)
(set-frame-outline-width 1)
(set-normal-gravity :center)
(setf *normal-border-width* 1)
(setf *window-border-style* :thin) ; thick,thin,none,tight

; bind C-t C-r to windowlist (default to C-t ")
(define-key *root-map* (kbd "C-r") "windowlist")

; message window, input window
(setf *message-window-gravity* :bottom-right)

;; -----------------------------------------------------------------------------------------------------
;; MODE-LINE 
;; -----------------------------------------------------------------------------------------------------

;; Firgure Out Why These Aren't Loading...

;;(setf *contrib-dir* "~/.lisp/apps/stumpwm/contrib")

;;(load "/usr/share/stumpwm/contrib/modeline/disk/package.lisp")
;;(load "/usr/share/stumpwm/contrib/modeline/disk/disk.lisp")

;;(load "/usr/share/stumpwm/contrib/modeline/cpu/package.lisp")
;;(load "/usr/share/stumpwm/contrib/modeline/cpu/cpu.lisp")

;;(load "/usr/share/stumpwm/contrib/modeline/mem/package.lisp")
;;(load "/usr/share/stumpwm/contrib/modeline/mem/mem.lisp")

;;(load "/usr/share/stumpwm/contrib/modeline/net/package.lisp")
;;(load "/usr/share/stumpwm/contrib/modeline/net/net.lisp")

;;(load "/usr/share/stumpwm/contrib/minor-mode/mpd/package.lisp")
;;(load "/usr/share/stumpwm/contrib/modeline/mpd/mpd.lisp")

;;(load "/usr/share/stumpwm/contrib/modeline/battery-portable/package.lisp")
;;(load "/usr/share/stumpwm/contrib/modeline/battery-portable/battery-portable.lisp")


;;(load-module "disk")
;;(load-module "cpu")
;;(load-module "mem")
;;(load-module "net")
;;(load-module "mpd")
;;(load-module "battery-portable")

(setf *mode-line-position* :bottom)
(setf *mode-line-screen-position* :bottom)
(setf *mode-line-frame-position* :bottom)
(setf *mode-line-border-width* 0)
(setf *mode-line-border-height* 0)
(setf *mode-line-pad-x* 0)
(setf *mode-line-pad-y* 0)
(setf *mode-line-background-color* "black")
(setf *mode-line-foreground-color* "grey25")
(setf *mode-line-timeout* 2)
(setf *mode-line-border-color* "grey30")
(setf *window-format* "<%n%s%m%30t>")

(setf *screen-mode-line-format* 
      (list   `(:eval (stumpwm::format-time-string "%a %b %e %k:%M %Y"))
	      " ^6*(^[^n^7*g ^B^5*%u^])^n"
	      " ^6*(^[^n^7*f ^]%g)^n"
	      " ^6*(^[^n^7*w ^]%w)^n"
	      (string #\NewLine)
	      " | D/T:: %d"    
	      " | PWR:: %B" 
	      " | DISK:: %D"
	      " | CPU:: %c %t"
	      " | MEM:: %M"
	      " | NTWRK:: %l"
	      " | VLM:: %V" 
	      (string #\NewLine)
	      " | WTHR:: Saint Louis, Lambart International: "  '(:eval (print-file "/tmp/weather.txt"))
	      " | MAIL::"
	      " | IRC::"
	      " | MEDI:: %m"))

(setf *disk-usage-paths* '("/" "/home"))

;; Switch mode-line on
(toggle-mode-line (current-screen) (current-head))

;; toggle mode-line
(define-key *root-map* (kbd ",") "mode-line")

;; -----------------------------------------------------------------------------------------------------
;; -----------------------------------------------------------------------------------------------------
;; VARIOUS BINDINGS AND/OR REMAPPINGS (with various other bits in-between.)
;; -----------------------------------------------------------------------------------------------------
;; -----------------------------------------------------------------------------------------------------

(set-prefix-key (kbd "C-quoteright"))

;; -----------------------------------------------------------------------------------------------------
;; APPLICATONS
;; -----------------------------------------------------------------------------------------------------

;; run-or-raise defined Text Editor.
(defcommand texteditor () ()
  "Start terminal emulator or switch to it, if it is already running."
  (run-or-raise "emacs" '(:instance "emacs")))

;; run-or-raise defined Web browser
(defcommand webbrowser () ()
  "Start web browser or switch to it, if it is already running."
  (run-or-raise "~/.guix-profile/bin/conkeror" '(:instance "Navigator")))

;; run-or-raise defined Terminal Emulator.
(defcommand termemu () ()
  "Start terminal emulator or switch to it, if it is already running."
  (run-or-raise "xterm" '(:instance "xterm")))

;; run-or-raise defined Anki Flash Cards.
(defcommand flashcard () ()
  "Start a flashcard program or switch to it, if it is already running."
  (run-or-raise "anki" '(:instance "anki")))

;; run-or-raise defined Terminal Emulator.
(defcommand paint () ()
  "Start paint program or switch to it, if it is already running."
  (run-or-raise "mypaint" '(:instance "mypaint")))

(defparameter *application-map*
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "e") "texteditor")
    (define-key m (kbd "w") "webbrowser")
    (define-key m (kbd "t") "termemu")
    (define-key m (kbd "a") "flashcard")
    (define-key m (kbd "p") "paint")
    (define-key m (kbd "k") "exec xkill")
    m))

(define-key *root-map* (kbd "a") '*application-map*)

;; -----------------------------------------------------------------------------------------------------
;; WINDOWS
;; -----------------------------------------------------------------------------------------------------

;;; window operate
(defparameter *window-operate-map*
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "ESC") "abort")
    (define-key m (kbd "n") "move-focus down")
    (define-key m (kbd "p") "move-focus up")
    (define-key m (kbd "b") "move-focus left")
    (define-key m (kbd "f") "move-focus right")

    (define-key m (kbd "C-n") "move-window down")
    (define-key m (kbd "C-p") "move-window up")
    (define-key m (kbd "C-b") "move-window left")
    (define-key m (kbd "C-f") "move-window right")

    (define-key m (kbd "k") "remove")
    (define-key m (kbd "0") "remove")
    m))

(define-key *root-map* (kbd "w") '*window-operate-map*)

;; -----------------------------------------------------------------------------------------------------
;; FRAMES
;; -----------------------------------------------------------------------------------------------------

(defparameter *frame-map*
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "3") "hsplit")
    (define-key m (kbd "2") "vsplit")
    (define-key m (kbd "1") "only")
    (define-key m (kbd "0") "remove")
    (define-key m (kbd "r") "resize")

    (define-key m (kbd "f") "fnext")
    (define-key m (kbd "b") "fother")
    (define-key m (kbd "s") "fselect")
    m))

(define-key *root-map* (kbd "f") '*frame-map*)

;; -----------------------------------------------------------------------------------------------------
;; GROUPS
;; -----------------------------------------------------------------------------------------------------

(defparameter *group-map*
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "n") "gnew")
    (define-key m (kbd "N") "gnew-float")
    (define-key m (kbd "b") "gnewbg")
    (define-key m (kbd "B") "gnewbg-float")

    (define-key m (kbd "f") "gnext")
    (define-key m (kbd "b") "gprev")

    (define-key m (kbd "m") "gnmerge")
    (define-key m (kbd "s") "gselect")
    (define-key m (kbd "v") "gmove")
    (define-key m (kbd "k") "gkill")
    (define-key m (kbd "r") "grename")
    (define-key m (kbd "l") "grouplist")
    m))

(define-key *root-map* (kbd "g") '*group-map*)


;; -----------------------------------------------------------------------------------------------------
;; VOLUME
;; -----------------------------------------------------------------------------------------------------

(defparameter *volume-map*
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "m") "exec amixer --quiet set Master toggle")
    (define-key m (kbd "i") "exec amixer --quiet set Master 10+")
    (define-key m (kbd "d") "exec amixer --quiet set Master 10-")
    m))

; Set the same, on the associative hardware keys!
(define-key *top-map* (kbd "XF86AudioRaiseVolume") "exec amixer --quiet set Master 5+")
(define-key *top-map* (kbd "XF86AudioLowerVolume") "exec amixer --quiet set Master 5-")
(define-key *top-map* (kbd "XF86AudioMute") "exec amixer --quiet set Master toggle")

(define-key *root-map* (kbd "v") '*volume-map*)


;; -----------------------------------------------------------------------------------------------------
;; DISPLAY
;; -----------------------------------------------------------------------------------------------------

;; Update the display-map to include screen navigation
(defparameter *display-map*
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "z") "exec xbacklight -set 0")
    (define-key m (kbd "f") "exec xbacklight -set 100")
    (define-key m (kbd "i") "exec xbacklight -inc 30")
    (define-key m (kbd "d") "exec xbacklight -dec 30")

    ;; Screen navigation bindings
    (define-key m (kbd "n") "snext")  ; Switch to next screen
    (define-key m (kbd "p") "sprev")  ; Switch to previous screen
    (define-key m (kbd "o") "sother") ; Switch to last used screen

    (define-key m (kbd "r") "exec xrandr --auto")
    (define-key m (kbd "F") "exec xrandr --output LVDS1 --off")
    (define-key m (kbd "N") "exec xrandr --output LVDS1 --on")
    m))

;; Bind the display map to a key combination in the root map
(define-key *root-map* (kbd "d") '*display-map*)




;; -----------------------------------------------------------------------------------------------------
;; SESSION
;; -----------------------------------------------------------------------------------------------------

(defcommand reinit () ()
  (run-commands "reload" "loadrc"))

;;Query ACPI and show the battery's status.
(defcommand show-battery () ()
   (echo-string (current-screen) (run-shell-command "acpi" t)))

(defcommand toggle-touchpad () ()
  "Toggle the laptop touchpad on/off.
   Need to have set 'Option SHMConfig' for Synaptics Touchpad
   device in xorg.conf."
  (let ((state (run-shell-command
                "synclient -l | grep TouchpadOff | awk '{ print $3 }'" t)))
    (case (string= (subseq state 0 1) "1")
      (t (shell-command "synclient TouchpadOff=0"))
      (otherwise (shell-command "synclient TouchpadOff=1")
                 (banish-pointer)))))

(defparameter *session-map*
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "r") "reinit")
    (define-key m (kbd "t") "toggle-touchpad")
    (define-key m (kbd "b") "show-battery")
    (define-key m (kbd "v") "version")
    (define-key m (kbd "SunPrint_Screen") "exec scrot '%Y-%m-%d_$wx$h_scrot.png' -e 'mv $f ~/PERSONAL/Visual/Screenshots/'")
    (define-key m (kbd "l") "exec xlock -mode space")
;;  (define-key m (kbd "c") "caffeine")
    (define-key m (kbd "q") "quit")
    m))

(define-key *root-map* (kbd "s") '*session-map*)


;; -----------------------------------------------------------------------------------------------------
;; CONTROLLER
;; -----------------------------------------------------------------------------------------------------

;; Control specific applications. Namely EMMS... tbd.

