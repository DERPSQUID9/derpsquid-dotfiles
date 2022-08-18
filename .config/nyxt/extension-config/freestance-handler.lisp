;;;; ~/.config/nyxt/extension-config/freestance-handler.lisp
;;;; settings for nx-freestance-handler extension

(define-configuration web-buffer
  ((request-resource-hook
    (reduce #'hooks:add-hook
            '(nx-freestance-handler:nitter-handler
              nx-freestance-handler:bibliogram-handler
              nx-freestance-handler:scribe-handler
              nx-freestance-handler:invidious-handler)
            :initial-value %slot-default%))))
