.PHONY: all
all: build

build:
	/bin/emacs -Q --script ./scripts/build-site.el

serve:
	/bin/caddy run

publish: build
	rsync -av html/ root@server:/srv/http/example.com

stats:
	ssh root@server < ./scripts/stats.sh > ./tmp/stats.tsv && \
	vd -p ./stats/stats_URL_freq.vdj ./tmp/stats.tsv

watch:
	find . -path ./tmp -prune -o -path ./html -prune -o -type f -print | entr -s 'make build'

clean:
	rm -rf html
