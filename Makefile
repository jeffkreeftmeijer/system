.PHONY: switch-nixos switch-macos build update_nixpkgs update_emacs reset_defaults update-apple-silicon-support

switch-nixos: 
	sudo nixos-rebuild switch --flake ./machines/asahi#asahi

switch-macos: build
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

update-apple-silicon-support:
	git clone https://github.com/tpwrules/nixos-apple-silicon.git
	cp -r nixos-apple-silicon/apple-silicon-support/ .
	rm -r nixos-apple-silicon/
