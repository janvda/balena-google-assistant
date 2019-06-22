#!/bin/bash

CREDENTIALS_FILE_PATH=/root/.config/google-oauthlib-tool
CREDENTIALS_FILE="$CREDENTIALS_FILE_PATH"/credentials.json

if [ "$GOOGLE_ASSISTANT_DEVICE_MODEL_ID" = '' ]; then
    echo "ERROR: The device service variable 'GOOGLE_ASSISTANT_DEVICE_MODEL_ID' is not set.  This variable must be set for the service 'google_assistant'"
    sleep 600
    exit 1
fi

if [ "$GOOGLE_ASSISTANT_PROJECT_ID" = '' ]; then
    echo "ERROR: device service variable 'GOOGLE_ASSISTANT_PROJECT_ID' is not set.  This variable must be set for the service 'google_assistant'"
    sleep 600
    exit 1
fi

if [ "$GOOGLE_ASSISTANT_CREDENTIALS" != '' ]; then
    echo "Creating or overwriting the $CREDENTIALS_FILE with contents of device service variable GOOGLE_ASSISTANT_CREDENTIALS ..."
    mkdir -p $CREDENTIALS_FILE_PATH
    echo $GOOGLE_ASSISTANT_CREDENTIALS > $CREDENTIALS_FILE
fi

if [ -f "$CREDENTIALS_FILE"  ]; then
    echo "Starting googlesamples-assistant-hotword ..."
    source /env/bin/activate 
    googlesamples-assistant-hotword --project-id $GOOGLE_ASSISTANT_PROJECT_ID --device-model-id $GOOGLE_ASSISTANT_DEVICE_MODEL_ID
    echo "ERROR: googlesamples-assistant-hotword terminated unexpectedly."
    sleep 3600
else
    echo "The credentials ($CREDENTIALS_FILE) are not set !"
    if [ "$GOOGLE_ASSISTANT_CLIENT_SECRET" != '' ]; then
        echo "... Creating /client_secret.json based on the contents of device service variables GOOGLE_ASSISTANT_CLIENT_SECRET..."
        echo $GOOGLE_ASSISTANT_CLIENT_SECRET >  /client_secret.json 
        echo "**********************************************************************"
        echo "* You can now create the google credentials by launching the script: *"
        echo "*                 /create_credentials.sh                             *"
        echo "* in a balena terminal for the service 'google_assistant'.           *"
        echo "**********************************************************************"
        bash
        sleep 3600
    else
        echo "In order to create the credentials, you must set the Device Service Variable 'GOOGLE_ASSISTANT_CLIENT_SECRET' to the client secret !"
        sleep 600
        exit 1
    fi
fi
