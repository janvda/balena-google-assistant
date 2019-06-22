#!/bin/bash

source /env/bin/activate 
google-oauthlib-tool --scope https://www.googleapis.com/auth/assistant-sdk-prototype \
                     --scope https://www.googleapis.com/auth/gcm \
                     --save --headless --client-secrets /client_secret.json 

echo "The credentials ="
cat /root/.config/google-oauthlib-tool/credentials.json
echo ""
echo ""
echo "You should now restart the google_assistant service !"
