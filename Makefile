.PHONY: all
all: build

build:
	/bin/emacs -Q --script ./scripts/build-site.el

serve:
	/bin/caddy run

publish: build
	rsync -av html/ root@server:/srv/http/example.com

stats:
	ssh root@server < ./scripts/stats.sh

clean:
	rm -rf html
