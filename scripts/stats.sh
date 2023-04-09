today_start=$(date +%s -d "today 00:00:00")
today_end=$(date +%s -d "today 23:59:59")

jq -rs "[\"Time\", \"URL\", \"Status\"], (. | map(select(.ts > $today_start and .ts < $today_end)) | map({time: .ts | strftime(\"%Y-%m-%d %H:%M:%S\"), title: .request.uri, status: .status}) | .[] | [.time, .title, .status]) | @tsv" /var/log/caddy/example.com-access.log
