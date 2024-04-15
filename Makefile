switch:
	nix --extra-experimental-features nix-command \
	    --extra-experimental-features flakes \
	    run nix-darwin -- switch --flake .#macos
	killall Dock Finder

update_nixpkgs:
	nix flake lock --update-input nixpkgs

update_emacs:
	nix flake lock --update-input configured-emacs

reset_defaults:
	-defaults delete com.apple.dock
	-defaults delete com.apple.finder
	-defaults delete com.apple.ical
	-defaults delete com.apple.safari
	-defaults delete com.apple.universalaccess
	-defaults delete NSGlobalDomain
