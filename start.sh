#!/bin/bash

if [ "$GOOGLE_ASSISTANT_CREDENTIALS2" != '' ]; then
    echo "Creating the credentials.json using device service variable GOOGLE_ASSISTANT_CREDENTIALS ..."
    mkdir -p /root/.config/google-oauthlib-tool/
    echo $GOOGLE_ASSISTANT_CREDENTIALS > /root/.config/google-oauthlib-tool/credentials.json
else
    echo "Device Service Variable 'GOOGLE_ASSISTANT_CREDENTIALS' is not set !"
    if [ "$GOOGLE_ASSISTANT_CLIENT_SECRET" != '' ]; then
      if [ "$GOOGLE_ASSISTANT_CLIENT_SECRET_FILENAME" != '' ]; then
        echo "Creating the client_secret_... file based on the contents  device service variables GOOGLE_ASSISTANT_CLIENT_SECRET and GOOGLE_ASSISTANT_CLIENT_SECRET_FILENAME"
        echo $GOOGLE_ASSISTANT_CLIENT_SECRET >  /client_secret.json   #/$GOOGLE_ASSISTANT_CLIENT_SECRET_FILENAME
        source /env/bin/activate 
        google-oauthlib-tool --scope https://www.googleapis.com/auth/assistant-sdk-prototype \
                             --scope https://www.googleapis.com/auth/gcm \
                             --save --headless --client-secrets /client_secret.json # /$GOOGLE_ASSISTANT_CLIENT_SECRET_FILENAME
      else
        echo "In order to create credentials, you must set the Device Service Variable 'GOOGLE_ASSISTANT_CLIENT_SECRET_FILENAME' to the client secret filename !"
      fi
    else
       echo "TBD"
    fi
fi

bash
sleep 3600