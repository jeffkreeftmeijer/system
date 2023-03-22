(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'ox-gfm)
(straight-use-package
 '(ox-extend :type git :host github :repo "jeffkreeftmeijer/ox-extend.el"))
(straight-use-package
 '(ox-md-title :type git :host github :repo "jeffkreeftmeijer/ox-md-title.el"))

(require 'ox-md-title)

(defun publish ()
  (org-publish-file "nix.org"
		    '("readme"
		      :base-directory "."
		      :publishing-directory "."
		      :publishing-function org-gfm-publish-to-gfm
		      :extensions ('ox-md-title))))

