.PHONY: all
all: build

build:
	/bin/emacs -Q --script ./scripts/build-site.el

serve:
	/bin/caddy run

publish: build
	rsync -av html/ root@server:/srv/http/example.com

stats:
	ssh root@hyper-static < ./scripts/stats.sh > ./tmp/stats.tsv && \
	vd ./tmp/stats.tsv
  
clean:
	rm -rf html
