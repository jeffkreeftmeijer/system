.PHONY: switch build update_nixpkgs update_emacs reset_defaults

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

update_nixpkgs:
	nix flake lock --update-input nixpkgs

update_cask:
	nix flake lock --update-input homebrew-cask

update_emacs:
	nix flake lock --update-input configured-emacs

reset_defaults:
	-defaults delete com.apple.dock
	-defaults delete com.apple.finder
	-defaults delete com.apple.ical
	-defaults delete com.apple.safari
	-defaults delete com.apple.universalaccess
	-defaults delete com.apple.windowmanager
	-defaults delete NSGlobalDomain
