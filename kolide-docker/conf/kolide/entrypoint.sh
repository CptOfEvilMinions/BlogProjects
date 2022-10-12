#!/bin/bash
set -e

RESULT=`mysql --user=kolide --password=kolide --host=mysql kolide -e "SELECT table_name FROM information_schema.tables WHERE table_schema='kolide'"`
echo $RESULT

if [ "$RESULT" == "" ]; then
    echo "The Kolide database needs to be initialized"

    echo "Initalizing database now"
    /usr/bin/fleet prepare db --config /etc/kolide/kolide.yml
else
    echo "The Kolide database has been setup"
fi

# Start Kolde
/usr/bin/fleet serve --config /etc/kolide/kolide.yml
