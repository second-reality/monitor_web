#!/usr/bin/env bash

set -euo pipefail

if [ -z "${DISABLE_CONTAINER_CHECK:-}" ]; then
    ./container.sh ./update.sh
    exit 0
fi

if [ $# -ne 1 ]; then
    echo "usage: passphrase"
    exit 1
fi

passphrase=$1;shift

rm -f page.txt page.png
gpg --quiet --batch --yes --decrypt --passphrase="$passphrase" --output ./credentials.txt ./credentials.txt.gpg
gpg --quiet --batch --yes --decrypt --passphrase="$passphrase" --output ./config.ovpn ./config.ovpn.gpg
openvpn config.ovpn &
sleep 10
rm -f credentials.txt config.ovpn

echo
curl https://ipinfo.io/ip
echo
#su user -c \
#'xvfb-run cutycapt --url=https://gointernational.ca/programs/canada-working-holiday-program-sponsored/ --user-agent="Mozilla/5.0 (Windows NT 11.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.6998.166 Safari/537.36" --out=/tmp/page.png --delay=10000'
#mv /tmp/page.png page.png
elinks https://gointernational.ca/programs/canada-working-holiday-program-sponsored/ -dump > page.txt

pkill openvpn
