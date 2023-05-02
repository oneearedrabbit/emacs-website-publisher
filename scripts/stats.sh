today_start=$(date +%s -d "24 hours ago")
today_end=$(date +%s -d "now")
files="$(find /srv/http/drawmeasheep.net -name '*.html' | cut -d '/' -f 5- | awk '{print "\"/" $0 "\""}' | tr '\n' ',' | sed 's/,$/\n/'),\"/\""

jq -rs "[\"Time\", \"URL\", \"Status\", \"Referer\"], (. | map(select(.ts > $today_start and .ts < $today_end and .status == 200 and .request.uri == ($files))) | map({time: .ts | strftime(\"%Y-%m-%d %H:%M:%S\"), title: .request.uri, status: .status, referer: .request.headers.Referer[0]}) | .[] | [.time, .title, .status, .referer]) | @tsv" /var/log/caddy/example.com-access.log
