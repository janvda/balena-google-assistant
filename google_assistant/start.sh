#!/bin/bash

if [ "$GOOGLE_ASSISTANT_DEVICE_MODEL_ID" = '' ]; then
    echo "ERROR: The device service variable 'GOOGLE_ASSISTANT_DEVICE_MODEL_ID' is not set.  This variable must be set for the service 'google_assistant'"
    sleep 600
    exit 1
fi

if [ "$GOOGLE_ASSISTANT_PROJECT_ID" = '' ]; then
    echo "ERROR: The device service variable 'GOOGLE_ASSISTANT_PROJECT_ID' is not set.  This variable must be set for the service 'google_assistant'"
    sleep 600
    exit 1
fi

if [ "$GOOGLE_ASSISTANT_CREDENTIALS" != '' ]; then
    echo "Creating the /root/.config/google-oauthlib-tool/credentials.json using device service variable GOOGLE_ASSISTANT_CREDENTIALS ..."
    mkdir -p /root/.config/google-oauthlib-tool/
    echo $GOOGLE_ASSISTANT_CREDENTIALS > /root/.config/google-oauthlib-tool/credentials.json
    echo "Starting googlesamples-assistant-hotword ..."
    source /env/bin/activate 
    googlesamples-assistant-hotword --project-id $GOOGLE_ASSISTANT_PROJECT_ID --device-model-id $GOOGLE_ASSISTANT_DEVICE_MODEL_ID
    echo "ERROR: googlesamples-assistant-hotword terminated unexpectedly."
    sleep 3600
else
    echo "Device Service Variable 'GOOGLE_ASSISTANT_CREDENTIALS' is not set !"
    if [ "$GOOGLE_ASSISTANT_CLIENT_SECRET" != '' ]; then
        echo "Creating /client_secret.json based on the contents of device service variables GOOGLE_ASSISTANT_CLIENT_SECRET..."
        echo $GOOGLE_ASSISTANT_CLIENT_SECRET >  /client_secret.json   #/$GOOGLE_ASSISTANT_CLIENT_SECRET_FILENAME
        echo "You can now create the google credentials by launching the script /create_credentials.sh in a balena terminal for the service 'google_assistant'."
        bash
        sleep 3600
    else
        echo "In order to create the credentials (for device service variable 'GOOGLE_ASSISTANT_CREDENTIALS'), you must set the Device Service Variable 'GOOGLE_ASSISTANT_CLIENT_SECRET' to the client secret !"
        sleep 600
        exit 1
    fi
fi
