#!/bin/bash
# Resolve Gemini API key from 1Password via service account (personal machines only).
# On machines without the keychain entry, this is a no-op and node runs normally.
OP_SERVICE_ACCOUNT_TOKEN=$(security find-generic-password -a 'cerebrau-op' -s 'cerebrau-op' -w 2>/dev/null)
if [ -n "$OP_SERVICE_ACCOUNT_TOKEN" ]; then
  export OP_SERVICE_ACCOUNT_TOKEN
  export GEMINI_API_KEY=$(op read 'op://Cerebrau/gemini-api-key/credential' 2>/dev/null)
fi
exec node "$@"
