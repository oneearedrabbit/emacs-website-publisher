today_start=$(date +%s -d "today 00:00:00")
today_end=$(date +%s -d "today 23:59:59")

jq -rs "[\"Visits\", \"URL\", \"Status\"], (. | map(select(.ts > $todat_start and .ts < $today_end)) | group_by(.request.uri,.status) | map({title: .[0].request.uri, count:length, status: .[0].status}) | sort_by(.count) | .[-15:] | reverse | .[] | [.count, .title, .status]) | @tsv" /var/log/caddy/example.com-access.log | visidata
