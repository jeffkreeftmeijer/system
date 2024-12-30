.PHONY: switch-nixos switch-macos build-macos

switch-nixos: 
	sudo nixos-rebuild switch --flake ./machines/asahi#asahi

switch-macos: build-macos
	nix --extra-experimental-features nix-command \
	    --extra-experimental-features flakes \
	    run nix-darwin -- switch --flake .#macos
	killall Dock Finder WindowManager

build-macos:
	nix --extra-experimental-features nix-command \
	    --extra-experimental-features flakes \
	    run nix-darwin -- build --flake .#macos
	nix run nixpkgs#nvd -- diff /run/current-system result
