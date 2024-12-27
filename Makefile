.PHONY: update-apple-silicon-support

update-apple-silicon-support:
	git clone https://github.com/tpwrules/nixos-apple-silicon.git
	cp -r nixos-apple-silicon/apple-silicon-support/ .
	rm -r nixos-apple-silicon/
