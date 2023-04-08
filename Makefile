.PHONY: all
all: build

build:
	/bin/emacs -Q --script ./scripts/build-site.el

serve:
	/bin/caddy run

clean:
	rm -rf html
