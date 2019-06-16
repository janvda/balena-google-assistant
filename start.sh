#!/bin/bash

if [ "$GOOGLE_ASSISTANT_CREDENTIALS2" != '' ]; then
    echo "Creating the credentials.json using device service variable GOOGLE_ASSISTANT_CREDENTIALS ..."
    mkdir -p /root/.config/google-oauthlib-tool/
    echo $GOOGLE_ASSISTANT_CREDENTIALS > /root/.config/google-oauthlib-tool/credentials.json
else
    echo "Device Service Variable 'GOOGLE_ASSISTANT_CREDENTIALS' is not set !"
    if [ "$GOOGLE_ASSISTANT_CLIENT_SECRET" != '' ]; then
        echo "Creating /client_secret.json fbased on the contents of device service variables GOOGLE_ASSISTANT_CLIENT_SECRET..."
        echo $GOOGLE_ASSISTANT_CLIENT_SECRET >  /client_secret.json   #/$GOOGLE_ASSISTANT_CLIENT_SECRET_FILENAME
        echo "You can now create the google credentials by running the the script /create_credentials.sh in a balena terminal for the container main."
        bash
        sleep 3600
    else
        echo "In order to create credentials (for device service variable 'GOOGLE_ASSISTANT_CREDENTIALS'), you must set the Device Service Variable 'GOOGLE_ASSISTANT_CLIENT_SECRET' to the client secret !"
        echo "TBD"
    fi
fi

bash
sleep 3600