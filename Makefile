.PHONY: switch build

switch: build
	nix --extra-experimental-features nix-command \
	    --extra-experimental-features flakes \
	    run nix-darwin -- switch --flake .#macos
	killall Dock Finder WindowManager

build:
	nix --extra-experimental-features nix-command \
	    --extra-experimental-features flakes \
	    run nix-darwin -- build --flake .#macos
	nix run nixpkgs#nvd -- diff /run/current-system result
