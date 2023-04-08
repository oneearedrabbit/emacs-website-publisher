today=$(date -u +"%a, %d %b %Y %T GMT")

for url in $(find /srv/http/example.com/ -name '*.html' | cut -d "/" -f 5-)
do
    count=$(rg -e $url -e "$today" /var/log/caddy/example.com-access.log | wc -l)
    if [ $count != "0" ]
    then
        echo "$count - $url"
    fi
done | sort -nr
