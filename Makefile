.PHONY: switch-nixos switch-macos

switch-nixos: 
	sudo nixos-rebuild switch --flake ./machines/asahi#asahi

switch-macos:
	nix --extra-experimental-features nix-command \
	    --extra-experimental-features flakes \
	    run nix-darwin -- switch --flake ./machines/macos#macos
	killall Dock Finder WindowManager
