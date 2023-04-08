.PHONY: all
all: build

build:
	/bin/emacs -Q --script ./scripts/build-site.el

serve:
	/bin/caddy run

publish: build
	rsync -av html/ root@server:/srv/http/example.com

clean:
	rm -rf html
