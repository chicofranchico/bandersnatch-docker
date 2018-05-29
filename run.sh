#!/bin/bash

set -e

if [ "x$LOGNAME" == "xroot" ]; then
    chown user:user /srv/pypi
    exec su user -c "$0 $@"
fi

. /home/user/bandersnatch/bin/activate
bandersnatch mirror
