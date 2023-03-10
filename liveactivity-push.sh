#!/bin/sh
# P8 file path
P8_FILE="./party/sandbox.p8"
AUTH_KEYID="M57BWJ3LT5"
AUTH_TEAMID="HQUMU47JDU"

# for Live Activity
TOPIC="bundle-id"
PUSH_TYPE="liveactivity"
# token
TOKEN="804f8a2dac2d3a5dd62dae2a93b1eb4847e52e51ffa64cc1839e8e10a4dc54934d9795d6452a7fe1a65934a7d52094d3c46f9988e7cc2bccbac0b9fec60a7639aea8c176530969e5f9ddc2b6f3a320cd"

# production environment
# APNS_HOST_NAME=api.push.apple.com
# development environment
APNS_HOST_NAME=api.development.push.apple.com

timestamp=$(date +%s)
read -r -d '' PAYLOAD <<-'EOF'
{
    "aps": {
        "timestamp": tttttttimestamp,
        "event": "update",
        "content-state": {
            "friends": [
                {
                    "name": "tttttttimestamp",
                    "online": false
                },
                {
                    "name": "Dart2",
                    "online": true
                }
            ]
        },
        "alert": {
            "title": "Delivery Update",
            "body": "Your pizza order will arrive soon.",
            "sound": "push.caf" 
        }
    }
}
EOF
PAYLOAD=${PAYLOAD//tttttttimestamp/${timestamp}}
python3 -c "import sys,json;p=r'''${PAYLOAD}''';print(p);json.loads(p);"

# --------------------------------------------------------------------------
base64() {
   openssl base64 -e -A | tr -- '+/' '-_' | tr -d =
}

sign() {
   printf "$1"| openssl dgst -binary -sha256 -sign "$P8_FILE" | base64
}

TIMESTAMP=$(date +%s)
HEADER=$(printf '{ "alg": "ES256", "kid": "%s" }' "$AUTH_KEYID" | base64)
CLAIMS=$(printf '{ "iss": "%s", "iat": %d }' "$AUTH_TEAMID" "$TIMESTAMP" | base64)
JWT="$HEADER.$CLAIMS.$(sign $HEADER.$CLAIMS)"

curl \
    --header "content-type: application/json" \
    --header "authorization: bearer $JWT" \
    --header "apns-topic: $TOPIC.push-type.liveactivity" \
    --header "apns-push-type: ${PUSH_TYPE}" \
    --data "$PAYLOAD" \
    --http2 https://$APNS_HOST_NAME/3/device/$TOKEN
