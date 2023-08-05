;;;; config.d/status.lisp
;;;; status bar settings
(in-package #:nyxt-user)

;;; enable glyphs in status buffer
(define-configuration status-buffer
  ((glyph-mode-presentation-p t)))

(defmacro define-glyphs (&rest glyphs)
  "Helper macro to set `glyph' slot for multiple modes at once."
  `(progn ,@(loop for (mode glyph raw-p)
                  in glyphs 
                  collect `(define-configuration ,(if raw-p
                                                      mode
                                                      (read-from-string (format nil "NYXT/MODE/~a:~a-MODE" mode mode)))
                             ((glyph ,glyph))))))

;;; define glyphs for modes
(define-glyphs (blocker         "󰂭")
               (reduce-tracking "")
               (repl            ""))
