# Emacs + Org-mode publisher

This is a template I use to publish my static websites.

## How to

```
make build    # build a website
make serve    # caddy serves website on :1313 port
make clean    # delete generated website
make publish  # publish a website to remote server
make stats    # visits, requires jq and visidata
```

## Server

- Cheap DigitalOcean instance, install Arch: https://wiki.archlinux.org/title/Arch_Linux_on_a_VPS
- pacman -S rsync caddy ufw
- sh -c 'curl https://raw.githubusercontent.com/caddyserver/dist/master/init/caddy.service > /etc/systemd/system/caddy.service'
- chmod 644 /etc/systemd/system/caddy.service
- ufw allow proto tcp from any to any port 80,443
- edit /etc/caddy/Caddyfile and modify `root * /srv/http/example.com`
- systemctl start caddy
