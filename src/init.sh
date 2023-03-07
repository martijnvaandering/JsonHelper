#!/bin/bash
echo $cli;
if [ $cli = "true" ]; then
    bash
    exit 0;
fi
/etc/init.d/nginx start
/etc/init.d/fcgiwrap restart
chgrp nginx /var/run/fcgiwrap.socket
chmod g+w /var/run/fcgiwrap.socket
/etc/init.d/nginx restart
tail -f /var/log/nginx/access.log -f /var/log/nginx/error.log