#!/bin/bash

source /env/bin/activate 
google-oauthlib-tool --scope https://www.googleapis.com/auth/assistant-sdk-prototype \
                     --scope https://www.googleapis.com/auth/gcm \
                     --save --headless --client-secrets /client_secret.json 