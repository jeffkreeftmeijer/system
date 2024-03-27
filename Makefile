switch:
	nix --extra-experimental-features nix-command \
	    --extra-experimental-features flakes \
	    run nix-darwin -- switch --flake .#simple
	killall Dock Finder

update_nixpkgs:
	nix flake lock --update-input nixpkgs

update_emacs:
	nix flake lock --update-input configured-emacs
