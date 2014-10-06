#!/bin/bash

ADMIN="admin@${FQDN-example.org}"
PASSWD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

/opt/strider/node_modules/strider/bin/strider addUser \
  --email $ADMIN --password $PASSWD --admin true

echo "Admin User: $ADMIN, Admin Pass: $PASSWD"

/opt/strider/node_modules/strider/bin/strider
