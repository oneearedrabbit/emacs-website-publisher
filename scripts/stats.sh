today_start=$(date +%s -d "today 00:00:00")
today_end=$(date +%s -d "today 23:59:59")

jq -rs "[\"Time\", \"URL\", \"Status\"], (. | map(select(.ts > $today_start and .ts < $today_end)) | map({time: .ts | strftime(\"%Y-%m-%d %H:%M:%S\"), title: .request.uri, status: .status}) | .[] | [.time, .title, .status]) | @tsv" /var/log/caddy/example.com-access.log

today_start=$(date +%s -d "today 00:00:00")
today_end=$(date +%s -d "today 23:59:59")
files=$(find /srv/http/example.com -name '*.html' | cut -d '/' -f 5- | awk '{print "\"/" $0 "\""}' | tr '\n' ',' | sed 's/,$/\n/')

jq -rs "[\"Time\", \"URL\", \"Status\"], (. | map(select(.ts > $today_start and .ts < $today_end and .status == 200 and .request.uri == ($files))) | map({time: .ts | strftime(\"%Y-%m-%d %H:%M:%S\"), title: .request.uri, status: .status}) | .[] | [.time, .title, .status]) | @tsv" /var/log/caddy/example.com-access.log
